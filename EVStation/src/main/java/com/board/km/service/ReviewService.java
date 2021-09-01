package com.board.km.service;

import org.springframework.data.domain.Page;

import com.board.km.domain.ReviewBoard;


public interface ReviewService {

	Page<ReviewBoard> getReviewBoardList(int pNum, int searchn, String search);

	Page<ReviewBoard> getReviewBoardList(int pNum);
}
