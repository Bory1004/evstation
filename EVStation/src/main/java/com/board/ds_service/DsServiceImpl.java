package com.board.ds_service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
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

	@Override
	public void saveQnA(DsEntity dsEntity) {
			dsRepo.save(dsEntity);
	}

	@Override
	public DsEntity qnaDetail(Long boardnum) {
		dsRepo.updateSee(boardnum); 
		return dsRepo.getById(boardnum);
	}
	@Override
	public void deleteQnA(Long boardnum) {
		dsRepo.deleteById(boardnum);  
	}

	@Override
	public void updateQnA(DsEntity dsEntity) {
		 dsRepo.save(dsEntity);
	}
	@Override
	public Page<DsEntity> AllListQnA(int pNum, int searchn, String search) {
		
		Pageable page = PageRequest.of(pNum-1, 10);
		Page<DsEntity> list = null;
		if(searchn == 0) {
			list = dsRepo.findByBoardtitleContainingIgnoreCase(search, page);
		}else if(searchn == 1) {
			list = dsRepo.findByBoardcontentContainingIgnoreCase(search, page);
		}else if(searchn == 2) {
			list = dsRepo. findByBoardwriterContainingIgnoreCase(search ,page);
		}
		return list;
	}

	@Override
	public Page<DsEntity> AllListQnA(int pNum) {
		Pageable page = PageRequest.of(pNum-1, 10);
		return dsRepo.findByOrderByBoardnumDesc(page);
	}
}
