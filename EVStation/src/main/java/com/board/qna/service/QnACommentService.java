package com.board.qna.service;



import java.util.List;
import java.util.Optional;

import com.board.km.domain.BoardComment;
import com.board.qna.domain.QnABoardComment;


public interface QnACommentService {
	
	int getComentCount(Long boardnum);
	
	
	List<QnABoardComment>getComments(Long boardnum, Long comrestep);
	List<QnABoardComment>getReplyComments(Long boardnum, Long comrestep);
	

	void withdraw(Long memnum);

	void saveComment(QnABoardComment dsComment);
	void saveReply(Long comnum);
	
	Optional<QnABoardComment> getComment(Long comnum);
	
	int deleteComment(Long comnum, Long comgroupnum); //댓글삭제
	
	void updateComment(Long comnum, String comcontent); //댓글수정




}
 