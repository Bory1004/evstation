package com.board.ds_persistence;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.board.ds_entity.DsEntity;

public interface DsRepository extends JpaRepository<DsEntity, Long> {
	
	Page<DsEntity>findByOrderByBoardrefDescBoardrestepAsc(Pageable page);  
	
	DsEntity save(Long boardnum);
	
	@Transactional
	@Modifying
	@Query("UPDATE DsEntity d SET d.boardsee = d.boardsee+1 WHERE d.boardnum =?1")
	int updateSee(Long boardnum);

	Page<DsEntity> findByBoardtitleContainingIgnoreCase(String boardtitle, Pageable page);
	Page<DsEntity> findByBoardcontentContainingIgnoreCase(String boardcontent, Pageable page);
	Page<DsEntity> findByBoardwriterContainingIgnoreCase(String boardwriter, Pageable page);

	@Transactional
	@Modifying
	@Query("UPDATE DsEntity d SET d.boardref = ?1 WHERE d.boardnum = ?1")   //boardnum 을 ref에 정의
	int updateRef(Long boardnum);   
	
	
	 @Modifying
	 @Transactional
	 @Query("UPDATE DsEntity d SET d.boardrestep = d.boardrestep + 1  WHERE d.boardref = ?1 AND d.boardrestep > ?2 ")  //기존의 DB에 있는 데이터만 업데이트문이 적용됨.
	 int saveReply(Long boardref, Long boardrestep, Long boardrelevel);
	 // 기본글  num 1 ref: 1  , step : 0  level 0
	 // 기본글의 댓글 3: num:3 ref :1 step 1 , level : 1
	 // 기본글의 댓글 2 : num 3 , ref :1, step: 1 +1, level : 1
	 		// 기본글의 댓글2의 댓글 : num 5: ref :2+1  step:  level: 1+1
	 //기본글의 댓글 1: num : 2  ref:1 step :1+1 +1+1, level : 1
	 
	 @Modifying
	 @Transactional
	 @Query("UPDATE DsEntity d SET d.boardyn = 'Y'  WHERE d.boardref =?1 AND d.boardrestep = 0") 
	 int ybReply(Long boardref);
	 
}
