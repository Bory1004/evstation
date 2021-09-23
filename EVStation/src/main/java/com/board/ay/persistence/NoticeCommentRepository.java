package com.board.ay.persistence;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.board.ay.domain.NoticeComment;

@Repository
public interface NoticeCommentRepository extends JpaRepository<NoticeComment, Long> {

	// 모든 댓글
	Page<NoticeComment> findByOrderByComnumAsc(Pageable page);

	// 해당 게시물의 댓글
	Page<NoticeComment> findByNumOrderByComnumAsc(Pageable page, Long num);
	
	@Transactional
	@Modifying
	@Query("DELETE FROM NoticeComment d WHERE d.commennum=?1")
	void deleteByCommemnum(Long commennum);

}
