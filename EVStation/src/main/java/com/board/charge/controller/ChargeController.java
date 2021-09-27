package com.board.charge.controller;

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

import com.board.charge.domain.Book;
import com.board.charge.domain.Charge;
import com.board.charge.service.ChargeService;
import com.board.member.domain.Member;

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

		return "/board/charge/getChargeList";
	}

	@RequestMapping("/list/{num}")
	public String getCharge(@PathVariable Long num, Model m, @ModelAttribute("member")Member member) {
		Charge charge = chargeService.getCharge(num);
		m.addAttribute("charge", charge);
	
		if(member.getId() != null) { 
			int result = chargeService.isRecom(num, member.getId());
			m.addAttribute("result", result);
			}
		
		return "/board/charge/getChargeInfo";
	}
	
	@RequestMapping("/openMap")
	public String mapView(Model m) {
		List<Charge> list = chargeService.openMap();
		m.addAttribute("list",list);

		return "/kwboard/openMap";
	}
	
	
	
	@RequestMapping("/myBookmark/{num}/{id}")
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

	//즐겨찾기
	@RequestMapping("/myBookmark")
	public String bookMark(@ModelAttribute("member")Member member,String id,Model m, @RequestParam(name = "p", defaultValue = "1") int pNum )  {

		Page<Charge> pageList = null;
		pageList = chargeService.bookMark(pNum, member.getId());
		
		List<Charge> bList = pageList.getContent();
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
		
		return "/member/mypage/myBookmark";
	}

	@RequestMapping("/deleteBookmarkChk")
	public String deleteBookmarkChk(Long[] arrStnum) {
		
		int size = arrStnum.length;
		
		for(int i=0; i < size; i++) {
			
			chargeService.deleteBookmark(arrStnum[i]);
		 System.out.println(arrStnum[i]);
		}
		return "/member/mypage/myBookmark";
	}
	
	
	@RequestMapping("/admin_charge")
	public String adminCharge(@ModelAttribute("member")Member member, Model m, @RequestParam(name = "p", defaultValue = "1") int pNum, 
			@ModelAttribute("charge") Charge charge, String search, @RequestParam(defaultValue = "-1") int searchn) {
		
		Page<Charge> pageList = null;
		if(search != null) {
			pageList = chargeService.getChargeList(pNum, searchn, search);
		} else {
			pageList = chargeService.getChargeList(pNum);
		}
		
		List<Charge> bList = pageList.getContent();// 보여질 글
		
		int totalPageCount = pageList.getTotalPages();// 전체 페이지 수
		long total = pageList.getTotalElements();
		m.addAttribute("list", bList);
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
		
		
		return "/admin/adminCharge";
		
	}
	@RequestMapping("/deleteAdminChargeChk")
	public String deleteAdminChargeChk(Long[] arrStnum) {
		
		int size = arrStnum.length;
		
		for(int i=0; i < size; i++) {
			
			chargeService.deleteAdmin(arrStnum[i]);
		}
		return  "/admin/adminCharge";
	}
	
	@RequestMapping("/deleteCharge/{stnum}")
	public String deleteCharge(@PathVariable Long stnum) {
		chargeService.deleteCharge(stnum);
		return "redirect:/getChargeList";
	}
	
	@RequestMapping("/updateCharge/{stnum}/{stname}/{stlongitude}/{stlatitude}")
	public String updateCharge(@PathVariable Long stnum,@PathVariable String stname,@PathVariable String stlongitude,@PathVariable String stlatitude,Model m) {
		m.addAttribute(stname);
		m.addAttribute(stnum);
		m.addAttribute(stlatitude);
		m.addAttribute(stlongitude);
		return "/board/charge/updateCharge";
		
	}
	@PostMapping("/updateChargeComplete")
	public String updateChargeComplete(Charge charge){
		charge.setStnum(charge.getStnum());
		charge.setStname(charge.getStname());
		charge.setStlatitude(charge.getStlatitude());
		charge.setStlongitude(charge.getStlongitude());
		
		chargeService.updateCharge(charge);
		return "redirect:/getChargeList";
		
	}
	
	@GetMapping("/insertCharge")
	public String insertCharge() {
		return "/board/charge/insertCharge";
	}
	@PostMapping("/insertChargeComplete")
	public String insertChargeComplete(Charge charge) {
		chargeService.updateCharge(charge);
		return "redirect:/admin_charge";
		
	}
	
}