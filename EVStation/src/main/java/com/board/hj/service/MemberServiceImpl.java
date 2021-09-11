package com.board.hj.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.hj.domain.Member;
import com.board.hj.persistence.MemberRepository;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberRepository memberRepo;

	public Member saveMember(Member member) {
		return memberRepo.save(member);
	}
	
	//로그인
	@Override
	public Member getMember(Member member) {
		Optional<Member> findMember = memberRepo.findById(member.getId());
		if (findMember.isPresent())
			return findMember.get();
		else
			return null;
	}
	
	//아이디 중복 확인
	@Override
	public Optional<Member> findMember(String id) {
		Optional<Member> member = memberRepo.findById(id);
		return member;
	}
	
	//로그인(쿠키)
	@Override
	public Member findIdPw(String id, String pw) {
		Optional<Member> findMember = memberRepo.findByIdAndMempw(id, pw);
		if(findMember.isPresent())
			return findMember.get();
		else
			return null;
	}
	
	//탈퇴
	@Override
	public void delete(Member member) {
		memberRepo.delete(member);
	}

	//아이디 찾기
	@Override
	public List<Member> findId(String name, String mememail) {
		List<Member> list = null;
		list = memberRepo.findByNameAndMememail(name, mememail);		
		return list;
	}
	
	//비밀번호 찾기
	@Override
	public Member findPw(String id, String name, String mememail) {
		Optional<Member> findMember = memberRepo.findByIdAndNameAndMememail(id, name, mememail);
		if(findMember.isPresent())
			return findMember.get();
		else
			return null;
	}
}
