package com.board.review.persistence;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.board.review.domain.ReviewBoardComment;

@Repository
public interface ReviewCommentRepository extends JpaRepository<ReviewBoardComment, Long> {

	ReviewBoardComment findByBoardnumAndComcontent(Long boardnum, String comcontent);
	
	//댓글창에서 일반댓글을 달때 그룹번호와 restep을 지정
	@Transactional
	@Modifying
	@Query("UPDATE ReviewBoardComment d SET d.comgroupnum = ?1, d.comrestep= 0 WHERE d.comnum = ?1")  
	int updategroupnumandcomrestep(Long comnum);

	/*
	 * @Transactional
	 * 
	 * @Modifying
	 * 
	 * @Query("SELECT d FROM BoardComment d WHERE d.comnum = ?1") BoardComment
	 * findComment(Long comnum);
	 */

	List<ReviewBoardComment> findByBoardnumAndComrestepOrderByComdateAsc(Long num, Long comrestep);  // 일반댓글만 불러오기
	List<ReviewBoardComment> findByBoardnumAndComrestepGreaterThanOrderByComdateAsc(Long num, Long comrestep); //대댓글만 불러오기
	
	@Transactional
	@Modifying
	@Query("UPDATE ReviewBoardComment d SET d.comcontent = ?2 WHERE d.comnum = ?1")
	void updateComment(Long comnum, String comcontent);

	@Transactional
	@Modifying
	@Query("UPDATE ReviewBoardComment d SET d.comrestep = (SELECT NVL(MAX(comrestep),0)+1 FROM d WHERE d.comgroupnum=?1)  WHERE d.comnum=?2")
	void updaterestep(Long groupnum,Long comnum);
	
	@Transactional
	@Modifying
	@Query("delete from ReviewBoardComment d where d.comgroupnum = ?1")
	int deleteByComgroupnum(Long comgroupnum); //일반댓글인 경우 대댓글까지 데이터베이스에서 지움
	
	List<ReviewBoardComment> findByComgroupnum(Long comgroupum); //알람 테이블에 추가할 멤버번호들 가져오기
	
	@Transactional
	@Modifying
	@Query("delete from ReviewBoardComment d where d.boardnum = ?1")
	void deleteByBoardnum(Long boardnum);
	
	@Query("SELECT count(d) from ReviewBoardComment d where d.boardnum = ?1")
	int getCount(Long num);
	
	@Transactional
	@Query("SELECT COUNT(d) from ReviewBoardComment d where d.comgroupnum=?1")
	int countComment(Long comgroupnum);

	@Transactional
	@Modifying
	@Query("delete from ReviewBoardComment d where d.commemnum = ?1")
	void deleteByMemnum(Long memnum);

}
