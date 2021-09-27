package com.board.notice.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.notice.domain.NoticeBoard;
import com.board.notice.persistence.NoticeBoardRepository;

@Service
public class NoticeBoardSeviceImpl implements NoticeBoardService{
	
	@Autowired
	private NoticeBoardRepository boardRepo;
	
	@Override
	public Page<NoticeBoard> getBoardList(int pNum, int searchn, String search) {
		Pageable page = PageRequest.of(pNum-1, 5);
		Page<NoticeBoard> list = null;
		if(searchn == 0) {
			list = boardRepo.findByTitleContainingIgnoreCase(search, page);
		}else if(searchn == 1) {
			list = boardRepo.findByContentContainingIgnoreCase(search, page);
		}
		return list;
	}
	
	@Override
	public Page<NoticeBoard> getBoardList(int pNum){
		Pageable page = PageRequest.of(pNum-1, 5);
		return boardRepo.findByOrderByNumDesc(page);
	}
	
	@Override
	public void saveBoard(NoticeBoard board) {
		boardRepo.save(board);
	}

	@Override
	public NoticeBoard getBoard(Long num){
		boardRepo.updateCnt(num);
		return boardRepo.getById(num);
	}
	@Override
	public NoticeBoard upRecom(Long num){
		boardRepo.upRecom(num);
		return boardRepo.getById(num);
	}
	
	@Override
	public NoticeBoard update(Long num) {
		return boardRepo.getById(num);
	}
	@Override
	public void delete(Long num) {
		boardRepo.deleteById(num);
	}
	
	@Override
	public int isRecom(Long num, String id) {
		return boardRepo.isRecom(num, id);
	}
	@Override
	public int updateRecom(Long num) {
		return boardRepo.updateCnt(num);
	}
	@Override
	public NoticeBoard dnRecom(Long num) {
		boardRepo.dnRecom(num);
		return boardRepo.getById(num);
		
	}
	@Override
	public int insertRecom(Long num, String id) {
		return boardRepo.insertRecom(num,id);
	}

	@Override public void del(String id, Long num) { 
		  boardRepo.del(id, num);
	  }

	@Override
	public void deleteChk(int num) {
		boardRepo.deleteById((long)num);
		
	}
	
}
