package com.board.ay.service;

import java.util.Optional;

import com.board.ay.domain.Member;

public interface MemberService {
	Member saveMember(Member member);

	Member getMember(Member member);

	void deleteById(String id);

	Optional<Member> findMember(String id);


}
