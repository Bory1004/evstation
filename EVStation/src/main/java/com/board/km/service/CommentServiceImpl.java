package com.board.km.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.km.domain.BoardComment;
import com.board.km.persistence.CommentRepository;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	CommentRepository commentRepo;
	
	@Override
	public Optional<BoardComment> getComment(Long comnum) {
		return commentRepo.findById(comnum);
	}
	
	
	@Override
	public void saveComment(BoardComment board) {
		commentRepo.save(board);
	}

	@Override
	public void saveReply(Long comnum) {
		commentRepo.updategroupnum(comnum);
	}

	@Override
	public List<BoardComment> getComments(Long num) {
		return commentRepo.findByBoardnumOrderByComdateAsc(num);
	}


	@Override
	public void deleteComment(Long comnum) {
		commentRepo.deleteById(comnum);
	}
}
