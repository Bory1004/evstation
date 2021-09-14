package com.board.KW.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.board.KW.domain.Board;
import com.board.KW.persistence.BoardRepository;


@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private BoardRepository boardRepo;
	
	
	/*
	 * @Override public Page<Board> getBoardList(int pNum){ Pageable page =
	 * PageRequest.of(pNum-1, 10); return boardRepo.findByOrderByNumDesc(page); }
	 */
	 
	@Override
	public void saveBoard(Board board) {
		boardRepo.save(board);
	}
	
	/*
	 * @Override public Board getBoard(Long num) { boardRepo.updateCnt(num); return
	 * boardRepo.getById(num); }
	 */
	@Override
	public Board onlyBoard(Long num) {
		return boardRepo.getById(num);
	}
	@Override
	public void deleteBoard(Long num) {
		boardRepo.deleteById(num);
	}
	@Override
	public Board getBoard(Long num) {
	return boardRepo.getById(num);
	}
	
	@Override
	public List<Board> openMap() {
		return boardRepo.findAll();
	}
	
	@Override
	public Page<Board> AllListQnA(int pNum, int searchn, String search) {
		
		Pageable page = PageRequest.of(pNum-1, 10);
		Page<Board> list = null;
		if(searchn == 0) {
			list = boardRepo.findByBoardtitleContainingIgnoreCase(search, page);
		}else if(searchn == 1) {
			list = boardRepo.findByBoardcontentContainingIgnoreCase(search, page);
		}
		return list;
	}
  
	@Override
	public Page<Board> AllListQnA(int pNum) {
		Pageable page = PageRequest.of(pNum-1, 10);
		return boardRepo.findByOrderByBoardrefDescBoardrestepAsc(page);
	}
	
	
}
