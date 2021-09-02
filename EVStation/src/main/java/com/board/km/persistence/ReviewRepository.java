package com.board.km.persistence;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.board.km.domain.ReviewBoard;

@Repository
public interface ReviewRepository extends JpaRepository<ReviewBoard, Long> {
	
	Page<ReviewBoard> findByBoardstnumOrderByBoardnumDesc(Long i,Pageable page);

	Page<ReviewBoard> findByBoardstnumAndBoardtitleContainingIgnoreCaseOrderByBoardnumDesc(Long i,String search, Pageable page);

	Page<ReviewBoard> findByBoardstnumAndBoardwriterContainingIgnoreCaseOrderByBoardnumDesc(Long i,String search, Pageable page);

	Page<ReviewBoard> findByBoardstnumAndBoardcontentContainingIgnoreCaseOrderByBoardnumDesc(Long i,String search, Pageable page);

	ReviewBoard findByBoardnum(Long num);

}
