package com.board.free.persistence;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.board.free.domain.FreeBoard;
import com.board.free.domain.Member;

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
	
	Page<Member> findByOrderByMemnumDesc(Pageable page);
	
	Page<Member> findByNameContainingIgnoreCase(String name,Pageable page);
	Page<Member> findByIdContainingIgnoreCase(String id,Pageable page);
	Page<Member> findByMemphoneContaining(String phone,Pageable page);
	
	
}