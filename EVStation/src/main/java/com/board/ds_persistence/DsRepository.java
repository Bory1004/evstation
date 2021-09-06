package com.board.ds_persistence;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.board.ds_entity.DsEntity;

public interface DsRepository extends JpaRepository<DsEntity, Long> {
	
	Page<DsEntity>findByOrderByRefDescRestepAsc(Pageable page);  
	
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
	@Query("UPDATE DsEntity d SET d.ref = ?1 WHERE d.boardnum = ?1")   //boardnum 을 ref에 정의
	int updateRef(Long boardnum);   
	
	
	 @Modifying
	 @Transactional
	 @Query("UPDATE DsEntity d SET d.restep = d.restep + 1 WHERE d.ref = ?1 AND d.restep > ?2 ") //ref가 같고  
	 int saveReply(Long ref, Long restep);
	 
//	 @Modifying
//	 @Transactional
//	 @Query("UPDATE DsEntity d SET d.restep = d.restep + 1  WHERE d.ref = ?1 AND d.restep > ?2 ") //ref가 같고  
//	 int saveRereply(Long ref, Long restep);


	    
	    
	    
}
