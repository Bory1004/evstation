package com.board.charge.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.board.charge.domain.Charge;


public interface ChargeService {

	void saveBoard(Charge charge);
	Page<Charge> getChargeList(int pNum);
	Charge getCharge(Long num);
	Charge onlyBoard(Long num);
	void deleteBoard(Long num);
	List<Charge> openMap();	
	Page<Charge> getChargeList(int pNum, int searchn, String search);
	
	int isRecom(Long num, String id);
	int insertRecom(Long num, String id);
	void del(String id, Long num);
	
	Page<Charge> bookMark(int pNum);
	List<Charge> bookmark(String id);
}
