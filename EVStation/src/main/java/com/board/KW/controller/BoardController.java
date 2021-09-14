package com.board.KW.controller;

import java.awt.print.Pageable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.board.KW.domain.Board;
import com.board.KW.persistence.BoardRepository;
import com.board.KW.service.BoardService;

import lombok.RequiredArgsConstructor;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;

	@RequestMapping("/getBoardList")
	public String getBoardList(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum, String search, @RequestParam(defaultValue = "-1") int searchn) {
		
		int pageNum = 5;
		
		Page<Board> pageList = null;
		if(search != null) {
			pageList = BoardService.AllListQnA(pNum, searchn, search);
			}else {
			pageList = BoardService.AllListQnA(pNum);	
			}
		List<Board> bList = pageList.getContent();// 보여질 글
		int totalPageCount = pageList.getTotalPages();// 전체 페이지 수
		long total = pageList.getTotalElements();
		m.addAttribute("blist", bList);
		m.addAttribute("totalPage", totalPageCount);
		m.addAttribute("total", total);
		
		
		int begin = (pNum - 1) / pageNum * pageNum + 1;
		int end = begin + pageNum - 1;
		if (end > totalPageCount) {
			end = totalPageCount;
		}

		m.addAttribute("begin", begin);
		m.addAttribute("end", end);

		return "getBoardList";
	}

	@RequestMapping("/content/{num}")
	public String getBoard(@PathVariable Long num, Model m) {
		Board board = boardService.getBoard(num);
		m.addAttribute("board", board);
		
		return "getBoard";
	}

	
	@RequestMapping("/openMap")
	public String mapView(Model m) {
		List<Board> list = boardService.openMap();
		m.addAttribute("list",list);
		return "openMap";
	}

}
