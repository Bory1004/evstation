package com.board.hj.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.board.hj.domain.FreeBoard;
import com.board.hj.domain.Member;
import com.board.hj.persistence.MemberRepository;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberRepository memberRepo;

	public Member saveMember(Member member) {
		return memberRepo.save(member);
	}
	
	//멤버 하나 불러오기
	@Override
	public Member getMemberOne(Long memnum) {		
		return memberRepo.getById(memnum);
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
	
	//비밀번호 변경
	@Override
	public void updatePw(String id, String pw) {
		memberRepo.updatePw(id, pw);		
	}
	
	//계정삭제
	@Override
	public void delAccount(Long memnum) {
		memberRepo.deleteById(memnum);
	}

	@Override
	public Page<Member> getMemberList(int pNum) {
		Pageable page = PageRequest.of(pNum-1, 10);		
		return memberRepo.findByOrderByMemnumDesc(page);
	}
	
	@Override
	public Page<Member> getMemberList(int pNum, int searchn, String search) {
		Pageable page = PageRequest.of(pNum-1, 10);
		Page<Member> list = null;
		if(searchn == 0) {
			list = memberRepo.findByNameContainingIgnoreCase(search, page);
		}else if(searchn == 1) {
			list = memberRepo.findByIdContainingIgnoreCase(search, page);
		}else if(searchn == 2) {
			list = memberRepo.findByMemphoneContaining(search, page);
		}
		return list;
	}
	
}
