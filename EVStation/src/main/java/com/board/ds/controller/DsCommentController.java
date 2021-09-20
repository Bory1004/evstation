package com.board.ds.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.board.ds.domain.DsComment;
import com.board.ds.domain.DsEntity;
import com.board.ds.service.DsCommentService;
import com.board.hj.domain.Member;
import com.google.gson.Gson;

@SessionAttributes("member")
@Controller
public class DsCommentController {
	
	// session에 member가 없으면 실행, 있으면 실행되지 않는다.
		@ModelAttribute("member")
		public Member getMember() {
			return new Member();
		}

		@Autowired
		private DsCommentService dsCoService;
		
		@RequestMapping("/insertQnAComment/{boardnum}")
		@ResponseBody
		public String insetQnAComment(DsComment dc, DsEntity de,@ModelAttribute("member") Member member,@PathVariable Long boardnum, String comcontent) {
			
			dc.setDsEntity(de);
			dc.setMember(member);
			dc.setComcontent(comcontent); //입력한 댓글을 받아와서 db에 저장
			Gson gson = new Gson();
			
			return gson.toJson(dsCoService.saveQnaComment(dc))  ;
		}

}
