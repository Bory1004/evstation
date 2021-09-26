package com.board.free.persistence;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.board.free.domain.FreeBoardComment;

public interface FreeCommentRepository extends JpaRepository<FreeBoardComment, Long>{
	
	//모든 댓글
	Page<FreeBoardComment> findByOrderByComnumAsc(Pageable page);
	
	//해당 게시물의 댓글
	Page<FreeBoardComment> findByBoardnumOrderByComnumAsc(Pageable page, Long boardnum);
	
	//Page<FreeBoardComment> findByBoardnumOrderByComnumAsc(Pageable page, Long boardnum);
	
	List<FreeBoardComment> findByBoardnumOrderByComnumAsc(Long boardnum);
	
	@Transactional
	@Modifying
	@Query("UPDATE FreeBoardComment d SET d.comcontent = ?2 WHERE d.comnum = ?1")
	void updateComment(Long comnum, String comcontent);

	//게시물 삭제시 댓글도 삭제
	@Transactional
	@Modifying
	@Query("delete from FreeBoardComment d where d.boardnum = ?1")
	void deleteBoardComment(Long boardnum);
	
	@Transactional
	@Modifying
	@Query("DELETE FROM FreeBoardComment d WHERE d.commennum=?1")
	void deleteByMemnum(Long memnum);

}