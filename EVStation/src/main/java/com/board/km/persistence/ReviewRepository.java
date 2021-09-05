package com.board.km.persistence;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.board.km.domain.ReviewBoard;

@Repository
public interface ReviewRepository extends JpaRepository<ReviewBoard, Long> {
	
	Page<ReviewBoard> findByBoardstnumOrderByBoardnumDesc(Long i,Pageable page);

	Page<ReviewBoard> findByBoardstnumAndBoardtitleContainingIgnoreCaseOrderByBoardnumDesc(Long i,String search, Pageable page);

	Page<ReviewBoard> findByBoardstnumAndBoardwriterContainingIgnoreCaseOrderByBoardnumDesc(Long i,String search, Pageable page);

	Page<ReviewBoard> findByBoardstnumAndBoardcontentContainingIgnoreCaseOrderByBoardnumDesc(Long i,String search, Pageable page);

	ReviewBoard findByBoardnum(Long num);
	
	@Transactional
	@Modifying
	@Query("UPDATE ReviewBoard b SET b.boardsee = b.boardsee+1 WHERE b.boardnum=?1")
	int updateCnt(Long num);

}
