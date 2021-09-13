package com.board.hj.persistence;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.board.hj.domain.Member;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {

	Optional<Member> findById(String id);
	
	Optional<Member> findByIdAndMempw(String id, String mempw);
	
	//아이디 찾기
	List<Member> findByNameAndMememail(String name, String mememail);
	
	//비밀번호 찾기
	Optional<Member> findByIdAndNameAndMememail(String id, String name, String mememail);
	
	@Transactional
	@Modifying
	@Query("UPDATE Member m SET m.mempw = ?2 WHERE m.id=?1")
	void updatePw(String memnum, String pw);
	
}