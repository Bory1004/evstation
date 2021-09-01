package com.board.ds_service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.ds_entity.DsEntity;
import com.board.ds_persistence.DsRepository;

@Service
public class DsServiceImpl implements DsService {
	
	@Autowired
	 private DsRepository dsRepo;

	@Override
	public List<DsEntity> QnA_AllList() {
		return dsRepo.findAll();
	}

}
