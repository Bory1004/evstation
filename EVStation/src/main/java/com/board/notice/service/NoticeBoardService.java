package com.board.notice.service;

import org.springframework.data.domain.Page;

import com.board.notice.domain.NoticeBoard;

public interface NoticeBoardService {

	Page<NoticeBoard> getBoardList(int pNum, int searchn, String search);

	Page<NoticeBoard> getBoardList(int pNum);

	void saveBoard(NoticeBoard board);

	NoticeBoard getBoard(Long num);

	NoticeBoard update(Long num);

	void delete(Long num);

	NoticeBoard upRecom(Long num);
	
	//09
	int isRecom(Long num, String id);

	int updateRecom(Long num);

	NoticeBoard dnRecom(Long num);

	int insertRecom(Long num, String id);

	void del(String id, Long num);

	void deleteChk(int num);

}
