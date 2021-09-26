package com.board.qna.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.board.qna.domain.QnAEmail;
import com.board.qna.domain.QnABoard;


public interface QnABoardService {
	
	List<QnABoard> QnA_AllList();

	QnABoard qnaDetail(Long boardnum);
	void updateQnA(QnABoard dsEntity);
	Page<QnABoard>AllListQnA(int pNum, int searchn, String search);
	Page<QnABoard>AllListQnA(int pNum);
	void saveQnA(QnABoard dsEntity);
	void saveQnA(QnABoard dsEntity, QnAEmail dsEmail);

	 
	int saveReply(Long boardref, Long boardrestep, Long boardrelevel);

	void deleteChk(int boardnum, Long boardref);

	void deleteQnA(Long boardnum, Long boardref);
	
	QnABoard qnaConmment(Long boardnum);
	
	Page<QnABoard>AAllListQnA(int pNum, Long boardmemnum);

	
	//추천 부분
	QnABoard dnRecom(Long boardnum);

	QnABoard upRecom(Long boardnum);

	void withdraw(Long memnum);

	void deleteReply(Long boardref);
	



}
	