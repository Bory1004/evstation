package com.board.ay.persistence;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.board.ay.domain.NoticeComment;

public interface NoticeCommentRepository extends JpaRepository<NoticeComment, Long> {

	// 모든 댓글
	Page<NoticeComment> findByOrderByComnumAsc(Pageable page);

	// 해당 게시물의 댓글
	Page<NoticeComment> findByNumOrderByComnumAsc(Pageable page, Long num);

}
