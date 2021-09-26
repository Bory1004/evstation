package com.board.qna.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.qna.domain.QnABoard;
import com.board.qna.persistence.QnARecomRepository;
import com.board.qna.persistence.QnABoardRepository;
@Service
public class QnARecomServiceImpl implements QnARecomService {
	
	
	@Autowired
	QnARecomRepository dsRecomRepo;

	@Override
	public int isRecom(Long num, String id) {
		return dsRecomRepo.isRecom(num, id);
	}

	@Override
	public void insertRecom(Long num, String id) {
		dsRecomRepo.insertRecom(num, id);
	}

	@Override
	public void deleteRecom(Long num, String id) {
		dsRecomRepo.deleteRecom(num, id);
	}


}
