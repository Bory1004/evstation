package com.board.ay.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.board.ay.domain.NoticeComment;
import com.board.ay.persistence.NoticeCommentRepository;

@Service
public class NoticeCommentServiceImpl implements NoticeCommentService {

	@Autowired
	private NoticeCommentRepository noticeRepo;

	@Override
	public Page<NoticeComment> getCommentList(int pNum) {
		Pageable page = PageRequest.of(pNum-1, 5);
		return noticeRepo.findByOrderByComnumAsc(page);
	}

	@Override
	public Page<NoticeComment> getComment(int pNum, Long num) {
		Pageable page = PageRequest.of(pNum-1, 5);
		return noticeRepo.findByNumOrderByComnumAsc(page, num);
	}
	@Override
	public void saveComment(NoticeComment comment) {
		noticeRepo.save(comment);
	}

	@Override
	public NoticeComment onlyComment(Long comnum) {
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
