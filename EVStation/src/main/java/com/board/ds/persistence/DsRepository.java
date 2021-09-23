package com.board.ds.persistence;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.board.ds.domain.DsEntity;
import com.board.hj.domain.FreeBoard;
import com.board.km.domain.ReviewBoard;

@Repository
public interface DsRepository extends JpaRepository<DsEntity, Long> {

	Page<DsEntity> findByOrderByBoardrefDescBoardrestepAsc(Pageable page); // 글 리스트

	DsEntity save(Long boardnum);

	@Transactional
	@Modifying
	@Query("UPDATE DsEntity d SET d.boardsee = d.boardsee+1 WHERE d.boardnum =?1")
	int updateSee(Long boardnum);

	Page<DsEntity> findByBoardtitleContainingIgnoreCase(String boardtitle, Pageable page);

	Page<DsEntity> findByBoardcontentContainingIgnoreCase(String boardcontent, Pageable page);

	Page<DsEntity> findByBoardwriterContainingIgnoreCase(String boardwriter, Pageable page);
	// Page<DsEntity>

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
	 
	 @Modifying
	 @Transactional
	 @Query("UPDATE DsEntity d SET d.boardyn = 'N'  WHERE d.boardref =?1 AND d.boardrestep = 0") 
	 int ybReplyDel(Long boardref);
	 
	 DsEntity findByBoardnum(Long boardnum); //댓글부분
	
	 Page<DsEntity>findByBoardmemnumOrderByBoardnumDesc( Long boardmemnum, Pageable page); 
	 
	 
		@Transactional
		@Modifying
		@Query("UPDATE DsEntity b SET b.boardrecom = b.boardrecom+1 WHERE b.boardnum=?1")
		int upRecom(Long boardnum);
	
		//추천한 적 있다면 추천수 내림
		@Transactional
		@Modifying
		@Query("UPDATE DsEntity b SET b.boardrecom = b.boardrecom-1 WHERE b.boardnum=?1")
		int dnRecom(Long boardnum);

	 

}
