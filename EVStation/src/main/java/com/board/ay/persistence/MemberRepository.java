package com.board.ay.persistence;

import org.springframework.data.jpa.repository.JpaRepository;

import com.board.ay.domain.Member;

public interface MemberRepository extends JpaRepository<Member, String> {

}
