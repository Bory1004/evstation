package com.board.ds.persistence;


import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.board.ds.domain.DsComment;

public interface DsCommentRepository extends JpaRepository<DsComment, Long> {

	
	//모든 댓글
	Page<DsComment> findByOrderByComnumDesc(Pageable page);
	//해당 게시물의 댓글
	Page<DsComment> findByBoardnumOrderByComnumDesc(Pageable page, Long boardnum);
	
	@Transactional
	@Modifying
	@Query("DELETE FROM DsComment d WHERE d.commemnum = ?1")
	void deleteByMemnum(Long memnum);

}
