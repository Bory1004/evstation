package com.board.km.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.km.domain.ReviewFile;
import com.board.km.persistence.ReviewFileRepository;

@Service
public class ReviewFileServiceImpl implements ReviewFileService {

	@Autowired
	ReviewFileRepository Refilerepo;
	
	@Override
	public void saveFile(ReviewFile fi) {
		Refilerepo.save(fi);
	}

	@Override
	public List<ReviewFile> getFile(Long boardnum) {
		return Refilerepo.findByBoardnum(boardnum);
	}

}
