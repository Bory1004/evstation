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
import org.springframework.web.bind.annotation.SessionAttributes;

import com.board.hj.domain.FreeBoard;
import com.board.hj.domain.FreeComment;
import com.board.hj.domain.Member;
import com.board.hj.service.FreeBoardService;
import com.board.hj.service.FreeCommentService;

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
	
	//작성된 모든 게시판 리스트 + 검색
	@RequestMapping("/getFreeBoardList")
	public String getBoardList(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum,
			@ModelAttribute("member") Member member, String search, @RequestParam(defaultValue = "-1") int searchn) {
		
		/*
		 * if (member.getId() == null) { return "redirect:loginView"; }
		 */
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
	public String insertBoardView() {
		return "hjboard/insertFreeBoard";
	}
	
	//게시판 입력 후 게시판 리스트 출력하는 곳으로 이동
	@PostMapping("/insertFreeBoard")
	public String insertBoard(FreeBoard board, @ModelAttribute("member") Member member) {
		board.setBoardwriter(member.getId());
		board.setBoardmennum(member.getMemnum());
		boardService.saveBoard(board);
		return "redirect:/getFreeBoardList";
	}

	//게시판 클릭 후 보이는 것(게시글 + 댓글)
	@RequestMapping("/content/{boardnum}")
	public String getBoard(@ModelAttribute("member") Member member, @RequestParam(name = "p", defaultValue = "1") int pNum, @PathVariable Long boardnum, Model m) {
		m.addAttribute("member", member);
		
		//게시판
		FreeBoard board = boardService.getBoard(boardnum);
		m.addAttribute("board", board);
		
		//댓글
		Page<FreeComment> pageList = null;
		pageList = commentService.getComment(pNum, boardnum); //해당 게시판 번호의 댓글 1페이지 출력
		List<FreeComment> cList = pageList.getContent();// 보여질 글
		
		int totalPageCount = pageList.getTotalPages();// 전체 페이지 수
		long total = pageList.getTotalElements(); //전제 글 수		

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
		m.addAttribute("clist", cList);
		
		return "hjboard/getFreeBoard";
	}
	
	//게시판 수정 요청 받아서 수정
	@GetMapping("/updateform/{boardnum}")
	public String updateform(@PathVariable Long boardnum, Model m) {
		FreeBoard board = boardService.onlyBoard(boardnum);
		m.addAttribute("board", board);
		return "hjboard/updateFreeBoard";
	}
	
	//게시판 수정 후, 게시판 리스트 출력하는 곳으로 이동
	@PostMapping("/updateFreeBoard")
	public String update(FreeBoard board, @ModelAttribute("member") Member member) {
		board.setBoardmennum(member.getMemnum());
		boardService.saveBoard(board);
		return "redirect:/getFreeBoardList";
	}
	
	//게시판 삭제를 누르면 게시판과 함께 댓글도 삭제 후, 게시판 리스트 출력하는 곳으로 이동
	@GetMapping("/deleteFreeBoard/{boardnum}")
	public String delete(@PathVariable Long boardnum) {
		boardService.deleteBoard(boardnum);
		//commentService.deleteComment(boardnum);
		return "redirect:/getFreeBoardList";
	}
}
