package com.board.ds_controller;

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

import com.board.ds_entity.DsEntity;
import com.board.ds_service.DsService;

@Controller
public class DsConstroller {
	
	@Autowired
	private DsService dsService;
	
		
	@RequestMapping("qnaList")
		public String qnaList(Model m, @RequestParam(name = "p", defaultValue ="1")int pNum) {	
		
		int pageNum = 5;
		Page<DsEntity> pageList = dsService.AllListQnA(pNum);
		List<DsEntity> list = pageList.getContent();
		int totalPageCount = pageList.getTotalPages();
		m.addAttribute("list",list); 
		m.addAttribute("totalPage", totalPageCount);
		
		int begin = (pNum - 1) / pageNum * pageNum + 1;
		int end = begin + pageNum - 1;
		if (end > totalPageCount) {
			end = totalPageCount;
		}

		m.addAttribute("begin", begin);
		m.addAttribute("end", end);


			return "qnaList";
		}
	@GetMapping("insertQnA")
	public String insertQnaView() {
		return "insertQnA";
	}
	@PostMapping("insertQnA")
	public String insertQnA(DsEntity dsEntity) {
		dsService.saveQnA(dsEntity);
		return "redirect:/qnaList";
	}
	@RequestMapping("qnaDetail/{boardnum}")
	public String qnaDetail(@PathVariable Long boardnum, Model m) {
		DsEntity detail=dsService.qnaDetail(boardnum);
		m.addAttribute("detail",detail);
		return "qnaDetail";
	}
<<<<<<< HEAD
	@GetMapping("deleteQnA/{board_num}")
	public String qnaDelete(@PathVariable Long board_num) {
		dsService.deleteQnA(board_num);
		return  "redirect:/qnaList"; 
		
	}
	
=======
	@RequestMapping("deleteQnA/{boardnum}")
	public String qnaDelete(@PathVariable Long boardnum) {
		dsService.deleteQnA(boardnum);
		return  "redirect:/qnaList"; 
	}
	@RequestMapping("updateQnAform/{boardnum}")
	public String qnaUpdateForm(@PathVariable Long boardnum, Model m) {
		m.addAttribute("board_num",boardnum);
		return "qnaUpdate";
	}
	@PostMapping("updateQnA")
	public String qnaUpdate(DsEntity dsEntity) { 
		dsService.saveQnA(dsEntity);
		return "redirect:/qnaList";
	}
>>>>>>> branch 'DS' of https://github.com/k-mini/EV-Station.git
}
