package com.board.ds.service;


import org.springframework.data.domain.Page;

import com.board.ds.domain.DsComment;


public interface DsCommentService {
	
	DsComment saveQnaComment(DsComment dsComment); //댓글 저장

	Page<DsComment> QnACommentList(int pNum); //모든 댓글 출력 

	Page<DsComment> QnAComment(int pNum, Long boardnum); //게시판에 작성된 댓글 출력 

}
 