package com.board.charge.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.board.charge.domain.Charge;
import com.board.charge.persistence.ChargeRepository;
import com.board.free.domain.FreeBoard;



@Service
public class ChargeServiceImpl implements ChargeService{
	
	@Autowired
	private ChargeRepository boardRepo;
	
	@Override
	public Page<Charge> getChargeList(int pNum){
		Pageable page = PageRequest.of(pNum-1, 10); 
		return boardRepo.findByOrderByNumDesc(page);
	}
	@Override
	public void saveBoard(Charge charge) {
		boardRepo.save(charge);
	}
	
	/*
	 * @Override public Board getBoard(Long num) { boardRepo.updateCnt(num); return
	 * boardRepo.getById(num); }
	 */
	@Override
	public Charge onlyBoard(Long num) {
		return boardRepo.getById(num);
	}
	@Override
	public void deleteBoard(Long num) {
		boardRepo.deleteById(num);
	}
	@Override
	public Charge getCharge(Long num) {
	return boardRepo.getById(num);
	}
	
	@Override
	public List<Charge> openMap() {
		return boardRepo.findAll();
	}
	
	@Override  
	public Page<Charge> bookMark(int pNum, String id){
		Pageable page = PageRequest.of(pNum-1, 10);
		return boardRepo.findByOrderByNumDesc(id,page);
	}
	
	
	
	@Override
	public Page<Charge> getChargeList(int pNum, int searchn, String search) { 
		Pageable page = PageRequest.of(pNum-1, 10);
		Page<Charge> list = null;
		if(searchn == 0) {
			list = boardRepo.findByStnameContainingIgnoreCase(search, page);
		}else if(searchn == 1) {
			list = boardRepo.findByStaddress1ContainingIgnoreCase(search, page);
		}
		return list;
	}
	
	@Override
	public int isRecom(Long num, String id) {
		return boardRepo.isRecom(num, id);
	}


	@Override
	public int insertRecom(Long num, String id) {
		return boardRepo.insertRecom(num,id);
	}

	@Override public void del(String id, Long num) { 
		  boardRepo.del(id, num);
	  }
	@Override
	public void deleteBookmark(Long stnum) {
		boardRepo.deleteBookmark(stnum);
		
	}
	@Override
	public void deleteAdmin(Long stnum) {
		boardRepo.deleteAdminChargeChk(stnum);
		
	}
	@Override
	public void deleteCharge(Long stnum) {
		boardRepo.deleteById(stnum);
	}
	@Override
	public void updateCharge(Charge charge) {
		boardRepo.save(charge);
	}

	
	
}