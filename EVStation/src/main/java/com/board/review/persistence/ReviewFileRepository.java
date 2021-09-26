package com.board.review.persistence;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.board.review.domain.ReviewFile;

@Repository
public interface ReviewFileRepository extends JpaRepository<ReviewFile, Long> {

	List<ReviewFile> findByBoardnum(Long boardnum);

	
}
