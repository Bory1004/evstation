package com.board.review.service;

import java.util.List;

import com.board.review.domain.ReviewFile;

public interface ReviewFileService {

	void saveFile(ReviewFile fi);

	List<ReviewFile> getFile(Long boardnum);
}
