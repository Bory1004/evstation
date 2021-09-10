package com.board.hj.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.hj.domain.Member;
import com.board.hj.persistence.MemberRepository;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberRepository memberRepo;

	@Override
	public Member login(Member member) {
		
		return null;
	}
	
	public Member saveMember(Member member) {
		return memberRepo.save(member);
	}

	@Override
	public Member getMember(Member member) {
		Optional<Member> findMember = memberRepo.findById(member.getId());
		if (findMember.isPresent())
			return findMember.get();
		else
			return null;
	}
	
	@Override
	public Optional<Member> findMember(String id) {
		Optional<Member> member = memberRepo.findById(id);
		return member;
	}
	
	@Override
	public Member findIdPw(String id, String pw) {
		Optional<Member> findMember = memberRepo.findByIdAndMempw(id, pw);
		if(findMember.isPresent())
			return findMember.get();
		else
			return null;
	}
	
	@Override
	public void delete(Member member) {
		memberRepo.delete(member);
	}

}
