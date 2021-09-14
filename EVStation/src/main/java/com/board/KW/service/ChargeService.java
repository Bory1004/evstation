package com.board.KW.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.board.KW.domain.Charge;


public interface ChargeService {

	void saveBoard(Charge charge);
	Page<Charge> getChargeList(int pNum);
	Charge getCharge(Long num);
	Charge onlyBoard(Long num);
	void deleteBoard(Long num);
	List<Charge> openMap();
	

	
}
