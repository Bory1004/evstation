package com.board.km.service;

import org.springframework.data.domain.Page;

import com.board.km.domain.ReviewBoard;


public interface ReviewService {

	Page<ReviewBoard> getReviewBoardList(int pNum,Long stnum, int searchn, String search);

	Page<ReviewBoard> getReviewBoardList(int pNum,Long stnum);

	ReviewBoard getReview(Long num);

	void saveReview(ReviewBoard board);

	void deleteReview(Long boardnum);

}
