package com.board.km.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.km.domain.Alarm;
import com.board.km.domain.AllTableDTO;
import com.board.km.domain.ReviewBoard;
import com.board.km.service.AlarmService;
import com.board.km.service.ReviewService;
import com.google.gson.Gson;

@Controller
public class MainController {
	
	@Autowired
	AlarmService alarmService;
	@Autowired
	ReviewService reviewService;

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
	public String delAlarm(Long alanum,Long memnum) {
			alarmService.delAlarm(alanum);
			int counts = alarmService.countAlarm(memnum);
			if(counts == 0) {return "";}
		return ""+counts;
	}
	
	@RequestMapping(value="/checkAlarm",method=RequestMethod.GET,produces="text/plain;charset=UTF-8")
	public String checkAlarm(Long alanum) {
			alarmService.checkAlarm(alanum);
		return "Success!!";
	}
	
	//내가 쓴글 // 대순이씀
    @RequestMapping("/AllBoardList/{boardmemnum}")
	public String myList(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum, @PathVariable Long boardmemnum){
	
		List<AllTableDTO> list = null;
		int pageNum = 5;
		
	
	
		list = reviewService.AllBoardList(pNum, boardmemnum);
		List<AllTableDTO> All = new ArrayList<AllTableDTO>();
		
		int totalPageCount = list.size()/10;
			if( list.size() % 10 != 0) {
				totalPageCount += 1;
			}
		long total = list.size();

		m.addAttribute("totalPage", totalPageCount);
		m.addAttribute("total", total);
		System.out.println("totalPage:"+totalPageCount);
		System.out.println("pNum:"+pNum);
		System.out.println("total:"+total);
		int begin = (pNum - 1) / pageNum * pageNum + 1;
		int end = begin + pageNum - 1;
		if (end > totalPageCount) {
			end = totalPageCount;
		}

		m.addAttribute("begin", begin);
		m.addAttribute("end", end);
		
		if (pNum != totalPageCount) {
			for (int i = 10*(pNum-1); i< 10*pNum ;i++) {
					All.add(list.get(i));
			}
		}else {
			for (int i = 10*(pNum-1); i< list.size() ;i++) {
				System.out.println(list.get(i));
					All.add(list.get(i));
			}
		}
	
		System.out.println(All.size());
		m.addAttribute("All", All);
		
		return  "kmboard/review/myAllList";
		}
}
