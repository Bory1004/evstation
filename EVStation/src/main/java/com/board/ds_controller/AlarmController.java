package com.board.ds_controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AlarmController {

		@RequestMapping("DsAlarm")
		public String alarmEx() {
			return "DsAlarm";
			
		}
}
