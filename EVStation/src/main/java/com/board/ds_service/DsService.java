package com.board.ds_service;

import java.util.List;

import com.board.ds_entity.DsEntity;

public interface DsService {
	
	List<DsEntity> QnA_AllList();
	void saveQnA(DsEntity dsEntity);
	DsEntity qnaDetail(Long board_num);
	void deleteQnA(Long board_num);
	
	
	

}
	