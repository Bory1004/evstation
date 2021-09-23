package com.board.ds.service;


public interface DsRecomService {
	
	int isRecom(Long num, String id);

	void insertRecom(Long num, String id);

	void deleteRecom(Long num, String id);

}
