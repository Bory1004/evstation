package com.board.persistence.hj;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.board.domain.hj.Comment;

public interface CommentRepository extends JpaRepository<Comment, Long>{
	
	Page<Comment> findByOrderByComnumAsc(Pageable page); //모든 댓글
	Page<Comment> findByBoardnumOrderByComnumAsc(Pageable page, Long boardnum); //해당 게시물의 댓글
}