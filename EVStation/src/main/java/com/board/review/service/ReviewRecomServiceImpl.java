package com.board.review.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.review.persistence.ReviewRecomRepository;

@Service
public class ReviewRecomServiceImpl implements ReviewRecomService {

	@Autowired
	ReviewRecomRepository rerecomrepo;

	@Override
	public int isRecom(Long num, String id) {
		
		return rerecomrepo.isRecom(num,id);
	}

	@Override
	public void insertRecom(Long num, String id) {
		rerecomrepo.insertRecom(num,id);
		
	}

	@Override
	public void deleteRecom(Long num, String id) {
		rerecomrepo.deleteRecom(num,id);
	}

	@Override
	public int getRecom(Long num) {
		return rerecomrepo.getRecom(num);
	}
	
	
}
