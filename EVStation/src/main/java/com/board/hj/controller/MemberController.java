package com.board.hj.controller;


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

	//마이페이지 가기전 비밀번호 입력 페이지로 이동
	@GetMapping("/check_mypage")
	public String check_mypage() {
		return "member/check_mypage";
	}
	
	// 마이페이지 가기전 비밀번호 입력 페이지로 이동
	@GetMapping("/checkPw_mypage")
	public String checkPw_mypage(@ModelAttribute("member") Member member) {
		//Member findMember = memberService.findIdPw();
		return "member/check_mypage";
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
		return "main";
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
			return "main";
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
	
	//회원탈퇴 
	@RequestMapping("/withdrawForm")
	public String withdrawForm() {
		return "member/withdrawForm";
	}
	@RequestMapping("/withdraw/{memnum}")
	public String withdraw(@PathVariable Long memnum){
		memberService.delAccount(memnum);
		return "member/withdrawComplete";
	}

}
