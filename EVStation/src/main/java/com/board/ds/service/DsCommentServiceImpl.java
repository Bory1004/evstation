package com.board.ds.service;


import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.ds.domain.DsComment;
import com.board.ds.persistence.DsCommentRepository;

@Service
public class DsCommentServiceImpl implements DsCommentService {

	@Autowired
	private DsCommentRepository DsCoRepo;

	@Override
	public int getComentCount(Long boardnum) {
		return DsCoRepo.getComentCount(boardnum);
	}
	//일반댓글 불러오기
	@Override
	public List<DsComment> getComments(Long boardnum, Long comrestep) {
		return DsCoRepo.findByBoardnumAndComrestepOrderByComdateAsc(boardnum, comrestep); 
	}
	//대댓글만 불러오기
	@Override
	public List<DsComment> getReplyComments(Long boardnum, Long comrestep) {
		return DsCoRepo.findByBoardnumAndComrestepGreaterThanOrderByComdateAsc(boardnum, comrestep);
	}

	@Override
	public void withdraw(Long memnum) {
		DsCoRepo.deleteByMemnum(memnum);
	}
	@Override
	public void saveComment(DsComment dsComment) {
		DsCoRepo.save(dsComment);
	}
	@Override
	public void saveReply(Long comnum) {
		DsCoRepo.updategroupnumandcomrestep(comnum);
	}
	@Override
	public Optional<DsComment> getComment(Long comnum) {
		return DsCoRepo.findById(comnum);
	}
}   
