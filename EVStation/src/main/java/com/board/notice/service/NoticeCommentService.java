package com.board.notice.service;

import org.springframework.data.domain.Page;

import com.board.notice.domain.NoticeBoardComment;

public interface NoticeCommentService {

	// 저장
	void saveComment(NoticeBoardComment comment);

	// 모든 댓글 출력
	Page<NoticeBoardComment> getCommentList(int pNum);

	// 게시판에 작성된 댓글 출력
	Page<NoticeBoardComment> getComment(int pNum, Long num);

	// 수정
	NoticeBoardComment onlyComment(Long comnum);

	// 댓글 하나 삭제
	void deleteCommentOne(Long comnum);

	// 댓글 모두 삭제
	void deleteComment(Long num);

	void withdraw(Long commemnum);

}
