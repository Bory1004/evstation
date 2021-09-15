package com.board.hj.persistence;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.board.hj.domain.FreeBoardComment;

public interface FreeCommentRepository extends JpaRepository<FreeBoardComment, Long>{
	
	//모든 댓글
	Page<FreeBoardComment> findByOrderByComnumAsc(Pageable page);
	
	//해당 게시물의 댓글
	Page<FreeBoardComment> findByBoardnumOrderByComnumAsc(Pageable page, Long boardnum);
	
	//Page<FreeBoardComment> findByBoardnumOrderByComnumAsc(Pageable page, Long boardnum);
	
	@Transactional
	@Modifying
	@Query("UPDATE BoardComment d SET d.comcontent = ?2 WHERE d.comnum = ?1")
	void updateComment(Long comnum, String comcontent);
}