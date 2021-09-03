package com.board.ds_persistence;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.board.ds_entity.DsEntity;

public interface DsRepository extends JpaRepository<DsEntity, Long> {
	
	Page<DsEntity>findByOrderByBoardnumDesc(Pageable page);  
	
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
	@Query("UPDATE DsEntity d SET d.reStep = d,reStep+1 and SET d.reLevel = d.reLevel+1  where d.ref=?1 ")
	int updateRe(Long ref);
	//레퍼런스는 같고 스텝만 큰
	

}
