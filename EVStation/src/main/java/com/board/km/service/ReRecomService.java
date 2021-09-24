package com.board.km.service;

public interface ReRecomService {

	int isRecom(Long num, String id);

	void insertRecom(Long num, String id);

	void deleteRecom(Long num, String id);

	int getRecom(Long num);

}
