package com.board.ds.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.ds.domain.DsEntity;
import com.board.ds.persistence.DsRecomRepository;
import com.board.ds.persistence.DsRepository;
@Service
public class DsRecomServiceImpl implements DsRecomService {
	
	
	@Autowired
	DsRecomRepository dsRecomRepo;

	@Override
	public int isRecom(Long num, String id) {
		return dsRecomRepo.isRecom(num, id);
	}

	@Override
	public void insertRecom(Long num, String id) {
		dsRecomRepo.insertRecom(num, id);
	}

	@Override
	public void deleteRecom(Long num, String id) {
		dsRecomRepo.deleteRecom(num, id);
	}


}
