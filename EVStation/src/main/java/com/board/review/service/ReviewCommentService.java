package com.board.review.service;

import java.util.List;
import java.util.Optional;

import com.board.review.domain.ReviewBoardComment;

public interface ReviewCommentService {

	void saveComment(ReviewBoardComment board);


	Optional<ReviewBoardComment> getComment(Long comnum);


	void saveReply(Long comnum);


	List<ReviewBoardComment> getComments(int cNum, Long num, Long comrestep);


	int deleteComment(Long comnum, Long comgroupnum);
	
	void deleteComment(Long boardnum);

	void updateComment(Long comnum, String comcontent);

	void saveReStep(Long groupnum,Long comnum);


	List<ReviewBoardComment> getReplyComments(Long num,Long comrestep);


	List<ReviewBoardComment> getmembernum(Long comgroupnum);
	
	int getCount(Long num);


	void withdraw(Long memnum);

}
