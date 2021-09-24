package com.board.hj.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.board.hj.domain.FreeBoard;
import com.board.hj.domain.Member;
import com.board.hj.service.FreeBoardService;
import com.board.hj.service.FreeCommentService;

@SessionAttributes("member")
@Controller
public class AdminController {
	
	@Autowired
	private FreeBoardService freeboardService;
	
	@Autowired
	private FreeCommentService freecommentService;	
	
	@ModelAttribute("member")
	public Member getMember() {
		return new Member();
	}
	
	@RequestMapping("/admin_freeboard")
	public String admin_freeboardView(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum) {
		Page<FreeBoard> pageList = null;
		int pageNum = 5;
		pageList = freeboardService.getBoardList(pNum);
		
		List<FreeBoard> list = pageList.getContent();  
		m.addAttribute("list", list);
    
		System.out.println(list);
		int totalPageCount = pageList.getTotalPages();
		long total = pageList.getTotalElements();

		m.addAttribute("totalPage", totalPageCount);
		m.addAttribute("total", total);

		int begin = (pNum - 1) / pageNum * pageNum + 1;
		int end = begin + pageNum - 1;
		if (end > totalPageCount) {
			end = totalPageCount;
		}

		m.addAttribute("begin", begin);
		m.addAttribute("end", end);
		
		return "admin/admin_freeboard";
	}
	
	@RequestMapping("/admin_freeboard_delete")
	public String admin_freeboard_delete(int[] valueArr) {
		int size = valueArr.length; // 선택된 체크박스의 길이를 변수에 정의

		for (int i = 0; i < size; i++) {
			freecommentService.deleteComment((long)valueArr[i]);
			freeboardService.deleteChk(valueArr[i]);
		}
		return "redirect:/getFreeBoardList";
	}
	
}
