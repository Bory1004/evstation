package com.board.hj.persistence;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.board.hj.domain.FreeBoardComment;

public interface FreeCommentRepository extends JpaRepository<FreeBoardComment, Long>{
	
	Page<FreeBoardComment> findByOrderByComnumAsc(Pageable page); //모든 댓글
	Page<FreeBoardComment> findByBoardnumOrderByComnumAsc(Pageable page, Long boardnum); //해당 게시물의 댓글
}