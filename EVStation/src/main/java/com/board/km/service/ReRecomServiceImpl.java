package com.board.km.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.km.persistence.ReRecomRepository;

@Service
public class ReRecomServiceImpl implements ReRecomService {

	@Autowired
	ReRecomRepository rerecomrepo;

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
