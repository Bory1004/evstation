package com.board.ay.service;

import org.springframework.data.domain.Page;

import com.board.ay.domain.NoticeComment;

public interface NoticeCommentService {

	// 저장
	void saveComment(NoticeComment comment);

	// 모든 댓글 출력
	Page<NoticeComment> getCommentList(int pNum);

	// 게시판에 작성된 댓글 출력
	Page<NoticeComment> getComment(int pNum, Long num);

	// 수정
	NoticeComment onlyComment(Long comnum);

	// 댓글 하나 삭제
	void deleteCommentOne(Long comnum);

	// 댓글 모두 삭제
	void deleteComment(Long num);

}
