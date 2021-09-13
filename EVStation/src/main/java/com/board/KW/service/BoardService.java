package com.board.KW.service;

import java.util.List;



import org.springframework.data.domain.Page;
import javax.transaction.Transactional;

import com.board.KW.domain.Board;


public interface BoardService {

	void saveBoard(Board board);
	Page<Board> getBoardList(int pNum);
	Board getBoard(Long num);
	Board onlyBoard(Long num);
	void deleteBoard(Long num);
	List<Board> openMap();
	Page<Board>AllListQnA(int pNum, int searchn, String search);
	Page<Board>AllListQnA(int pNum);

	
}
