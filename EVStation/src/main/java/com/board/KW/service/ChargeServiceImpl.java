package com.board.KW.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.board.KW.domain.Charge;
import com.board.KW.persistence.ChargeRepository;


@Service
public class ChargeServiceImpl implements ChargeService{
	
	@Autowired
	private ChargeRepository boardRepo;
	
	@Override
	public Page<Charge> getBoardList(int pNum){
		Pageable page = PageRequest.of(pNum-1, 10);
		return boardRepo.findByOrderByNumDesc(page);
	}
	@Override
	public void saveBoard(Charge board) {
		boardRepo.save(board);
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
	public Charge getBoard(Long num) {
	return boardRepo.getById(num);
	}
	
	@Override
	public List<Charge> openMap() {
		return boardRepo.findAll();
	}
	

}
