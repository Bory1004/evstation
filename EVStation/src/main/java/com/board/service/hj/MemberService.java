package com.board.service.hj;

import java.util.Optional;

import com.board.domain.hj.Member;

public interface MemberService {
	Member login(Member member);
	
	Member saveMember(Member member);

	Member getMember(Member member);
	
	Optional<Member> findMember(String id);
	
	void delete(Member member);
}
