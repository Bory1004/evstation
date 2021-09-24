package com.board.ds.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.board.ds.domain.DsEmail;
import com.board.ds.domain.DsEntity;

public interface DsService {
	
	List<DsEntity> QnA_AllList();

	DsEntity qnaDetail(Long boardnum);
	void updateQnA(DsEntity dsEntity);
	Page<DsEntity>AllListQnA(int pNum, int searchn, String search);
	Page<DsEntity>AllListQnA(int pNum);
	void saveQnA(DsEntity dsEntity);
	void saveQnA(DsEntity dsEntity, DsEmail dsEmail);

	 
	int saveReply(Long boardref, Long boardrestep, Long boardrelevel);

	void deleteChk(int boardnum, Long boardref);

	void deleteQnA(Long boardnum, Long boardref);
	
	DsEntity qnaConmment(Long boardnum);
	
	Page<DsEntity>AAllListQnA(int pNum, Long boardmemnum);

	
	//추천 부분
	DsEntity dnRecom(Long boardnum);

	DsEntity upRecom(Long boardnum);

	void withdraw(Long memnum);
	
	void deleteReply(Long boardref);
	



}
	