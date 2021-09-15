package com.board.km.service;

import java.util.List;

import com.board.km.domain.ReviewFile;

public interface ReviewFileService {

	void saveFile(ReviewFile fi);

	List<ReviewFile> getFile(Long boardnum);
}
