package com.board.hj.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.board.hj.domain.Comment;
import com.board.hj.persistence.CommentRepository2;

@Service
public class CommentServiceImpl2 implements CommentService2 {

	@Autowired
	private CommentRepository2 commentRepo;
	
	//모든 댓글 출력
	@Override
	public Page<Comment> getCommentList(int pNum) {
		Pageable page = PageRequest.of(pNum-1, 5);
		return commentRepo.findByOrderByComnumAsc(page);
	}
	
	//게시판에 작성된 댓글 출력
	@Override
	public Page<Comment> getComment(int pNum, Long boardnum) {
		Pageable page = PageRequest.of(pNum-1, 5);
		return commentRepo.findByBoardnumOrderByComnumAsc(page, boardnum);
	}
	
	@Override
	public void saveComment(Comment comment) {
		commentRepo.save(comment);	
	}

	@Override
	public Comment onlyComment(Long comnum) {
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
