package com.board.ds.service;



import java.util.List;
import java.util.Optional;

import com.board.ds.domain.DsComment;
import com.board.km.domain.BoardComment;


public interface DsCommentService {
	
	int getComentCount(Long boardnum);
	
	
	List<DsComment>getComments(Long boardnum, Long comrestep);
	List<DsComment>getReplyComments(Long boardnum, Long comrestep);
	

	void withdraw(Long memnum);

	void saveComment(DsComment dsComment);
	void saveReply(Long comnum);
	
	Optional<DsComment> getComment(Long comnum);
	
	int deleteComment(Long comnum, Long comgroupnum); //댓글삭제
	
	void updateComment(Long comnum, String comcontent); //댓글수정




}
 