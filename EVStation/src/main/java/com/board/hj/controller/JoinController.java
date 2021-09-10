package com.board.hj.controller;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Optional;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.hj.domain.Member;
import com.board.hj.service.MemberService;

@Controller
public class JoinController {

	@Autowired
	private MemberService memberService;
	
	@ModelAttribute("member")
	public Member getMember() {
		Member m = new Member();
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		//Date date = format.format(System.currentTimeMillis());
		//m.setMem_birth(date);
		return m;
	}
	
	//회원가입 페이지로 이동
	@GetMapping("/joinView")
	public String joinView() {
		return "member/joinView";
	}
		
	// 중복 아이디 체크
	@RequestMapping("/check")
	@ResponseBody
	public int check(String id) {
		Optional<Member> member = memberService.findMember(id);
		
		Member mem = member.orElse(new Member());
		
		if(mem.getId() != null) { // 값이 없으면(null) ""로 전송된다.
			// 중복
			return 1;
		} else {
			return 0;
		}
	}
		
	
	@PostMapping("/join")
	public String join(Member member, Model m) {
		//member.setMememail(mememail);
		memberService.saveMember(member);
		
		return "member/join_success";
	}
	
	/*
	 * @GetMapping("/join_success") public String join_success() { return
	 * "member/join_success"; }
	 */
	
	/*
	 * // 유효성 검사
	 * 
	 * @PostMapping(value = "/join_check") public String join_check(@Valid Member
	 * member, BindingResult bindingResult, Model m) { // Validation 결과의 에러의 목록 출력
	 * if (bindingResult.hasErrors()) { List<ObjectError> errors =
	 * bindingResult.getAllErrors(); for (ObjectError error : errors) {
	 * System.out.println(error.getDefaultMessage()); } return "member/joinView"; }
	 * else { System.out.println(member.toString());
	 * memberService.saveMember(member); return "member/join_success"; } }
	 */
	
}