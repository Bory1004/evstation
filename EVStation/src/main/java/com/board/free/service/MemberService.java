package com.board.free.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;

import com.board.free.domain.Member;

public interface MemberService {
	
	Member saveMember(Member member);
	
	Member getMember(Member member);
	
	Member getMemberOne(Long memnum);
	
	//아이디 중복확인
	Optional<Member> findMember(String id);
	
	Member findIdPw(String id, String pw);
	
	void delete(Member member);
	
	//아이디 찾기
	List<Member> findId(String name, String mememail);
	
	//비밀번호 찾기
	Member findPw(String id, String name, String mememail);
	
	//비밀번호 변경
	void updatePw(String id, String pw);

	void delAccount(Long memnum);
	
	//멤버 리스트
	Page<Member> getMemberList(int pNum, int searchn, String search);
	Page<Member> getMemberList(int pNum);
}
