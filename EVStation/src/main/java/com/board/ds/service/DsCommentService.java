package com.board.ds.service;



import java.util.List;

import com.board.ds.domain.DsComment;


public interface DsCommentService {
	
	int getComentCount(Long boardnum);
	
	
	List<DsComment>getComments(Long boardnum, Long comrestep);
	List<DsComment>getReplyComments(Long boardnum, Long comrestep);
	

	void withdraw(Long memnum);

}
 