		package com.board.ds_controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.board.ds_entity.DsEntity;
import com.board.ds_service.DsService;

@Controller
public class DsConstroller {
	
	@Autowired
	private DsService dsService;
		
	@RequestMapping("qnaList")
		public String qnaList(Model m) {	
		List<DsEntity> list = dsService.QnA_AllList();
		m.addAttribute("list",list); 
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
	@RequestMapping("qnaDetail/{board_num}")
	public String qnaDetail(@PathVariable Long board_num, Model m) {
		DsEntity detail=dsService.qnaDetail(board_num);
		m.addAttribute("detail",detail);
		return "qnaDetail";
	}
	@GetMapping("deleteQnA/{board_num}")
	public String qnaDelete(@PathVariable Long board_num) {
		dsService.deleteQnA(board_num);
		return  "redirect:/qnaList"; 
		
	}
	
}
