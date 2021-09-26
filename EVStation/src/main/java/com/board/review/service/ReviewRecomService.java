package com.board.review.service;

public interface ReviewRecomService {

	int isRecom(Long num, String id);

	void insertRecom(Long num, String id);

	void deleteRecom(Long num, String id);

	int getRecom(Long num);

}
