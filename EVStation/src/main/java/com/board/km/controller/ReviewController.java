package com.board.km.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.km.domain.BoardComment;
import com.board.km.domain.ReviewBoard;
import com.board.km.service.CommentService;
import com.board.km.service.ReviewService;
import com.google.gson.Gson;


@Controller
public class ReviewController {
	
	@Autowired
	ReviewService reviewService;
	
	@Autowired
	CommentService commentService;
	
	@RequestMapping("/reviewList")
	public String reviewList(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum,  
			String search, @RequestParam(defaultValue = "-1") int searchn, @RequestParam(name="stnum",defaultValue ="2") Long stnum ) {
		
		Page<ReviewBoard> pageList =null;
		if(search != null) { //검색값이 있을때
			pageList = reviewService.getReviewBoardList(pNum,stnum,searchn,search);
		}else { 
			pageList = reviewService.getReviewBoardList(pNum,stnum); //페이지번호와 충전소번호
		}
		
	
		List<ReviewBoard> rList = pageList.getContent();
		m.addAttribute("rList", rList);
		
		//여기서부터 페이징 부분
		int totalPageCount = pageList.getTotalPages();
		long total = pageList.getTotalElements(); //글의 총개수
		//System.out.println(rList.get(0).getBoardnum());
		m.addAttribute("totalPage",totalPageCount);
		m.addAttribute("total",total); //글이없으면 글이 없다고 출력
		m.addAttribute("pNum",pNum);
		
		int pageNum = 5; //페이지크기
		int begin = (pNum -1) / pageNum * pageNum + 1; //  1 1 1 1 1 6 6 6 6 6  11 11....
		int end = begin + pageNum-1; // 5 5 5 5 5 10 10 10 10 ..
		if (end > totalPageCount) {
			end = totalPageCount;
		}
		
		m.addAttribute("begin", begin);
		m.addAttribute("end", end);
		m.addAttribute("search", search);
		m.addAttribute("searchn", searchn);
		m.addAttribute("stnum",stnum);
		//System.out.println("test");
		return "kmboard/review/reviewlist";
	}
	
	@RequestMapping("content/{num}")
	public String getReview(@PathVariable Long num,@RequestParam(name= "p") int pNum,String search, 
			int searchn,Model m) {
		ReviewBoard review = reviewService.getReview(num);
		
		
		m.addAttribute("review",review); //가져온 리뷰객체
		m.addAttribute("pNum",pNum); //목록으로 돌아갈때 필요
		m.addAttribute("search",search); // 목록으로 돌아갈때 필요
		m.addAttribute("searchn",searchn); //목록으로 돌아갈때 필요
	
		//-------------------------------------------------- 댓글 로딩 부분
		List<BoardComment> comments =commentService.getComments(1,num, (long) 0);
		m.addAttribute("comments",comments); //제목댓글만받아오기
		List<BoardComment> replycomments = commentService.getReplyComments(num,(long) 0);
		m.addAttribute("replycomments",replycomments); // 대댓글만 받아오기
		return "kmboard/review/getreview";
	}
	
	@RequestMapping("/reviewwrite")
	public String gowriteform(@RequestParam(name="stnum",defaultValue ="-1") Long stnum,Model m) {
		m.addAttribute("stnum",stnum);
		if (stnum == -1) {
			return "redirect:/reviewList";
		}
		return "kmboard/review/reviewwrite";
	}
	@PostMapping("/reviewwrite")
	public String reviewwrite(ReviewBoard board) {
		reviewService.saveReview(board);
		
		return "redirect:/reviewList";
	}
	
	@RequestMapping(value = "content/insertComment",method=RequestMethod.GET ,produces = "text/plain;charset=UTF-8")
	public String insertComment(BoardComment board) { //댓글달기
		commentService.saveComment(board);
		commentService.saveReply(board.getComnum());
		Long comnum = board.getComnum();
		
		
		return "redirect:/content2?comnum="+comnum;
	}
	@RequestMapping(value = "content2", method=RequestMethod.GET ,produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String goComment(Long comnum) { //댓글달기1이어서
		BoardComment list = commentService.getComment(comnum).get();
		Gson json = new Gson();
		return json.toJson(list);
	}
	
	@RequestMapping(value="/content/deleteComment",method=RequestMethod.GET ,produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String deleteComment(Long comnum , Long comgroupnum) {//댓글삭제
		System.out.println(comnum);
		System.out.println(comgroupnum);
		commentService.deleteComment(comnum,comgroupnum);
		return "Success!!";
	}
	
	@RequestMapping(value="updateComment",method=RequestMethod.GET ,produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String updateComment(Long comnum,String comcontent) { //댓글수정
		commentService.updateComment(comnum,comcontent);
		return "Success!!";
	}
	
	@RequestMapping(value="/replyComment",method=RequestMethod.GET ,produces = "text/plain;charset=UTF-8")
	public String replyComment(BoardComment board) { // 대댓글달기 boardnum,comcontent,comgroupnum 변수필요
		commentService.saveComment(board);
		//System.out.println(board);
		commentService.saveReStep(board.getComgroupnum(),board.getComnum()); //여기서 restep의 값을 저장한다.
		
		return "redirect:/content2?comnum="+board.getComnum();
	}
	
	
	
}
