package com.board.hj.service;

import org.springframework.data.domain.Page;

import com.board.hj.domain.Board;

public interface BoardService {
	
	//저장
	void saveBoard(Board board);
	
	//업데이트
	void updateBoard(Board board);
	
	//모든 게시판 목록 출력
	Page<Board> getBoardList(int pNum);
	
	//게시물 하나 출력
	Board getBoard(Long boardnum);
	
	//수정
	Board onlyBoard(Long boardnum);
	
	//삭제
	void deleteBoard(Long boardnum);
	
	//검색
	Page<Board> getBoardList(int pNum, int searchn, String search);
	
}
