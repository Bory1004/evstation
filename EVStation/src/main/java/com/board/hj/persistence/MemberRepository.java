package com.board.hj.persistence;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.board.hj.domain.Member;

public interface MemberRepository extends JpaRepository<Member, Long> {

	Optional<Member> findById(String id);
	
	Optional<Member> findByIdAndMempw(String id, String mempw);
	
	//아이디 찾기
	List<Member> findByNameAndMememail(String name, String mememail);
	
	//비밀번호 찾기
	Optional<Member> findByIdAndNameAndMememail(String id, String name, String mememail);
}