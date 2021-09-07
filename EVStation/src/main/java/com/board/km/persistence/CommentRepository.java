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
	@Query("UPDATE BoardComment d SET d.comgroupnum = ?1, d.comrestep= 0 WHERE d.comnum = ?1")   //댓글의 그룹번호에 댓글번호를 저장
	int updategroupnumandcomrestep(Long comnum);

	@Transactional
	@Modifying
	@Query("SELECT d FROM BoardComment d WHERE d.comnum = ?1")   //댓글의 그룹번호에 댓글번호를 저장
	BoardComment findComment(Long comnum);

	List<BoardComment> findByBoardnumAndComrestepOrderByComdateAsc(Long num, Long comrestep);

	@Transactional
	@Modifying
	@Query("UPDATE BoardComment d SET d.comcontent = ?2 WHERE d.comnum = ?1")
	void updateComment(Long comnum, String comcontent);

	@Transactional
	@Modifying
	@Query("UPDATE BoardComment d SET d.comrestep = (SELECT NVL(MAX(comrestep),0)+1 FROM d WHERE d.comgroupnum=?1)  WHERE d.comnum=?2")
	void updaterestep(Long groupnum,Long comnum);

	List<BoardComment> findByBoardnumAndComrestepGreaterThanOrderByComdateAsc(Long num, Long comrestep);   
}
