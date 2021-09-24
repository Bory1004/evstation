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


}
 