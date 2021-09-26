package com.board.free.service;

public interface FreeRecomService {
	
	int isRecom(Long num, String id);

	void insertRecom(Long num, String id);

	void deleteRecom(Long num, String id);

}
