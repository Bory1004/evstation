package com.board.free.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.board.free.domain.FreeBoard;
import com.board.free.domain.FreeBoardComment;
import com.board.free.domain.Member;
import com.board.free.service.FreeCommentService;

@SessionAttributes("member")
@Controller
public class FreeCommentController {
	
	// session에 member가 없으면 실행, 있으면 실행되지 않는다.
	@ModelAttribute("member")
	public Member getMember() {
		return new Member();
	}
	
	@Autowired
	private FreeCommentService commentService;
	
	//입력한 댓글 저장
	@RequestMapping("/insertComment/{boardnum}")
	@ResponseBody
	public void inserComment(FreeBoardComment comment, FreeBoard board, @ModelAttribute("member") Member member, @PathVariable Long boardnum, String content) {		
		comment.setBoard(board);
		comment.setMember(member);
		comment.setComcontent(content);
		commentService.saveComment(comment);
	}
	
	//댓글 하나 삭제
	@RequestMapping("/deleteFreeBoardComment")
	@ResponseBody
	public void deleteComment(Long comnum){
		commentService.deleteCommentOne(comnum);
	}
	
	//댓글 수정
	@RequestMapping("/updateFreeBoardComment")
	@ResponseBody
	public void updateComment(@RequestParam Map<String, Object> param) {
		Long comnum = Long.parseLong((String) param.get("comnum"));
		String content = (String) param.get("content");
		commentService.updateComment(comnum, content);
	}
	
	// 게시판 클릭 후 보이는 것(게시글 + 댓글)
	@RequestMapping("/replyFreeComment/{boardnum}")
	public String getBoard(@ModelAttribute("member") Member member, @PathVariable Long boardnum, Model m) {
		List<FreeBoardComment> cList = commentService.getCommentlist(boardnum);
		m.addAttribute("clist", cList);		
		return "redirect:/content/1/"+boardnum;
	}
		
}