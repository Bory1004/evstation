package com.board.hj.persistence;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.board.hj.domain.Member;

public interface MemberRepository extends JpaRepository<Member, Long> {

	Optional<Member> findById(String id);
	
	Optional<Member> findByIdAndMempw(String id, String mempw);
	
}