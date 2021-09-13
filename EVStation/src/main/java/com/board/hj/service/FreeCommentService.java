package com.board.hj.service;

import org.springframework.data.domain.Page;

import com.board.hj.domain.FreeComment;

public interface FreeCommentService {
	
	//저장
	void saveComment(FreeComment comment);
	
	//모든 댓글 출력
	Page<FreeComment> getCommentList(int pNum);
	
	//게시판에 작성된 댓글 출력
	Page<FreeComment> getComment(int pNum, Long boardnum);
			
	//수정
	FreeComment onlyComment(Long comnum);
	
	//댓글 하나 삭제
	void deleteCommentOne(Long comnum);
	
	//댓글 모두 삭제
	void deleteComment(Long boardnum);
	
}