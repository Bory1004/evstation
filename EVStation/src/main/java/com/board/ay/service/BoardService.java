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
	
	//09
	int isRecom(Long num, String id);

	int updateRecom(Long num);

	Board dnRecom(Long num);

	int insertRecom(Long num, String id);

	void del(String id, Long num);

}
