package com.board.km.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.km.domain.Alarm;
import com.board.km.service.AlarmService;
import com.google.gson.Gson;

@Controller
public class MainController {
	
	@Autowired
	AlarmService alarmService;

	@RequestMapping("/")
	public String Main() {
		return "/index";
	}
	
	@RequestMapping(value="/getAlarm", method=RequestMethod.GET,produces= "text/plain;charset=UTF-8") //알람내역출력
	public String getAlarms(Long memnum,Model m) {
		List<Alarm> list=alarmService.getAlarms(memnum);
		//Gson json = new Gson();
		m.addAttribute("list",list);
		//System.out.println(list.size());
		//return json.toJson(list);
		return "alarmpage";
	}
	
	@RequestMapping(value="/countAlarm",method=RequestMethod.GET,produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String countAlarm(Long memnum) {
		int counts = alarmService.countAlarm(memnum);
		//System.out.println(counts);
		if(counts == 0) {return "";}
		return ""+counts; 
	}
	
	@RequestMapping(value="/delAlarm",method=RequestMethod.GET,produces="text/palin;charset=UTF-8")
	@ResponseBody
	public String delAlarm(Long alanum) {
			alarmService.delAlarm(alanum);
		return "Success!!";
	}
	
	@RequestMapping(value="/checkAlarm",method=RequestMethod.GET,produces="text/plain;charset=UTF-8")
	public String checkAlarm(Long alanum) {
			alarmService.checkAlarm(alanum);
		return "Success!!";
	}
}
