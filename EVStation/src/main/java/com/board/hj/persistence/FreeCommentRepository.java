package com.board.hj.persistence;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.board.hj.domain.FreeComment;

public interface FreeCommentRepository extends JpaRepository<FreeComment, Long>{
	
	Page<FreeComment> findByOrderByComnumAsc(Pageable page); //모든 댓글
	Page<FreeComment> findByBoardnumOrderByComnumAsc(Pageable page, Long boardnum); //해당 게시물의 댓글
}