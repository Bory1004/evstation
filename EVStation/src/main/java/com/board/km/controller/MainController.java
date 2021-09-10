package com.board.km.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.board.km.domain.Alarm;
import com.board.km.service.AlarmService;
import com.google.gson.Gson;

@Controller
public class MainController {
	
	@Autowired
	AlarmService alarmService;

	@RequestMapping("/")
	public String getAlarms(Long memnum) {
		List<Alarm> list=alarmService.getAlarms(memnum);
		Gson json = new Gson();
		return json.toJson(list);
	}
}
