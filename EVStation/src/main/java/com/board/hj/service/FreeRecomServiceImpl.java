package com.board.hj.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.hj.persistence.FreeRecomRepository;

@Service
public class FreeRecomServiceImpl implements FreeRecomService {

	@Autowired
	FreeRecomRepository freeRecomRepo;
	
	@Override
	public int isRecom(Long num, String id) {
		return freeRecomRepo.isRecom(num, id);
	}

	@Override
	public void insertRecom(Long num, String id) {
		freeRecomRepo.insertRecom(num, id);

	}

	@Override
	public void deleteRecom(Long num, String id) {
		freeRecomRepo.deleteRecom(num, id);
	}

}
