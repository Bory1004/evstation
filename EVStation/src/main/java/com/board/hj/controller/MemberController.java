package com.board.hj.controller;

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

import com.board.KW.domain.Charge;
import com.board.KW.service.ChargeService;
import com.board.ay.service.NoticeCommentService;
import com.board.ds.service.DsCommentService;
import com.board.ds.service.DsService;
import com.board.hj.domain.Member;
import com.board.hj.service.FreeBoardService;
import com.board.hj.service.FreeCommentService;
import com.board.hj.service.MemberService;
import com.board.km.service.AlarmService;
import com.board.km.service.CommentService;
import com.board.km.service.ReviewService;

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
	private CommentService commentService;
	@Autowired
	private FreeBoardService freeboardService;
	@Autowired
	private FreeCommentService freecommentService;
	@Autowired
	private DsService dsService;
	@Autowired
	private DsCommentService dscommentService;
	@Autowired
	private NoticeCommentService noticecommentService;

	@ModelAttribute("member")
	public Member getMember() {
		return new Member();
	}

	// ?????? ???????????? ??????
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
		return "main";
	}

	// ????????? ???????????? ??????
	@GetMapping("/loginView")
	public String loginView() {
		return "member/loginView";
	}

	// ?????????
	@RequestMapping("/login")
	public String login(@ModelAttribute("member") Member member, Model model,
			@RequestParam(name = "cookie", required = false, defaultValue = "0") int cookie,
			HttpServletResponse response, HttpSession session) {
		
		Member findMember = memberService.getMember(member);
		
		// ????????? ??????
		if (findMember != null && findMember.getMempw().equals(member.getMempw())) {
			model.addAttribute("member", findMember);

			// ?????? ??????
			if (cookie == 1) {
				// Cookie cookie_login = new Cookie("cookie_login", session.getId());
				// cookie_login.setMaxAge(60*60*24*7); //7??? ?????? ?????? cookie_id.setPath("/");
				// response.addCookie(cookie_login);

				Cookie cookie_id = new Cookie("cookie_id", findMember.getId());
				cookie_id.setMaxAge(60 * 60 * 24 * 7); // 7??? ?????? ??????
				cookie_id.setPath("/");
				response.addCookie(cookie_id);

				Cookie cookie_pw = new Cookie("cookie_pw", findMember.getMempw());
				cookie_pw.setMaxAge(60 * 60 * 24 * 7); // 7??? ?????? ??????
				cookie_pw.setPath("/");
				response.addCookie(cookie_pw);
			}
			return "main";
		}

		// ????????? ??????
		else {
			model.addAttribute("msg", "????????? ?????? ??????????????? ??????????????????.");
			return "member/loginView";
		}
	}

	// ????????????
	@GetMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response, SessionStatus status) {
		status.setComplete();// @SessionAttributes??? ????????? Session??? ?????? ???????????? ??????
		Cookie[] cookies = request.getCookies();

		for (int i = 0; i < cookies.length; i++) {
			cookies[i].setMaxAge(0);
			response.addCookie(cookies[i]);
		}
		return "redirect:main";
	}

	// ??????????????? ????????? ???????????? ?????? ???????????? ??????
	@GetMapping("/check_mypage")
	public String check_mypage() {
		return "member/check_mypage";
	}

	// ???????????? ?????? ???, ??????????????? ??????
	@RequestMapping("/mypage")
	public String checkPw_mypage(@ModelAttribute("member") Member member, Model m) {

		// ??????
		DateFormat format = new SimpleDateFormat("yyyyMMdd");
		String birth = format.format(member.getMembirth());
		m.addAttribute("birth", birth);

		// ?????????
		String mem_email = member.getMememail();
		String[] email = mem_email.split("@");
		m.addAttribute("email1", email[0]);
		m.addAttribute("email2", email[1]);

		return "member/mypage";
	}

	// ???????????? ??????
	@PostMapping("/update_mypage")
	public String update_mypage(@ModelAttribute("member") Member member) {
		memberService.saveMember(member);
		return "redirect:mypage";
	}

	// ????????? ??????
	@PostMapping("/update_photo")
	public String update_photo(@ModelAttribute("member") Member member, @RequestParam("file_photo") MultipartFile file, HttpServletRequest request)
			throws Exception {
		System.out.println(file.getOriginalFilename());
		System.out.println(file.getSize());
		
		String uploadPath = request.getSession().getServletContext().getRealPath("/").concat("resources/profile");
		System.out.println(uploadPath);
		
		String fileName = null; // ?????? ????????? ????????? ???????????? ?????? + ????????????

		if (file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
			// ?????? ??????????????? ????????? ????????? ?????????(=????????? ????????? ????????? ?????????)
			String[] file_fullname = file.getOriginalFilename().split("\\.");
			fileName = member.getId()+"."+file_fullname[1];
			File file_photo = new File(uploadPath, fileName);
			file.transferTo(file_photo);
			
			// ?????? ?????? ?????? + ????????? ??????
			member.setMemphoto(request.getContextPath()+"/resources/profile/"+fileName);
			memberService.saveMember(member);
		} else { // ????????? ????????? ?????????
			fileName = "/profile/basic.png";
			// ?????? ????????? none.png????????? ?????? ?????????

			member.setMemphoto(fileName);
			memberService.saveMember(member);
		}
		System.out.println("fileName : " + fileName);

		return "redirect:mypage";
	}
	//???????????? 
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
