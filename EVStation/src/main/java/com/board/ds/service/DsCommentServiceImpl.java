package com.board.ds.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.board.ds.domain.DsComment;
import com.board.ds.persistence.DsCommentRepository;

@Service
public class DsCommentServiceImpl implements DsCommentService {

	@Autowired
	private DsCommentRepository DsCoRepo;
	
	@Override
	public DsComment saveQnaComment(DsComment dsComment) {
				
				return  DsCoRepo.save(dsComment);
	}
  //모든 댓글 출력
	@Override
	public Page<DsComment> QnACommentList(int pNum) {
		Pageable page = PageRequest.of(pNum-1, 5);		
		return DsCoRepo.findByOrderByComnumDesc(page);
	}
//겟판에 작성된 댓글 출력
	@Override
	public Page<DsComment> QnAComment(int pNum, Long boardnum) {
		Pageable page = PageRequest.of(pNum-1, 5);
		return DsCoRepo.findByBoardnumOrderByComnumDesc(page, boardnum);
	}

}   
