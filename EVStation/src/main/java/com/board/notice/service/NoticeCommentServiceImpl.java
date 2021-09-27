package com.board.notice.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.board.notice.domain.NoticeBoardComment;
import com.board.notice.persistence.NoticeCommentRepository;

@Service
public class NoticeCommentServiceImpl implements NoticeCommentService {

	@Autowired
	private NoticeCommentRepository noticeRepo;

	@Override
	public Page<NoticeBoardComment> getCommentList(int pNum) {
		Pageable page = PageRequest.of(pNum-1, 5);
		return noticeRepo.findByOrderByComnumAsc(page);
	}

	@Override
	public Page<NoticeBoardComment> getComment(int pNum, Long num) {
		Pageable page = PageRequest.of(pNum-1, 5);
		return noticeRepo.findByNumOrderByComnumAsc(page, num);
	}
	@Override
	public void saveComment(NoticeBoardComment comment) {
		noticeRepo.save(comment);
	}

	@Override
	public NoticeBoardComment onlyComment(Long comnum) {
		return noticeRepo.getById(comnum);
	}

	@Override
	public void deleteCommentOne(Long comnum) {
		noticeRepo.deleteById(comnum);
	}

	@Override
	public void deleteComment(Long num) {
		noticeRepo.deleteById(num);

	}

	@Override
	public void withdraw(Long commemnum) {
		noticeRepo.deleteByCommemnum(commemnum);
	}

}
