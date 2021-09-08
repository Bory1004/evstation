package com.board.ds_service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Sort.Order;

import com.board.ds_entity.DsEmail;
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
		System.out.println("dsEntity.ref"+dsEntity.getRef());
		Long num =  dsRepo.save(dsEntity).getBoardnum();
		System.out.println("num::"+num);
		if(dsEntity.getRef() == null) {
			dsRepo.updateRef(num);
		}
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
		return dsRepo.findByOrderByRefDescRestepAsc(page);
	}

	@Override
	public int saveReply(Long ref, Long restep, Long relevel) {
		 return dsRepo.saveReply(ref, restep, relevel);
	}

	@Override
	public void saveQnA(DsEntity dsEntity, DsEmail dsEmail) {
		Long num =  dsRepo.save(dsEntity).getBoardnum();
		System.out.println("num::"+num);
		if(dsEntity.getRef() == null) {
			dsRepo.updateRef(num);
		}
	

		
	}

	@Override
	public void delete(String no) {
		dsRepo.delete(no);
	} 

	
	
	
	
	

	
//	@Override
//	public Page<DsEntity> getfindAll(Integer pNum, Integer pageSize) {
//		Pageable pr =  PageRequest.of(pNum-1, 10, Sort.by("groupNo").descending()
//																		.and(Sort.by("groupSeq").ascending()
//																		.and(Sort.by("depth").ascending())));
//		
//				return dsRepo.findAll(pr);
//		}
//
//
//	@Override
//	public DsEntity getfindOne(Long boardnum) {
//		DsEntity ds = dsRepo.getById(boardnum);
//		return ds;
//	}
}  






















