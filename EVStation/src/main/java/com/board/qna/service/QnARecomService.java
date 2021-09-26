package com.board.qna.service;


public interface QnARecomService {
	
	int isRecom(Long num, String id);

	void insertRecom(Long num, String id);

	void deleteRecom(Long num, String id);

}
