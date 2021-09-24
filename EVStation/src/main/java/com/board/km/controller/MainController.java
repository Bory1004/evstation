package com.board.km.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.KW.domain.Charge;
import com.board.KW.service.ChargeService;
import com.board.ds.service.DsService;
import com.board.hj.domain.Member;
import com.board.hj.service.FreeBoardService;
import com.board.hj.service.MemberService;
import com.board.km.domain.Alarm;
import com.board.km.domain.AllTableDTO;
import com.board.km.domain.ReviewBoard;
import com.board.km.service.AlarmService;

import com.board.km.service.CommentService;

import com.board.km.service.ReviewService;
import com.google.gson.Gson;

@Controller
public class MainController {
	
	@Autowired
	private AlarmService alarmService;
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private CommentService commentService;
	@Autowired
	private FreeBoardService boardService;
	@Autowired
	private DsService dsService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private ChargeService chargeService;

	@GetMapping("/")
	public String mainView(HttpServletResponse response, HttpServletRequest request, HttpSession session, Model model,
			Member member) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			String cookie_id = "";
			String cookie_pw = "";


			for (Cookie c : cookies) {
				if (c.getName().equals("cookie_id")) {
					cookie_id = c.getValue();
				}
				if (c.getName().equals("cookie_pw")) {
					cookie_pw = c.getValue();
				}
			}
			Member findMember = memberService.findIdPw(cookie_id, cookie_pw);
			if (findMember != null) {
				model.addAttribute("member", findMember);
				session.setAttribute("member", findMember);
			}
		}
		List<Charge> list = chargeService.openMap();
		model.addAttribute("list", list);
		return "main";
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
	

	//내가 쓴글 //km

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

			if(totalPageCount == 0) { return "kmboard/review/myAllList";};

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

    
    @PostMapping("/deleteAllChk")
	public String qnaDeletechk(int[] valueArr, Long[] valueBoardtype) {

		int size = valueArr.length; // 선택된 체크박스의 길이를 변수에 정의

		for (int i = 0; i < size; i++) {
			if(valueBoardtype[i] ==1) {
				boardService.deleteChk(valueArr[i]);
			}else if(valueBoardtype[i] ==2){
				commentService.deleteComment((long) valueArr[i]);
				reviewService.deleteChk(valueArr[i]);
			}else {
				dsService.deleteChk(valueArr[i], (long) valueArr[i]);
			}
			
		}

		return "redirect:/qnaList";

	}
    

}
