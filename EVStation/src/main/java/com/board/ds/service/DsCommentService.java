package com.board.ds.service;

import java.util.List;

import com.board.ds.domain.DsComment;

public interface DsCommentService {
	
	void saveQnaComment(DsComment dsComment); //댓글 저장

	List<DsComment> QnACommentList(Long boardnum);
}
 