package com.board.ay.controller;

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

import com.board.ay.domain.Board3;
import com.board.ay.service.BoardService3;
import com.board.hj.domain.Member;

@SessionAttributes("member")
@Controller
public class BoardController3 {

	@ModelAttribute("member")
	public Member getMember() {
		return new Member();
	}
	
	@Autowired
	private BoardService3 boardService;
	
	@RequestMapping("/upRecom/{num}/{id}")
	@ResponseBody
	public long upRecom(@PathVariable Long num, @PathVariable String id, Model m,@ModelAttribute("member")Member member) {
		
		int result = boardService.isRecom(num, id);
		Board3 board = null;
		if(result == 0) {
			boardService.insertRecom(num, id);
			board = boardService.upRecom(num);
		} else {
			boardService.del(id, num);
			board = boardService.dnRecom(num);
		}
		return board.getRecom();
	}
	
	@RequestMapping("/ay/content/{num}")//@PathVariable > url경로에 변수 넣어줌
	public String getBoard(@PathVariable Long num, Model m,@ModelAttribute("member")Member member) {
		Board3 board = boardService.getBoard(num);
		m.addAttribute("board", board);

		if(member.getId() != null) { 
		int result = boardService.isRecom(num, member.getId());
		m.addAttribute("result", result);
		}
		return "/ayboard/getBoard";
	}
	@RequestMapping("/ay/getBoardList")
	public String getBoardList(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum, @ModelAttribute("member")Member member,String search,@RequestParam(defaultValue = "-1")int searchn) {//뷰한테 보낼 때 항상 모델 사용!
		Page<Board3> pageList = null;
		if(search != null) {
			pageList = boardService.getBoardList(pNum,searchn,search);
		}else {
			pageList = boardService.getBoardList(pNum);
		}
		List<Board3> bList = pageList.getContent();// 보여질 글
		int totalPageCount = pageList.getTotalPages();// 전체 페이지 수
		long total = pageList.getTotalElements();
		m.addAttribute("blist", bList);
		m.addAttribute("totalPage", totalPageCount);
		m.addAttribute("total", total);
		System.err.println("total : "+total);
		int pageNum = 5;
		int begin = (pNum - 1) / pageNum * pageNum + 1;
		int end = begin + pageNum - 1;
		if (end > totalPageCount) {
			end = totalPageCount;
		}

		m.addAttribute("begin", begin);
		m.addAttribute("end", end);
		m.addAttribute("search", search);
		m.addAttribute("searchn", searchn);
		
		return "/ayboard/getBoardList";
	}
	
	@GetMapping("/ay/insertBoard")
	public String insertBoardView() {
		return "/ayboard/insertBoard";
	}
	
	@PostMapping("/ay/insertBoard") 
	//@RequestMapping(value = "insertBoard", method= {RequestMethod.GET, RequestMethod.POST})
	public String insertBoard(Board3 board) {//새로 글 써서 보드에 넘겨
		boardService.saveBoard(board);
		return "redirect:getBoardList";
	}
	
	@GetMapping("/ay/updateForm/{num}")
	public String updateForm(@PathVariable Long num, Model m) {
	Board3 board = boardService.update(num);
	m.addAttribute("board", board);
	return "/ayboard/updateForm";
	}
	
	@PostMapping("/ay/update")
	public String update(Board3 board) {
		boardService.saveBoard(board);
		return "redirect:getBoardList";
	}
	
	@RequestMapping("/ay/delete/{num}")
	public String delete(@PathVariable Long num) {
		boardService.delete(num);
		return "redirect:/getBoardList";
	}
	
	
}
