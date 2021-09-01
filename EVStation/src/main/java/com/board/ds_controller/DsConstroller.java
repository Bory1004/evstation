		package com.board.ds_controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
}
