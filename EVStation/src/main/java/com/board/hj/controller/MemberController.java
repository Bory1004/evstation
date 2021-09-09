package com.board.hj.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
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
		Member m = new Member();

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		// Date date = format.format(System.currentTimeMillis());
		// m.setMem_birth(date);
		return m;
	}
	
	
	//자동로그인
	private Map<String, Cookie> cookieMap = new java.util.HashMap<String, Cookie>();
	
	@GetMapping("/mainCookie")
	public String mainCookie(String id, String pw) throws UnsupportedEncodingException {
		//매개변수로 전달받은 이름의 쿠키 유무. true:쿠키있음, false:쿠키없음
		if(cookieMap.get(id) == null) {
			return null;
		}
		//매개변수로 전달받은 이름의 쿠키의 값을 리턴		
		Cookie cookie = cookieMap.get(id);
		return URLDecoder.decode(cookie.getValue(), "utf-8");
	}
	
	
	// 로그인 페이지로 이동
	@GetMapping("/loginView")
	public String loginView(@ModelAttribute("member") Member member) {
		return "member/loginView";
	}

	// 로그인
	@RequestMapping("/login")
	public String login(HttpServletResponse response, Member member, Model model) {
		Member findMember = memberService.getMember(member);

		// 로그인 성공
		if (findMember != null && findMember.getMempw().equals(member.getMempw())) {
			model.addAttribute("member", findMember);

			/*
			 * //쿠키 생성 if (cookie.equals("check")) { Cookie idcookie = new Cookie("id",findMember.getId());
			 *  Cookie pwcookie = new Cookie("pw", findMember.getMempw());
			 * 
			 * response.addCookie(idcookie); response.addCookie(pwcookie); }
			 */

			return "redirect:getBoardList";
		}

		// 로그인 실패
		else {
			model.addAttribute("msg", "아이디 또는 비밀번호를 확인해주세요.");
			return "member/loginView";
		}
	}

	// 로그아웃
	@GetMapping("/logout")
	public String logout(SessionStatus status) {
		status.setComplete();// @SessionAttributes를 활용해 Session에 남긴 데이터를 정리
		
		return "redirect:index.html";
	}
}
