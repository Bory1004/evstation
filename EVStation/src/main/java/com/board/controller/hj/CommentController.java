package com.board.controller.hj;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.board.domain.hj.Board;
import com.board.domain.hj.Comment;
import com.board.domain.hj.Member;
import com.board.service.hj.CommentService;

@SessionAttributes("member")
@Controller
public class CommentController {
	
	// session에 member가 없으면 실행, 있으면 실행되지 않는다.
	@ModelAttribute("member")
	public Member getMember() {
		return new Member();
	}
	
	@Autowired
	private CommentService commentService;
	
	//입력한 댓글 저장
	@RequestMapping("/insertComment/{boardnum}")
	@ResponseBody
	public void inserComment(Comment comment, Board board, @ModelAttribute("member") Member member, @PathVariable Long boardnum, String content) {
		//comment.setWriter(member.getId());
		comment.setCommennum(member.getMemnum());
		comment.setBoardnum(boardnum);
		comment.setComcontent(content);
		commentService.saveComment(comment);
	}
	
	//댓글 하나 삭제
	@RequestMapping("/deleteComment")
	@ResponseBody
	public void deleteComment(Long comnum){
		commentService.deleteCommentOne(comnum);
	}
	
	@RequestMapping("/updateComment")
	@ResponseBody
	public void updateComment(Comment comment) {
		//Comment comment = commentService.onlyComment(comnum);
		//comment.setComnum(comnum);
		commentService.saveComment(comment);
		//return "content/" + boardnum;
	}
}