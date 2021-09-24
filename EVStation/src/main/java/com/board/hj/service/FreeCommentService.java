package com.board.hj.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.board.hj.domain.FreeBoardComment;

public interface FreeCommentService {
	
	//저장
	void saveComment(FreeBoardComment comment);
	
	//모든 댓글 출력
	Page<FreeBoardComment> getCommentList(int pNum);
	
	//게시판에 작성된 댓글 출력
	Page<FreeBoardComment> getComment(int pNum, Long boardnum);
			
	//수정
	FreeBoardComment onlyComment(Long comnum);
	
	//댓글 하나 삭제
	void deleteCommentOne(Long comnum);
	
	//댓글 모두 삭제
	void deleteComment(Long boardnum);
	
	//댓글 수정
	void updateComment(Long comnum, String content);
	
	List<FreeBoardComment> getCommentlist(Long boardnum);

	void withdraw(Long memnum);
}