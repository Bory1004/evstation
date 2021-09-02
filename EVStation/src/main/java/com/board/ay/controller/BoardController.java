package com.board.ay.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.board.ay.domain.Board;
import com.board.ay.service.BoardService;


@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@RequestMapping("/getBoardList")
	public String getBoardList(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum, String search,@RequestParam(defaultValue = "-1")int searchn) {//뷰한테 보낼 때 항상 모델 사용!
		Page<Board> pageList = null;
		if(search != null) {
			pageList = boardService.getBoardList(pNum,searchn,search);
		}else {
			pageList = boardService.getBoardList(pNum);
		}
		List<Board> bList = pageList.getContent();// 보여질 글
		int totalPageCount = pageList.getTotalPages();// 전체 페이지 수
		long total = pageList.getTotalElements();
		m.addAttribute("blist", bList);
		m.addAttribute("totalPage", totalPageCount);
		m.addAttribute("total", total);
		System.err.println("total : "+total);
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
		
		return "getBoardList";
	}
	
	@GetMapping("/insertBoard")
	public String insertBoardView() {
		return "insertBoard";
	}
	
	@PostMapping("/insertBoard") 
	//@RequestMapping(value = "insertBoard", method= {RequestMethod.GET, RequestMethod.POST})
	public String insertBoard(Board board) {//새로 글 써서 보드에 넘겨
		boardService.saveBoard(board);
		return "redirect:getBoardList";
	}
	
	@RequestMapping("/content/{num}")
	public String getBoard(@PathVariable Long num, Model m) {
		Board board = boardService.getBoard(num);
		m.addAttribute("board", board);
		return "getBoard";
	}
	@RequestMapping("/upRecom/{num}")
	//@ResponseBody
	public String upRecom(@PathVariable Long num, Model m) {
		Board board = boardService.upRecom(num);
		m.addAttribute("board", board);
//		Gson g = new Gson();
		return "getBoard";
	}
	
	@GetMapping("/updateForm/{num}")
	public String updateForm(@PathVariable Long num, Model m) {
	Board board = boardService.update(num);
	m.addAttribute("board", board);
	return "updateForm";
	}
	
	@PostMapping("/update")
	public String update(Board board) {
		boardService.saveBoard(board);
		return "redirect:getBoardList";
	}
	
	@RequestMapping("/delete/{num}")
	public String delete(@PathVariable Long num) {
		boardService.delete(num);
		return "redirect:/getBoardList";
	}
	
	
}
