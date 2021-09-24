package com.board.km.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.board.km.domain.AllTableDTO;
import com.board.km.domain.ReviewBoard;
import com.board.km.persistence.ReviewRepository;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	ReviewRepository reviewRepo;
	
	@Override
	public Page<ReviewBoard> getReviewBoardList(int pNum,Long stnum) {
		Pageable page = PageRequest.of(pNum-1, 10); // 불러올페이지, 페이지크기
		return reviewRepo.findByBoardstnumOrderByBoardnumDesc(stnum , page);
	}

	
	
	@Override
	public Page<ReviewBoard> getReviewBoardList(int pNum, Long stnum ,int searchn, String search) {
		Pageable page = PageRequest.of(pNum-1,10);
		Page<ReviewBoard> list = null;
		if(searchn == 0) {
			list = reviewRepo.findByBoardstnumAndBoardtitleContainingIgnoreCaseOrderByBoardnumDesc(stnum,search, page);
		}else if(searchn == 1) {
			list = reviewRepo.findByBoardstnumAndBoardcontentContainingIgnoreCaseOrderByBoardnumDesc(stnum,search, page);
		}else if (searchn == 2) {
			list = reviewRepo.findByBoardstnumAndBoardwriterContainingIgnoreCaseOrderByBoardnumDesc(stnum,search, page);
		}else if (searchn == -1) {
			list = reviewRepo.findByBoardstnumOrderByBoardnumDesc(stnum , page);
		}
		
		return list;
	}

	@Override
	public ReviewBoard getReview(Long num) {
		reviewRepo.updateCnt(num);
		return reviewRepo.findByBoardnum(num);
	}

	@Override
	public void saveReview(ReviewBoard board) {
		 	reviewRepo.save(board);
	}

	@Override
	public void deleteReview(Long boardnum) {
			reviewRepo.deleteById(boardnum);
	}

	
	
	
	//내가쓴글 // 대순이가씀
	@Override
	public Page<ReviewBoard> myReviewList(int pNum, Long boardmemnum) {
		Pageable page = PageRequest.of(pNum-1, 10);
		return reviewRepo.findByBoardmemnumOrderByBoardnumDesc(boardmemnum, page);
	}
	@Override
	public void deleteChk(int boardnum) {
		reviewRepo.deleteById((long) boardnum);
	}

	@Override
	public void withdraw(Long memnum) {
		reviewRepo.deleteByMemnum(memnum);
	}

	@Override
	public List<AllTableDTO> AllBoardList(int pNum, Long boardmemnum) {
		Pageable page = PageRequest.of(pNum-1, 10); // 불러올페이지, 페이지크기
		return reviewRepo.findAllBoard(boardmemnum);
	}

	

}
