package com.board.ay.service;

import org.springframework.data.domain.Page;


import com.board.ay.domain.Board;

public interface BoardService {

	Page<Board> getBoardList(int pNum, int searchn, String search);
	
	Page<Board> getBoardList(int pNum);
	
	void saveBoard(Board board);

	Board getBoard(Long num);
	
	Board update(Long num);
	
	void delete(Long num);
	
	Board upRecom(Long num);

}
