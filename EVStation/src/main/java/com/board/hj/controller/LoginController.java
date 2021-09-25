package com.board.hj.controller;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.hj.domain.Member;
import com.board.hj.service.MemberService;

@Controller
public class LoginController {

	@Autowired
	private MemberService memberService;

	@ModelAttribute("member")
	public Member getMember() {
		return new Member();
	}

	//회원가입 페이지로 이동
	@GetMapping("/joinView")
	public String joinView() {
		return "member/joinView";
	}

	//중복 아이디 체크
	@RequestMapping("/check")
	@ResponseBody
	public int check(String id) {
		Optional<Member> member = memberService.findMember(id);
		Member mem = member.orElse(new Member());

		if (mem.getId() != null) { // 값이 없으면(null) ""로 전송된다.
			// 중복
			return 1;
		} else {
			return 0;
		}
	}

	@PostMapping("/join")
	public String join(Member member, Model m) {
		memberService.saveMember(member);
		return "member/join_success";
	}

	//아이디 찾기 페이지로 이동
	@GetMapping("/findIdView")
	public String findIdView() {
		return "/member/findIdPw/findId";
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

		if (mlist.isEmpty()) {
			return "fail";
		} else {
			model.addAttribute("mlist", mlist);
			return "success";
			// return "findIdPw/findId2";
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

		if (mlist.isEmpty()) {
			return "/member/findIdPw/findId";
		} else {
			model.addAttribute("mlist", mlist);
			return "/member/findIdPw/findId2";
		}
	}

	//아이디 찾기 후 비밀번호 찾기 페이지 이동
	@RequestMapping("/findIdPw")
	public String findIdPw(@RequestParam(name = "findId", required = false) String findId, Model model) {
		model.addAttribute("id", findId);
		return "/member/findIdPw/findId3";
	}

	//비밀번호 변경
	@RequestMapping(value = { "/findIdPw_newPw", "/findPw_newPw" })
	public String findIdPw_newPw(@RequestParam(name = "id", required = false) String id,
			@RequestParam(name = "mempw", required = false) String pw) {
		memberService.updatePw(id, pw);
		return "member/loginView";
	}

	//바로 비밀번호 찾기 페이지로 이동
	@GetMapping("/findPwView")
	public String findPwView() {
		return "member/findIdPw/findPw";
	}

	//비밀번호 찾기
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
			model.addAttribute("id", id);
			return "member/findIdPw/findId3";
		}

		//찾기 실패
		else {
			model.addAttribute("msg", "회원정보를 다시 확인해주세요.");
			return "member/findIdPw/findPw2";
		}
	}
}