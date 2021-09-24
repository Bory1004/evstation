package com.board.hj.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.board.hj.domain.FreeBoard;
import com.board.hj.domain.FreeBoardComment;
import com.board.hj.domain.Member;
import com.board.hj.service.FreeBoardService;
import com.board.hj.service.FreeCommentService;
import com.board.hj.service.FreeRecomService;

@SessionAttributes("member")
@Controller
public class FreeBoardController {
	
	//session에 member가 없으면 실행, 있으면 실행되지 않는다.
	@ModelAttribute("member")
	public Member getMember() {
		return new Member();
	}

	@Autowired
	private FreeBoardService boardService;
	
	@Autowired
	private FreeCommentService commentService;
	
	@Autowired
	private FreeRecomService recomService;
	
	//캐러셀
	@GetMapping("/news")
	public String newsView() {
		return "news";
	}
	
	//작성된 모든 게시판 리스트 + 검색
	@RequestMapping("/getFreeBoardList")
	public String getBoardList(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum,
			@ModelAttribute("member") Member member, String search, @RequestParam(defaultValue = "-1") int searchn) {
		
		Page<FreeBoard> pageList = null;
		if (search != null) {
			pageList = boardService.getBoardList(pNum, searchn, search); //search = 검색어
			String search_msg = "\"" + search + "\" 검색 결과";
			m.addAttribute("search_msg", search_msg);
		} else {
			pageList = boardService.getBoardList(pNum);
		}
		
		List<FreeBoard> bList = pageList.getContent();// 보여질 글
		
		int totalPageCount = pageList.getTotalPages();// 전체 페이지 수
		long total = pageList.getTotalElements(); //전제 글 수		
		m.addAttribute("blist", bList);
		m.addAttribute("totalPage", totalPageCount);
		m.addAttribute("total", total);
		
		//System.err.println("total : " + total);
		int pageNum = 2;
		int begin = (pNum - 1) / pageNum * pageNum + 1;
		int end = begin + pageNum - 1;
		if (end > totalPageCount) {
			end = totalPageCount;
		}

		m.addAttribute("begin", begin);
		m.addAttribute("end", end);
		m.addAttribute("search", search);
		m.addAttribute("searchn", searchn);

		return "hjboard/getFreeBoardList";
	}

	//게시판 입력 폼으로 이동
	@GetMapping("/insertFreeBoard")
	public String insertBoardView(@ModelAttribute("member") Member member) {
		if (member.getId() == null) {
			return "redirect:loginView";
		}
		return "hjboard/insertFreeBoard";
	}
	
	//게시판 입력 후 게시판 리스트 출력하는 곳으로 이동
	@RequestMapping("/insertFreeBoard")
	public String insertBoard(FreeBoard board, @ModelAttribute("member") Member member) {
		board.setMember(member);
		board.setBoardwriter(member.getId());
		board.setBoardrecom((long) 0);
		boardService.saveBoard(board);
		return "redirect:/getFreeBoardList";
	}

	//게시판 클릭 후 보이는 것(게시글 + 댓글)
	@RequestMapping("/content/1/{boardnum}")
	public String getBoard(@ModelAttribute("member") Member member, @RequestParam(name = "p", defaultValue = "1") int pNum, 
			@PathVariable Long boardnum, Model m) {
		m.addAttribute("member", member);
		
		//게시판
		FreeBoard board = boardService.getBoard(boardnum);
		m.addAttribute("board", board);
		
		//댓글
		Page<FreeBoardComment> pageList = null;
		pageList = commentService.getComment(pNum, boardnum); //해당 게시판 번호의 댓글 1페이지 출력
		List<FreeBoardComment> cList = pageList.getContent();// 보여질 글
		
		int totalPageCount = pageList.getTotalPages();// 전체 페이지 수
		long total = pageList.getTotalElements(); //전제 글 수		

		m.addAttribute("totalPage", totalPageCount);
		m.addAttribute("total", total);
		
		int pageNum = 2;
		int begin = (pNum - 1) / pageNum * pageNum + 1;
		int end = begin + pageNum - 1;
		if (end > totalPageCount) {
			end = totalPageCount;
		}
		
		m.addAttribute("begin", begin);
		m.addAttribute("end", end);
		m.addAttribute("clist", cList);
		//추천 
		int result = recomService.isRecom(boardnum, member.getId());
		m.addAttribute("result",result);

		return "hjboard/getFreeBoard";
	} 
	
	//추천기능
	@RequestMapping("/updateFreeRecom/{num}/{id}")
	@ResponseBody
	public long updateQnaRecom(@PathVariable Long num, @PathVariable String id) {
		int result = recomService.isRecom(num, id);
		FreeBoard freeBoard = null ;
		if(result == 0) {
			recomService.insertRecom(num,id);
			freeBoard = boardService.upRecom(num); 
		}else { 
			recomService.deleteRecom(num,id);
			freeBoard = boardService.dnRecom(num);
		}
		return freeBoard.getBoardrecom();
	}
	
	
	
	
	
	//게시판 수정 요청 받아서 수정
	@GetMapping("/updateFreeBoard/{boardnum}")
	public String updateform(@ModelAttribute("member") Member member, @PathVariable Long boardnum, Model m) {
		if (member.getId() == null) {
			return "redirect:loginView";
		}
		
		FreeBoard board = boardService.onlyBoard(boardnum);
		m.addAttribute("board", board);
		return "hjboard/updateFreeBoard";
	}
	
	//게시판 수정 후, 게시판 리스트 출력하는 곳으로 이동
	@PostMapping("/updateFreeBoard")
	public String update(FreeBoard board, @ModelAttribute("member") Member member) {
		board.setMember(member);
		boardService.saveBoard(board);		
		Long boardnum = board.getBoardnum();
		return "redirect:/content/1/"+boardnum;
	}
	
	//게시판 삭제를 누르면 게시판과 함께 댓글도 삭제 후, 게시판 리스트 출력하는 곳으로 이동
	@GetMapping("/deleteFreeBoard/{boardnum}")
	public String delete(@PathVariable Long boardnum) {
		commentService.deleteComment(boardnum);
		boardService.deleteBoard(boardnum);
		return "redirect:/getFreeBoardList";
	}
	
	
	
	//내가 쓴글 // 대순이씀
    @RequestMapping("/myFreeBoardList/{boardmennum}")
	public String myList(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum, @PathVariable Long boardmennum){
	
		Page<FreeBoard> pageList = null;
		int pageNum = 5;
		
	
	
		pageList = boardService.myFreeList(pNum, boardmennum);
		
		List<FreeBoard> list = pageList.getContent();  
		m.addAttribute("list", list);
    
		System.out.println(list);
		int totalPageCount = pageList.getTotalPages();
		long total = pageList.getTotalElements();

		m.addAttribute("totalPage", totalPageCount);
		m.addAttribute("total", total);

		int begin = (pNum - 1) / pageNum * pageNum + 1;
		int end = begin + pageNum - 1;
		if (end > totalPageCount) {
			end = totalPageCount;
		}

		m.addAttribute("begin", begin);
		m.addAttribute("end", end);

		return "hjboard/myFreeBoardList";
	}
	
    @RequestMapping("/deleteFreeChk")
	public String freeDeletechk(int[] valueArr) {

		int size = valueArr.length; // 선택된 체크박스의 길이를 변수에 정의

		for (int i = 0; i < size; i++) {
			commentService.deleteComment((long)valueArr[i]);
			boardService.deleteChk(valueArr[i]);
		}

		return "redirect:/getFreeBoardList";
	}
}
