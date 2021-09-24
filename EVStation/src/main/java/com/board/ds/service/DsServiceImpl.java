package com.board.ds.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.board.ay.domain.Board3;
import com.board.ds.domain.DsEmail;
import com.board.ds.domain.DsEntity;
import com.board.ds.persistence.DsRepository;
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
		System.out.println("dsEntity.ref"+dsEntity.getBoardref());
		Long num =  dsRepo.save(dsEntity).getBoardnum();
		System.out.println("num::"+num);
		if(dsEntity.getBoardref() == null) {
			dsRepo.updateRef(num);
		}
	}

	@Override
	public DsEntity qnaDetail(Long boardnum) {
		dsRepo.updateSee(boardnum); 
		return dsRepo.getById(boardnum);
	}
	@Override
	public void deleteQnA(Long boardnum,Long boardref) {
		dsRepo.ybReplyDel(boardref);
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
		return dsRepo.findByOrderByBoardrefDescBoardrestepAsc(page);
	}

	@Override
	public int saveReply(Long boardref, Long boardrestep, Long boardrelevel) {
		dsRepo.ybReply(boardref);
		 return dsRepo.saveReply(boardref, boardrestep, boardrelevel);
	}

	@Override
	public void saveQnA(DsEntity dsEntity, DsEmail dsEmail) {
		Long num =  dsRepo.save(dsEntity).getBoardnum();
		System.out.println("num::"+num);
		if(dsEntity.getBoardref() == null) {
			dsRepo.updateRef(num);
		}
	}

	@Override
	public void deleteChk(int boardnum, Long boardref) {
		dsRepo.ybReplyDel(boardref);
		dsRepo.deleteById((long) boardnum);
	}

	@Override
	public DsEntity qnaConmment(Long boardnum) {
		dsRepo.updateSee(boardnum);
		return dsRepo.findByBoardnum(boardnum);  
	 
	}

	@Override
	public Page<DsEntity> AAllListQnA(int pNum, Long boardmemnum) {
		Pageable page = PageRequest.of(pNum-1, 10);
		 
		return dsRepo.findByBoardmemnumOrderByBoardrefDescBoardrestepAsc(boardmemnum, page);  
	}

	@Override
	public void withdraw(Long memnum) {
		dsRepo.deleteByMemnum(memnum);
	}

	
	//추천부분
	@Override
	public DsEntity dnRecom(Long boardnum) {
			dsRepo.dnRecom(boardnum);
			return dsRepo.getById(boardnum);
	}

	@Override
	public DsEntity upRecom(Long boardnum) {
			dsRepo.upRecom(boardnum);
		return dsRepo.getById(boardnum);
	}

	@Override
	public void deleteReply(Long boardref) {
		dsRepo.deleteReply(boardref);
	}

	
	
	
}  