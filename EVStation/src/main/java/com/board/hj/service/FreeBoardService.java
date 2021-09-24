package com.board.hj.service;

import org.springframework.data.domain.Page;

import com.board.hj.domain.FreeBoard;

public interface FreeBoardService {
	
	//저장
	void saveBoard(FreeBoard board);
		
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
	

	//내가 쓴글 // 대순이가씀
	Page<FreeBoard>myFreeList(int pNum, Long boardmemnum);

	void deleteChk(int boardnum);

	int getCommentCount(Long boardnum);

	void withdraw(Long memnum);
		
	//추천 부분
	FreeBoard dnRecom(Long boardnum);
	FreeBoard upRecom(Long boardnum);

}
