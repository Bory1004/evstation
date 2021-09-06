package com.board.km.persistence;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.board.km.domain.BoardComment;

public interface CommentRepository extends JpaRepository<BoardComment, Long> {

	BoardComment findByBoardnumAndComcontent(Long boardnum, String comcontent);
	
	@Transactional
	@Modifying
	@Query("UPDATE BoardComment d SET d.comgroupnum = ?1 WHERE d.comnum = ?1")   //댓글의 그룹번호에 댓글번호를 저장
	int updategroupnum(Long comnum);

	@Transactional
	@Modifying
	@Query("SELECT d FROM BoardComment d WHERE d.comnum = ?1")   //댓글의 그룹번호에 댓글번호를 저장
	BoardComment findComment(Long comnum);

	List<BoardComment> findByBoardnumOrderByComdateAsc(Long num);   
}
