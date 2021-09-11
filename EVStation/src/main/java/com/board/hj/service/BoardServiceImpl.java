package com.board.hj.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.board.hj.domain.Board;
import com.board.hj.persistence.BoardRepository;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private BoardRepository boardRepo;
	
	@Override
	public Page<Board> getBoardList(int pNum){
		Pageable page = PageRequest.of(pNum-1, 5); //(0,5) 총 5개 페이지 표시 ->1페이지에 10개 표시로 변경 예정
		return boardRepo.findByOrderByBoardnumDesc(page);
	}
	
	@Override
	public void saveBoard(Board board) {
		boardRepo.save(board);
	}
	
	@Override
	public void updateBoard(Board board) {
		
		
	}
	
	@Override
	public Board getBoard(Long boardnum) {
		boardRepo.updateBoardsee(boardnum); //조회수변경
		return boardRepo.getById(boardnum);
	}
	
	@Override
	public Board onlyBoard(Long boardnum) {
		return boardRepo.getById(boardnum);
	}
	
	@Override
	public void deleteBoard(Long boardnum) {
		boardRepo.deleteById(boardnum);
	}
	
	@Override
	public Page<Board> getBoardList(int pNum, int searchn, String search) { //작성자검색,내용검색 등..
		Pageable page = PageRequest.of(pNum-1, 5);
		Page<Board> list = null;
		if(searchn == 0) {
			list = boardRepo.findByBoardtitleContainingIgnoreCase(search, page);
		}else if(searchn == 1) {
			list = boardRepo.findByBoardcontentContainingIgnoreCase(search, page);
		}else if (searchn == 2) {
			list =  boardRepo.findByBoardwriterContainingIgnoreCase(search, page);
		}
		return list;
	}
}
