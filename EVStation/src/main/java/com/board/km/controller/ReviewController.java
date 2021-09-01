package com.board.km.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.board.km.domain.ReviewBoard;
import com.board.km.service.ReviewService;

@Controller
public class ReviewController {
	
	@Autowired
	ReviewService reviewService;
	
	@RequestMapping("/reviewList")
	public String reviewList(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum,  
			String search, @RequestParam(defaultValue = "-1") int searchn) {
		
		Page<ReviewBoard> pageList =null;
		if(search != null) { //검색값이 있을때
			pageList = reviewService.getReviewBoardList(pNum,searchn,search);
		}else { 
			pageList = reviewService.getReviewBoardList(pNum);
		}
		
		
	
		List<ReviewBoard> rList = pageList.getContent();
		int totalPageCount = pageList.getTotalPages();
		long total = pageList.getTotalElements();
		//System.out.println(rList.get(0).getBoardnum());
		m.addAttribute("rList", rList);
		m.addAttribute("totalPage",totalPageCount);
		m.addAttribute("total",total);
	
		int pageNum = 5;
		int begin = (pNum -1) / pageNum * pageNum + 1;
		int end = begin + pageNum-1;
		if (end > totalPageCount) {
			end = totalPageCount;
		}
		
		m.addAttribute("begin", begin);
		m.addAttribute("end", end);
		m.addAttribute("search", search);
		m.addAttribute("searchn", searchn);
		//System.out.println("test");
		return "kmboard/reviewlist";
	}
	
	
}
