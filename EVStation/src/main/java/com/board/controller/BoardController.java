package com.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.board.domain.Board;
import com.board.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;

	@RequestMapping("/getBoardList")
	public String getBoardList(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum) {
		Page<Board> pageList = boardService.getBoardList(pNum);
		List<Board> bList = pageList.getContent();// 보여질 글
		int totalPageCount = pageList.getTotalPages();// 전체 페이지 수
		m.addAttribute("blist", bList);
		m.addAttribute("totalPage", totalPageCount);
		int pageNum = 5;
		int begin = (pNum - 1) / pageNum * pageNum + 1;
		int end = begin + pageNum - 1;
		if (end > totalPageCount) {
			end = totalPageCount;
		}

		m.addAttribute("begin", begin);
		m.addAttribute("end", end);

		return "getBoardList";
	}

	@GetMapping("/insertBoard")
	public String insertBoardView() {
		return "insertBoard";
	}

	@PostMapping("/insertBoard")
	public String insertBoard(Board board) {
		boardService.saveBoard(board);
		return "redirect:getBoardList";
	}

	@RequestMapping("/content/{num}")
	public String getBoard(@PathVariable Long num, Model m) {
		Board board = boardService.getBoard(num);
		m.addAttribute("board", board);
		
		return "getBoard";
	}

	@GetMapping("/updateform/{num}")
	public String updateform(@PathVariable Long num, Model m) {
		Board board = boardService.onlyBoard(num);
		m.addAttribute("board", board);
		return "updateform";
	}

	@PostMapping("/update")
	public String update(Board board) {
		boardService.saveBoard(board);
		return "redirect:getBoardList";
	}

	@GetMapping("/delete/{num}")
	public String delete(@PathVariable Long num) {
		boardService.deleteBoard(num);
		return "redirect:/getBoardList";
	}
	
	@RequestMapping("/openMap")
	public String mapView(Model m) {
		List<Board> list = boardService.openMap();
		m.addAttribute("list",list);
		return "openMap";
	}
}
