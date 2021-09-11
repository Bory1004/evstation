package com.board.ay.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.board.ay.domain.Member;
import com.board.ay.service.MemberService;

@SessionAttributes("member")
@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@ModelAttribute("member")
	public Member getMember() {
		return new Member();
	}
	// session에 "member" 객체가 이미 존재할 경우 method는 실행되지 않음.
	
	@GetMapping("/joinView")
	public String View() {
		return "member/joinView";
	}
	@RequestMapping("/check_id")
	@ResponseBody
	public String check_id(String id) {
	
		Optional<Member> member = memberService.findMember(id);
		Member mem =  member.orElse(new Member());
		return mem.getId();//값이 없으면(null) ""로 전송된다.
	}
	
	@PostMapping("/join")
	public String join(Member member, Model m) {
		Member mem = memberService.saveMember(member);
		return "redirect:loginform";
	}
	
	@GetMapping("/loginform")
	public String loginView(@ModelAttribute("member") Member member) {
		System.out.println(member.getId());
		return "ayboard/member/loginView";
	}
	
	@RequestMapping("/login")
	public String login(Member member, Model model) {
		Member findMember = memberService.getMember(member);
	
		if (findMember != null && findMember.getPassword().equals(member.getPassword())) {
			model.addAttribute("member", findMember);
			return "redirect:getBoardList";
		} else {
			return "redirect:loginform";
		}
	}
	@GetMapping("/logout")
	public String logout(SessionStatus status) {
		status.setComplete();
		return "redirect:index.html";		
	}
	@GetMapping("/modiForm")
	public String modiForm() {
		return "member/modiForm";
	}
	@GetMapping("/withdrawForm")
	public String withdraw(Member member) {
		memberService.deleteById(member.getId());
		return "redirect:index.html";
	}
	
}
