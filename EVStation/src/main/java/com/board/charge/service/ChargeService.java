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
	
	Page<Charge> bookMark(int pNum,String id);
	
	// 즐겨찾기 체크박스 삭제
	void deleteBookmark(Long stnum);
	
	//관리자 충전소관리 체크박스 삭제
	void deleteAdmin(Long stnum);
	
	//충전소 상세내용에서 삭제
	void deleteCharge(Long stnum);
	//충전소 수정
	void updateCharge(Charge charge);
}
