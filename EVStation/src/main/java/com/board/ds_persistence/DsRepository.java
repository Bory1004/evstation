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

}
