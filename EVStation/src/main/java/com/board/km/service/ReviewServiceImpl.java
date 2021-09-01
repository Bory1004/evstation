package com.board.km.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.board.km.domain.ReviewBoard;
import com.board.km.persistence.ReviewRepository;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	ReviewRepository reviewRepo;
	
	@Override
	public Page<ReviewBoard> getReviewBoardList(int pNum) {
		Pageable page = PageRequest.of(pNum-1, 10);
		return reviewRepo.findByOrderByBoardnumDesc(page);
	}

	@Override
	public Page<ReviewBoard> getReviewBoardList(int pNum, int searchn, String search) {
		Pageable page = PageRequest.of(pNum-1,10);
		Page<ReviewBoard> list = null;
		if(searchn == 0) {
			list = reviewRepo.findByBoardtitleContainingIgnoreCase(search, page);
		}else if(searchn == 1) {
			list = reviewRepo.findByBoardcontentContainingIgnoreCase(search, page);
		}else if (searchn == 2) {
			list =  reviewRepo.findByBoardwriterContainingIgnoreCase(search, page);
		}
		
		return list;
	}

}
