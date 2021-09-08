package com.board.km.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
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
	public void saveReply(Long comnum) { //제목 댓글 저장
		commentRepo.updategroupnumandcomrestep(comnum);
	}

	@Override
	public List<BoardComment> getComments(int cNum, Long num, Long comrestep) {
		Pageable page =  PageRequest.of(cNum-1, 10); // 불러올페이지, 페이지크기
		return commentRepo.findByBoardnumAndComrestepOrderByComdateAsc(num,comrestep);
	}
	@Override
	public List<BoardComment> getReplyComments(Long num,Long comrestep) {
		
		return commentRepo.findByBoardnumAndComrestepGreaterThanOrderByComdateAsc(num,comrestep);
	}

	@Override
	public void deleteComment(Long comnum) { //commentRepo.deleteByComroupnum
		commentRepo.deleteById(comnum);
	}


	@Override
	public void updateComment(Long comnum, String comcontent) {
		commentRepo.updateComment(comnum,comcontent);
	}

	@Override
	public void saveReStep(Long groupnum,Long comnum) { //대댓글 저장
		commentRepo.updaterestep(groupnum,comnum);
	}//test22

}
