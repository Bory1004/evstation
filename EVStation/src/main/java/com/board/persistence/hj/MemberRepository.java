package com.board.persistence.hj;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.board.domain.hj.Member;

public interface MemberRepository extends JpaRepository<Member, Long> {

	Optional<Member> findById(String id);
	
}