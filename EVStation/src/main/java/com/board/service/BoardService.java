package com.board.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.board.domain.Board;


public interface BoardService {

	void saveBoard(Board board);
	Page<Board> getBoardList(int pNum);
	Board getBoard(Long num);
	Board onlyBoard(Long num);
	void deleteBoard(Long num);
	List<Board> openMap();
	

	
}
