package com.board.hj.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.board.hj.domain.Member;
import com.board.hj.service.MemberService;

@SessionAttributes("member")
@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;

	@ModelAttribute("member")
	public Member getMember() {
		return new Member();
	}
	
	//메인 페이지로 이동
	@GetMapping("/main")
	public String mainView(HttpServletResponse response, HttpServletRequest request, HttpSession session, Model model, Member member) {
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {	
			String cookie_id = "";
			String cookie_pw = "";
			
			for(Cookie c : cookies) {
				if(c.getName().equals("cookie_id")) {
					cookie_id = c.getValue();
				}
				if(c.getName().equals("cookie_pw")) {
					cookie_pw = c.getValue();
				}
			}
			Member findMember = memberService.findIdPw(cookie_id, cookie_pw);
			if (findMember != null) {
				model.addAttribute("member", findMember);
				session.setAttribute("member", findMember);
			}
		}
		return "main";
	}	
	
	//로그인 페이지로 이동
	@GetMapping("/loginView")
	public String loginView() {
		return "member/loginView";
	}

	//로그인
	@RequestMapping("/login")
	public String login(@ModelAttribute("member") Member member, Model model,
			@RequestParam(name="cookie", required=false, defaultValue="0") int cookie, HttpServletResponse response, HttpSession session) {
		Member findMember = memberService.getMember(member);

		//로그인 성공
		if (findMember != null && findMember.getMempw().equals(member.getMempw())) {
			model.addAttribute("member", findMember);

			//쿠키 생성 
			if (cookie == 1) {
				//Cookie cookie_login = new Cookie("cookie_login", session.getId());
				//cookie_login.setMaxAge(60*60*24*7); //7일 쿠키 유지 cookie_id.setPath("/");
				//response.addCookie(cookie_login);
				 				
				 Cookie cookie_id = new Cookie("cookie_id", findMember.getId());
				 cookie_id.setMaxAge(60*60*24*7); //7일 쿠키 유지 
				 cookie_id.setPath("/");
				 response.addCookie(cookie_id);
				 
				 Cookie cookie_pw = new Cookie("cookie_pw", findMember.getMempw());
				 cookie_pw.setMaxAge(60*60*24*7); //7일 쿠키 유지 
				 cookie_pw.setPath("/");
				 response.addCookie(cookie_pw);
				 
			 }
			
			return "main";
		}

		//로그인 실패
		else {
			model.addAttribute("msg", "아이디 또는 비밀번호를 확인해주세요.");
			return "member/loginView";
		}
	}

	//로그아웃
	@GetMapping("/logout")
	public String logout( HttpServletRequest request, HttpServletResponse response, SessionStatus status) {
		status.setComplete();// @SessionAttributes를 활용해 Session에 남긴 데이터를 정리
		Cookie[] cookies = request.getCookies();
		
		for(int i = 0; i < cookies.length; i++) {
			cookies[i].setMaxAge(0);
			response.addCookie(cookies[i]);
		}		
		return "redirect:main";
	}
	
	//아이디 찾기 페이지로 이동
	@GetMapping("/findIdView")
	public String findIdView() {		
		return "findIdPw/findId";
	}
	
	//아이디 찾기 - 입력한 이름과 이메일이 일치한 정보가 있는지 확인
	//일치한 정보가 있으면 이메일 인증 시작
	@RequestMapping("/find_name_email")
	@ResponseBody
	public String findId(Model model, @RequestParam Map<String, Object> param) {
		System.out.println(param);
		
		String name = (String) param.get("name"); 
		String mememail = (String) param.get("mememail");
		List<Member> mlist = null;
		 
		mlist = memberService.findId(name, mememail);
		System.out.println(mlist);
		
		if(mlist.isEmpty()) {
			return "fail";
		}else {
			model.addAttribute("mlist",mlist);			
			return "success";
			//return "findIdPw/findId2";
		}
	}
	
	@RequestMapping("/findId")
	public String findId2(Model model, @RequestParam Map<String, Object> param) {
		System.out.println(param);
		
		String name = (String) param.get("name"); 
		String mememail = (String) param.get("mememail");
		List<Member> mlist = null;
		 
		mlist = memberService.findId(name, mememail);
		System.out.println(mlist);
		
		if(mlist.isEmpty()) {
			return "findIdPw/findId";			
		}else {
			model.addAttribute("mlist",mlist);			
			return "findIdPw/findId2";
		}
	}
	
	//비밀번호 찾기 페이지로 이동
	@GetMapping("/findPwView")
	public String findPwView() {
		return "findIdPw/findPw";
	}
	
	@RequestMapping("/findPw")
	public String findPw(Model model, @RequestParam Map<String, Object> param) {
		System.out.println(param);
		
		String id = (String) param.get("id"); 
		String name = (String) param.get("name"); 
		String mememail = (String) param.get("mememail");
		Member findMember = memberService.findPw(id, name, mememail);
		System.out.println(findMember);
		
		//찾기 성공
		if (findMember != null) {
			System.out.println(findMember);
			model.addAttribute("member", findMember);
			
			return "findIdPw/findPw2";
		}
		
		//찾기 실패
		else {
			model.addAttribute("msg", "회원정보를 다시 확인해주세요.");
			return "findIdPw/findPw2";
		}		
	}
	
}
