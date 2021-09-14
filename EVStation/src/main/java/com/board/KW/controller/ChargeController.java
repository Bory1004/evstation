package com.board.KW.controller;

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

import com.board.KW.domain.Charge;
import com.board.KW.service.ChargeService;

@Controller
public class ChargeController {

	@Autowired
	private ChargeService boardService;

	@RequestMapping("/getBoardList")
	public String getBoardList(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum) {
		Page<Charge> pageList = boardService.getBoardList(pNum);
		List<Charge> bList = pageList.getContent();// 보여질 글
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

	@RequestMapping("/content/{num}")
	public String getBoard(@PathVariable Long num, Model m) {
		Charge board = boardService.getBoard(num);
		m.addAttribute("board", board);
		
		return "getBoard";
	}

	
	@RequestMapping("/openMap")
	public String mapView(Model m) {
		List<Charge> list = boardService.openMap();
		m.addAttribute("list",list);
		return "openMap";
	}
}
