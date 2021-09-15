package com.board.ay.service;

import org.springframework.data.domain.Page;

import com.board.ay.domain.Board3;

public interface BoardService3 {

	Page<Board3> getBoardList(int pNum, int searchn, String search);

	Page<Board3> getBoardList(int pNum);

	void saveBoard(Board3 board);

	Board3 getBoard(Long num);

	Board3 update(Long num);

	void delete(Long num);

	Board3 upRecom(Long num);
	
	//09
	int isRecom(Long num, String id);

	int updateRecom(Long num);

	Board3 dnRecom(Long num);

	int insertRecom(Long num, String id);

	void del(String id, Long num);

}
