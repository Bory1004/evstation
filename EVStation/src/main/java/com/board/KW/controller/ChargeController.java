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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.board.KW.domain.Book;
import com.board.KW.domain.Charge;
import com.board.KW.service.ChargeService;
import com.board.hj.domain.Member;

@SessionAttributes("member")
@Controller
public class ChargeController {

	@ModelAttribute("member")
	public Member getMember() {
		return new Member();
	}
	
	@Autowired
	private ChargeService chargeService;
	
	// 리스트 + 검색
	@RequestMapping("/getChargeList")
	public String getBoardList(@ModelAttribute("member")Member member, Model m, @RequestParam(name = "p", defaultValue = "1") int pNum, 
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
	public String getCharge(@PathVariable Long num, Model m, @ModelAttribute("member")Member member) {
		Charge charge = chargeService.getCharge(num);
		m.addAttribute("charge", charge);
	
		if(member.getId() != null) { 
			int result = chargeService.isRecom(num, member.getId());
			m.addAttribute("result", result);
			}
		
		return "/kwboard/getChargeInfo";
	}
	
	@RequestMapping("/openMap")
	public String mapView(Model m) {
		List<Charge> list = chargeService.openMap();
		m.addAttribute("list",list);
		return "/kwboard/openMap";
	}
	
	
	
	@RequestMapping("/bookmark/{num}/{id}")
	@ResponseBody
	public int upRecom(Book book, @PathVariable Long num, @PathVariable String id, Model m,@ModelAttribute("member")Member member)
	{
			
			 int x = 0;
			m.addAttribute("member", member);
			int result = chargeService.isRecom(num, id);
			if(result == 0) {
				chargeService.insertRecom(num, id);
			} else {
				chargeService.del(id, num);	

			}
			System.out.println("x:" + x);
			return x;
		}

	@RequestMapping("/bookmark")
	public String bookMark(@ModelAttribute("member")Member member,String id,Model m, @RequestParam(name = "p", defaultValue = "1") int pNum )  {

		Page<Charge> pageList = null;
		pageList = chargeService.getChargeList(pNum);
		
		List<Charge> bList = chargeService.bookmark(member.getId());
		m.addAttribute("blist", bList);
		
		int totalPageCount = pageList.getTotalPages();// 전체 페이지 수
		long total = pageList.getTotalElements();
		
		
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
		
		            
		
		return "/kwboard/bookmark";
	}

	/*
	 * @RequestMapping("/main") public String markList(Model m) { List<Charge> list
	 * = chargeService.openMap(); m.addAttribute("list",list); return "/main"; }
	 */
	
	

}
