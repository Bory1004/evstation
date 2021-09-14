package com.board.hj.service;

import org.springframework.data.domain.Page;

import com.board.hj.domain.FreeBoard;

public interface FreeBoardService {
	
	//저장
	void saveBoard(FreeBoard board);
	
	//업데이트
	void updateBoard(FreeBoard board);
	
	//모든 게시판 목록 출력
	Page<FreeBoard> getBoardList(int pNum);
	
	//게시물 하나 출력
	FreeBoard getBoard(Long boardnum);
	
	//수정
	FreeBoard onlyBoard(Long boardnum);
	
	//삭제
	void deleteBoard(Long boardnum);
	
	//검색
	Page<FreeBoard> getBoardList(int pNum, int searchn, String search);
	
	//프로필 사진 꺼내기
	String getMemberPhoto(Long boardnum);
	
}
