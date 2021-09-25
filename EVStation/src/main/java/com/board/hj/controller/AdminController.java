package com.board.hj.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.board.KW.service.ChargeService;
import com.board.ay.service.NoticeCommentService;
import com.board.ds.service.DsCommentService;
import com.board.ds.service.DsService;
import com.board.hj.domain.FreeBoard;
import com.board.hj.domain.Member;
import com.board.hj.service.FreeBoardService;
import com.board.hj.service.FreeCommentService;
import com.board.hj.service.MemberService;
import com.board.km.service.AlarmService;
import com.board.km.service.CommentService;
import com.board.km.service.ReviewService;

@SessionAttributes("member")
@Controller
public class AdminController {
	
	@Autowired
	private MemberService memberService;

	@Autowired
	private ChargeService chargeService;
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private AlarmService alarmService;
	@Autowired
	private CommentService commentService;
	@Autowired
	private FreeBoardService freeboardService;
	@Autowired
	private FreeCommentService freecommentService;
	@Autowired
	private DsService dsService;
	@Autowired
	private DsCommentService dscommentService;
	@Autowired
	private NoticeCommentService noticecommentService;
	
	@ModelAttribute("admin")
	public Member getMember() {
		return new Member();
	}
	
	//관리자 - 자유게시판 관리
	@RequestMapping("/admin_freeboard")
	public String admin_freeboardView(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum,
			@ModelAttribute("member") Member member,String search, @RequestParam(defaultValue = "-1") int searchn) {
		
		Page<FreeBoard> pageList = null;
		if (search != null) {
			pageList = freeboardService.getBoardList(pNum, searchn, search); //search = 검색어
			String search_msg = "\"" + search + "\" 검색 결과";
			m.addAttribute("search_msg", search_msg);
		} else {
			pageList = freeboardService.getBoardList(pNum);
		}
		
		List<FreeBoard> bList = pageList.getContent();// 보여질 글
		
		int totalPageCount = pageList.getTotalPages();// 전체 페이지 수
		long total = pageList.getTotalElements(); //전제 글 수		
		m.addAttribute("list", bList);
		m.addAttribute("totalPage", totalPageCount);
		m.addAttribute("total", total);
		
		//System.err.println("total : " + total);
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
		
		return "admin/admin_freeboard";
	}
	
	// 자유게시판 삭제
	@RequestMapping("/admin_freeboard_delete")
	public String admin_freeboard_delete(int[] valueArr) {
		int size = valueArr.length; // 선택된 체크박스의 길이를 변수에 정의

		for (int i = 0; i < size; i++) {
			freecommentService.deleteComment((long)valueArr[i]);
			freeboardService.deleteChk(valueArr[i]);
		}
		return "redirect:/getFreeBoardList";
	}
	
	// 사용자 관리
	@RequestMapping("/admin_member")
	public String admin_memberView(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum,
			@ModelAttribute("member") Member member,String search, @RequestParam(defaultValue = "-1") int searchn) {
		
		Page<Member> pageList = null;
		if (search != null) {
			pageList = memberService.getMemberList(pNum, searchn, search); //search = 검색어
			String search_msg = "\"" + search + "\" 검색 결과";
			m.addAttribute("search_msg", search_msg);
		} else {
			pageList = memberService.getMemberList(pNum);
		}
		
		List<Member> bList = pageList.getContent();// 보여질 글
		
		int totalPageCount = pageList.getTotalPages();// 전체 페이지 수
		long total = pageList.getTotalElements(); //전제 글 수		
		m.addAttribute("list", bList);
		m.addAttribute("totalPage", totalPageCount);
		m.addAttribute("total", total);
		
		//System.err.println("total : " + total);
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
				
		return "admin/admin_member";
	}
	
	@RequestMapping("/admin_member_deleteAll")
	public String admin_member_deleteAll(int[] valueArr) {
		int size = valueArr.length; // 선택된 체크박스의 길이를 변수에 정의

		for (int i = 0; i < size; i++) {
			reviewService.withdraw((long)valueArr[i]);
			alarmService.withdraw((long)valueArr[i]);
			commentService.withdraw((long)valueArr[i]);
			freeboardService.withdraw((long)valueArr[i]);
			freecommentService.withdraw((long)valueArr[i]);
			dsService.withdraw((long)valueArr[i]);
			dscommentService.withdraw((long)valueArr[i]);
			noticecommentService.withdraw((long)valueArr[i]);
			memberService.delAccount((long)valueArr[i]);
		}		
		return "redirect:/admin_member";
	}
	
	@RequestMapping("/admin_member_deleteOne/{memnum}")
	public String admin_member_deleteOne(@PathVariable Long memnum) {
		
		reviewService.withdraw(memnum);
		alarmService.withdraw(memnum);
		commentService.withdraw(memnum);
		freeboardService.withdraw(memnum);
		freecommentService.withdraw(memnum);
		dsService.withdraw(memnum);
		dscommentService.withdraw(memnum);
		noticecommentService.withdraw(memnum);
		memberService.delAccount(memnum);
		
		return "redirect:/admin_member";
	}
	
	@RequestMapping("/admin_member_view/{memnum}")
	public String admin_member_view(@PathVariable Long memnum, Model m) {
		Member member = memberService.getMemberOne(memnum);
		m.addAttribute("list", member);
		
		return "admin/memberView";
	}
}
