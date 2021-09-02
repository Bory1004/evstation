package com.board.ay.persistence;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.board.ay.domain.Board;

public interface BoardRepository extends JpaRepository<Board, Long>{
	
	Page<Board> findByOrderByNumAsc(Pageable page);
	
	@Transactional
	@Modifying
	@Query("UPDATE Board b SET b.cnt = b.cnt+1 WHERE b.num=?1")
	int updateCnt(Long num);
	
	@Transactional
	@Modifying
	@Query("UPDATE Board b SET b.recom = b.recom+1 WHERE b.num=?1")
	int upRecom(Long num);
	
	
	Page<Board> findByTitleContainingIgnoreCase(String title,Pageable page);
	Page<Board> findByContentContainingIgnoreCase(String content,Pageable page);

	
	
	
}
