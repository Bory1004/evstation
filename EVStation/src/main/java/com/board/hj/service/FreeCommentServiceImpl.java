package com.board.hj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.board.hj.domain.FreeBoardComment;
import com.board.hj.persistence.FreeCommentRepository;

@Service
public class FreeCommentServiceImpl implements FreeCommentService {

	@Autowired
	private FreeCommentRepository commentRepo;
	
	//모든 댓글 출력
	@Override
	public Page<FreeBoardComment> getCommentList(int pNum) {
		Pageable page = PageRequest.of(pNum-1, 5);
		return commentRepo.findByOrderByComnumAsc(page);
	}
	
	//게시판에 작성된 댓글 출력
	@Override
	public Page<FreeBoardComment> getComment(int pNum, Long boardnum) {
		Pageable page = PageRequest.of(pNum-1, 5);
		return commentRepo.findByBoardnumOrderByComnumAsc(page, boardnum);
	}
	
	@Override
	public void saveComment(FreeBoardComment comment) {
		commentRepo.save(comment);	
	}

	@Override
	public FreeBoardComment onlyComment(Long comnum) {
		return commentRepo.getById(comnum);
	}

	@Override
	public void deleteCommentOne(Long comnum) {
		commentRepo.deleteById(comnum);
	}

	@Override
	public void deleteComment(Long boardnum) {
		commentRepo.deleteById(boardnum);		
	}
}
