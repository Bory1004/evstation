package com.board.km.service;

import java.util.List;
import java.util.Optional;

import com.board.km.domain.BoardComment;

public interface CommentService {

	void saveComment(BoardComment board);


	Optional<BoardComment> getComment(Long comnum);


	void saveReply(Long comnum);


	List<BoardComment> getComments(Long num);

}
