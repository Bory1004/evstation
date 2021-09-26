package com.board.review.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.board.review.domain.AllTableDTO;
import com.board.review.domain.ReviewBoard;


public interface ReviewService {

	Page<ReviewBoard> getReviewBoardList(int pNum,Long stnum, int searchn, String search);

	Page<ReviewBoard> getReviewBoardList(int pNum,Long stnum);

	ReviewBoard getReview(Long num);

	void saveReview(ReviewBoard board);

	void deleteReview(Long boardnum);
	
	
	//내가 쓴글 // 대순이가씀
	Page<ReviewBoard>myReviewList(int pNum, Long boardmemnum);

	void deleteChk(int boardnum);

	void withdraw(Long memnum);

	List<AllTableDTO> AllBoardList(int pNum,Long boardmemnum);


	void updateRecom(Long num, Long recomCnt);


}
