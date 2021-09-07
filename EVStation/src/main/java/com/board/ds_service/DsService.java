package com.board.ds_service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.board.ds_entity.DsEntity;

public interface DsService {
	
	List<DsEntity> QnA_AllList();

	DsEntity qnaDetail(Long boardnum);
	void deleteQnA(Long boardnum);
	void updateQnA(DsEntity dsEntity);
	Page<DsEntity>AllListQnA(int pNum, int searchn, String search);
	Page<DsEntity>AllListQnA(int pNum);
	void saveQnA(DsEntity dsEntity);
	 
	int saveReply(Long ref, Long restep, Long relevel);

	
	

}
	