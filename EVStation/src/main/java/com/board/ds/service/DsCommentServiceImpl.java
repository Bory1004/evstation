package com.board.ds.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.ds.domain.DsComment;
import com.board.ds.persistence.DsCommentRepository;

@Service
public class DsCommentServiceImpl implements DsCommentService {

	@Autowired
	private DsCommentRepository DsCoRepo;
	
	@Override
	public void saveQnaComment(DsComment dsComment) {
				 DsCoRepo.save(dsComment);
	}

	@Override //댓글출력부분
	public List<DsComment> QnACommentList(Long boardnum) {
		return DsCoRepo.findByBoardnumOrderByComnumAsc(boardnum);
	}

}   
