package com.board.KW.controller;

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

import com.board.KW.domain.Charge;
import com.board.KW.service.ChargeService;
import com.board.hj.domain.Member;

@Controller
public class ChargeController {

	@Autowired
	private ChargeService chargeService;
	
	// 리스트 + 검색
	@RequestMapping("/getChargeList")
	public String getBoardList(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum, 
		@ModelAttribute("charge") Charge charge, String search, @RequestParam(defaultValue = "-1") int searchn) {
			
		Page<Charge> pageList = null;
		if(search != null) {
			pageList = chargeService.getChargeList(pNum, searchn, search);
			String search_msg = "\"" + search + "\" 검색 결과";
			m.addAttribute("search_msg", search_msg);
		} else {
			pageList = chargeService.getChargeList(pNum);
		}
		
		List<Charge> bList = pageList.getContent();// 보여질 글
		
		int totalPageCount = pageList.getTotalPages();// 전체 페이지 수
		long total = pageList.getTotalElements();
		m.addAttribute("blist", bList);
		m.addAttribute("totalPage", totalPageCount);
		m.addAttribute("total", total);
		
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

		return "/kwboard/getChargeList";
	}

	@RequestMapping("/list/{num}")
	public String getCharge(@PathVariable Long num, Model m) {
		Charge charge = chargeService.getCharge(num);
		m.addAttribute("charge", charge);
	
		return "/kwboard/getChargeInfo";
	}

	
	@RequestMapping("/openMap")
	public String mapView(Model m) {
		List<Charge> list = chargeService.openMap();
		m.addAttribute("list",list);

		return "/kwboard/openMap";
	}


}
