package com.board.km.persistence;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.board.km.domain.ReviewBoard;

@Repository
public interface ReviewRepository extends JpaRepository<ReviewBoard, Long> {
	
	Page<ReviewBoard> findByOrderByBoardnumDesc(Pageable page);

	Page<ReviewBoard> findByBoardtitleContainingIgnoreCase(String search, Pageable page);

	Page<ReviewBoard> findByBoardwriterContainingIgnoreCase(String search, Pageable page);

	Page<ReviewBoard> findByBoardcontentContainingIgnoreCase(String search, Pageable page);

}
