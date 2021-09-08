package com.board.controller.hj;

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

import com.board.domain.hj.Member;
import com.board.service.hj.MemberService;

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
	@RequestMapping("/check_id")
	@ResponseBody
	public String check_id(String id) {
		Optional<Member> member = memberService.findMember(id);
		Member mem = member.orElse(new Member());
		return mem.getId();// 값이 없으면(null) ""로 전송된다.
	}

	// 유효성 검사
	@PostMapping(value = "/join_check")
	public String join_check(@Valid Member member, BindingResult bindingResult, Model m) {
		// Validation 결과의 에러의 목록 출력
		if (bindingResult.hasErrors()) {
			List<ObjectError> errors = bindingResult.getAllErrors();
			for (ObjectError error : errors) {
				System.out.println(error.getDefaultMessage());
			}
			return "member/joinView";
		} else {
			System.out.println(member.toString());
			memberService.saveMember(member);
			return "member/join_success";
		}
	}
}