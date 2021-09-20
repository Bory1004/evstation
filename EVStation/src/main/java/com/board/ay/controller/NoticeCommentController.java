package com.board.ay.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.board.ay.domain.Board3;
import com.board.ay.domain.NoticeComment;
import com.board.ay.service.NoticeCommentService;

import com.board.hj.domain.Member;


@SessionAttributes("member")
@Controller
public class NoticeCommentController {
	
	// session에 member가 없으면 실행, 있으면 실행되지 않는다.
		@ModelAttribute("member")
		public Member getMember() {
			return new Member();
		}
		
		@Autowired
		private NoticeCommentService noticeService;
		
		//입력한 댓글 저장
		@RequestMapping("/ay/insertComment/{num}")
		@ResponseBody
		public void inserComment(NoticeComment comment, Board3 board, @ModelAttribute("member") Member member, @PathVariable Long num, String content) {
			
			comment.setBoard(board);
			System.out.println(board);
			comment.setMember(member);
		
			comment.setComcontent(content);
			noticeService.saveComment(comment);
		}
		
		//댓글 하나 삭제
		@RequestMapping("/ay/deleteComment")
		@ResponseBody
		public void deleteComment(Long comnum){
			noticeService.deleteCommentOne(comnum);
		}
		
		@RequestMapping("/ay/updateComment")
		@ResponseBody
		public void updateComment(NoticeComment comment) {
			noticeService.saveComment(comment);
			
		}

}
