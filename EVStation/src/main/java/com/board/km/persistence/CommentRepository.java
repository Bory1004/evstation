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
	
	//댓글창에서 일반댓글을 달때 그룹번호와 restep을 지정
	@Transactional
	@Modifying
	@Query("UPDATE BoardComment d SET d.comgroupnum = ?1, d.comrestep= 0 WHERE d.comnum = ?1")  
	int updategroupnumandcomrestep(Long comnum);

	/*
	 * @Transactional
	 * 
	 * @Modifying
	 * 
	 * @Query("SELECT d FROM BoardComment d WHERE d.comnum = ?1") BoardComment
	 * findComment(Long comnum);
	 */

	List<BoardComment> findByBoardnumAndComrestepOrderByComdateAsc(Long num, Long comrestep);  // 일반댓글만 불러오기
	List<BoardComment> findByBoardnumAndComrestepGreaterThanOrderByComdateAsc(Long num, Long comrestep); //대댓글만 불러오기
	
	@Transactional
	@Modifying
	@Query("UPDATE BoardComment d SET d.comcontent = ?2 WHERE d.comnum = ?1")
	void updateComment(Long comnum, String comcontent);

	@Transactional
	@Modifying
	@Query("UPDATE BoardComment d SET d.comrestep = (SELECT NVL(MAX(comrestep),0)+1 FROM d WHERE d.comgroupnum=?1)  WHERE d.comnum=?2")
	void updaterestep(Long groupnum,Long comnum);
	
	@Transactional
	void deleteByComgroupnum(Long comgroupnum); //일반댓글인 경우 대댓글까지 데이터베이스에서 지움

}
