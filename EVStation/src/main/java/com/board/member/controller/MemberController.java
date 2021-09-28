package com.board.member.controller;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import com.board.charge.domain.Charge;
import com.board.charge.service.ChargeService;
import com.board.member.domain.Member;
import com.board.free.service.FreeBoardService;
import com.board.free.service.FreeCommentService;
import com.board.member.service.MemberService;
import com.board.notice.service.NoticeCommentService;
import com.board.qna.service.QnACommentService;
import com.board.qna.service.QnABoardService;
import com.board.review.service.AlarmService;
import com.board.review.service.ReviewCommentService;
import com.board.review.service.ReviewService;

@SessionAttributes("member")
@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private ChargeService chargeService;
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private AlarmService alarmService;
	@Autowired
	private ReviewCommentService commentService;
	@Autowired
	private FreeBoardService freeboardService;
	@Autowired
	private FreeCommentService freecommentService;
	@Autowired
	private QnABoardService dsService;
	@Autowired
	private QnACommentService dscommentService;
	@Autowired
	private NoticeCommentService noticecommentService;

	@ModelAttribute("member")
	public Member getMember() {
		return new Member();
	}

	// 메인 페이지로 이동
	@GetMapping("/main")
	public String mainView(HttpServletResponse response, HttpServletRequest request, HttpSession session, Model model,
			Member member) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			String cookie_id = "";
			String cookie_pw = "";

			for (Cookie c : cookies) {
				if (c.getName().equals("cookie_id")) {
					cookie_id = c.getValue();
				}
				if (c.getName().equals("cookie_pw")) {
					cookie_pw = c.getValue();
				}
			}
			Member findMember = memberService.findIdPw(cookie_id, cookie_pw);
			if (findMember != null) {
				model.addAttribute("member", findMember);
				session.setAttribute("member", findMember);
			}
		}
		List<Charge> list = chargeService.openMap();
		model.addAttribute("list", list);
		return "main/main";
	}

	// 로그인 페이지로 이동
	@GetMapping("/loginView")
	public String loginView() {
		return "member/loginView";
	}

	// 로그인
	@RequestMapping("/login")
	public String login(@ModelAttribute("member") Member member, Model model,
			@RequestParam(name = "cookie", required = false, defaultValue = "0") int cookie,
			HttpServletResponse response, HttpSession session) {

		Member findMember = memberService.getMember(member);

		// 로그인 성공
		if (findMember != null && findMember.getMempw().equals(member.getMempw())) {
			model.addAttribute("member", findMember);

			// 쿠키 생성
			if (cookie == 1) {
				// Cookie cookie_login = new Cookie("cookie_login", session.getId());
				// cookie_login.setMaxAge(60*60*24*7); //7일 쿠키 유지 cookie_id.setPath("/");
				// response.addCookie(cookie_login);

				Cookie cookie_id = new Cookie("cookie_id", findMember.getId());
				cookie_id.setMaxAge(60 * 60 * 24 * 7); // 7일 쿠키 유지
				cookie_id.setPath("/");
				response.addCookie(cookie_id);

				Cookie cookie_pw = new Cookie("cookie_pw", findMember.getMempw());
				cookie_pw.setMaxAge(60 * 60 * 24 * 7); // 7일 쿠키 유지
				cookie_pw.setPath("/");
				response.addCookie(cookie_pw);
			}
			return "main/main";
		}

		// 로그인 실패
		else {
			model.addAttribute("msg", "아이디 또는 비밀번호를 확인해주세요.");
			return "member/loginView";
		}
	}

	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response, SessionStatus status) {
		status.setComplete();// @SessionAttributes를 활용해 Session에 남긴 데이터를 정리
		Cookie[] cookies = request.getCookies();

		for (int i = 0; i < cookies.length; i++) {
			cookies[i].setMaxAge(0);
			response.addCookie(cookies[i]);
		}
		return "redirect:main";
	}

	// 마이페이지 가기전 비밀번호 입력 페이지로 이동
	@GetMapping("/check_mypage")
	public String check_mypage() {
		return "member/check_mypage";
	}

	// 비밀번호 입력 후, 마이페이지 이동
	@RequestMapping("/mypage")
	public String checkPw_mypage(@ModelAttribute("member") Member member, Model m) {

		// 생일
		DateFormat format = new SimpleDateFormat("yyyyMMdd");
		String birth = format.format(member.getMembirth());
		m.addAttribute("birth", birth);

		// 이메일
		String mem_email = member.getMememail();
		String[] email = mem_email.split("@");
		m.addAttribute("email1", email[0]);
		m.addAttribute("email2", email[1]);

		return "member/mypage";
	}

	// 회원정보 수정
	@PostMapping("/update_mypage")
	public String update_mypage(@ModelAttribute("member") Member member) {
		memberService.saveMember(member);
		return "redirect:mypage";
	}

	// 프로필 변경
	@PostMapping("/update_photo")
	public String update_photo(@ModelAttribute("member") Member member, @RequestParam("file_photo") MultipartFile file,
			HttpServletRequest request) throws Exception {
		System.out.println(file.getOriginalFilename());
		System.out.println(file.getSize());

		String uploadPath = request.getSession().getServletContext().getRealPath("/").concat("resources/profile");
		System.out.println(uploadPath);

		String fileName = null; // 기본 경로와 별개로 작성되는 경로 + 파일이름

		if (file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
			// 파일 인풋박스에 첨부된 파일이 없다면(=첨부된 파일이 이름이 없다면)
			String[] file_fullname = file.getOriginalFilename().split("\\.");
			fileName = member.getId() + "." + file_fullname[1];
			File file_photo = new File(uploadPath, fileName);
			file.transferTo(file_photo);

			// 원본 파일 경로 + 파일명 저장
			member.setMemphoto(request.getContextPath() + "/resources/profile/" + fileName);
			memberService.saveMember(member);
		} else { // 첨부된 파일이 없으면
			fileName = "/profile/basic.png";
			// 미리 준비된 none.png파일을 대신 출력함

			member.setMemphoto(fileName);
			memberService.saveMember(member);
		}
		System.out.println("fileName : " + fileName);

		return "redirect:mypage";
	}

	// 회원탈퇴
	@RequestMapping("/withdrawForm")
	public String withdrawForm() {
		return "member/withdrawForm";
	}

	@RequestMapping("/withdraw/{memnum}")
	@ResponseBody
	public String withdraw(@PathVariable Long memnum) {

		reviewService.withdraw(memnum);
		alarmService.withdraw(memnum);
		commentService.withdraw(memnum);
		freeboardService.withdraw(memnum);
		freecommentService.withdraw(memnum);
		dsService.withdraw(memnum);
		dscommentService.withdraw(memnum);
		noticecommentService.withdraw(memnum);
		
		memberService.delAccount(memnum);
		
		return "success!";
	}

	@RequestMapping("/withdrawCom")
	public String withdrawComplete() {
		return "member/withdrawComplete";

	}
}
