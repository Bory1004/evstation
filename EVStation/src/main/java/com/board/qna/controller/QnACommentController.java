package com.board.qna.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.board.member.domain.Member;
import com.board.qna.domain.QnABoardComment;
import com.board.qna.service.QnACommentService;
import com.google.gson.Gson;

@SessionAttributes("member")
@Controller
public class QnACommentController {
	
	// session에 member가 없으면 실행, 있으면 실행되지 않는다.
		@ModelAttribute("member")
		public Member getMember() {
			return new Member();
		}

		@Autowired
		private QnACommentService dsCoService;
		
		@RequestMapping(value = "qnaDetail/insertQnAComment",method=RequestMethod.GET ,produces = "text/plain;charset=UTF-8")
		public String insertComment(QnABoardComment dsComment) { //댓글달기
			dsCoService.saveComment(dsComment);     //comnum, boardnum, comcontent 저장
			dsCoService.saveReply(dsComment.getComnum()); // comgroupnum, comrestep 저장
			Long comnum = dsComment.getComnum();
			
			
			return "redirect:/qnaDetail2?comnum="+comnum;
		}
		@RequestMapping(value = "qnaDetail2", method=RequestMethod.GET ,produces = "text/plain;charset=UTF-8")
		@ResponseBody
		public String goComment(Long comnum) { //댓글달기와 대댓글달기 이어서받음. 요청을나눈이유는 바로 ajax로 가면 데이터베이스에는 저장되있는데 엔티티에는 저장이 안되있음.
			QnABoardComment list = dsCoService.getComment(comnum).get();
			System.out.println(list);
			Gson json = new Gson();
			return json.toJson(list);   
		}
		@RequestMapping(value = "/qnaDetail/deleteQnAComment", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
		@ResponseBody
		public String deleteComment(Long comnum, Long comgroupnum) {// 댓글삭제
			String cnt = dsCoService.deleteComment(comnum, comgroupnum) + "";
			return cnt;
		}
		
		@RequestMapping(value = "updateQnAComment", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
		@ResponseBody
		public String updateComment(Long comnum, String comcontent) { // 댓글수정
			dsCoService.updateComment(comnum, comcontent);
			return "Success!!";
		}	
}
