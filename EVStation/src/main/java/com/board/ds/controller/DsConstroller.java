package com.board.ds.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.board.ds.domain.DsComment;
import com.board.ds.domain.DsEmail;
import com.board.ds.domain.DsEntity;
import com.board.ds.service.DsCommentService;
import com.board.ds.service.DsService;
import com.board.ds.service.EmailService2;
import com.board.hj.domain.Member;
import com.board.km.domain.BoardComment;
import com.google.gson.Gson;

@SessionAttributes("member")
@Controller
public class DsConstroller {

	// session에 member가 없으면 실행, 있으면 실행되지 않는다.
	@ModelAttribute("member")
	public Member getMember() {
		return new Member();
	}

	@Autowired
	private DsService dsService;

	@Autowired
	private EmailService2 emailService;
	
	@Autowired
	private DsCommentService dsCoService;

	@RequestMapping("/qnaList") // 리스트에 페이징 처리, 검색 처리

	public String qnaList(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum, String search,
			@RequestParam(defaultValue = "-1") int searchn) {

		int pageNum = 5;
		Page<DsEntity> pageList = null;
		if (search != null) {
			pageList = dsService.AllListQnA(pNum, searchn, search);
			String search_msg = "\"" + search + "\" 검색 결과";
			m.addAttribute("search_msg", search_msg);
		} else {
			pageList = dsService.AllListQnA(pNum);
		}
		List<DsEntity> list = pageList.getContent();
		int totalPageCount = pageList.getTotalPages();
		long total = pageList.getTotalElements();
		m.addAttribute("list", list);
		m.addAttribute("totalPage", totalPageCount);
		m.addAttribute("total", total);

		int begin = (pNum - 1) / pageNum * pageNum + 1;
		int end = begin + pageNum - 1;
		if (end > totalPageCount) {
			end = totalPageCount;
		}

		m.addAttribute("begin", begin);
		m.addAttribute("end", end);
		m.addAttribute("search", search);
		m.addAttribute("searchn", searchn);

		System.out.println(list);
		return "/DsBoard/qnaList";
	}

	@GetMapping("/insertQnA") // 글쓰기 폼으로 이동
	public String insertQnaView(@ModelAttribute("member") Member member) {
		if (member.getId() == null) {
			return "redirect:/loginView";
		} else {
			return "/DsBoard/insertQnA";
		}
	}

	@PostMapping("/insertQnA")
	public String insertQnA(DsEntity dsEntity, @ModelAttribute("member") Member member) {
		dsEntity.setMember(member);
		dsEntity.setBoardwriter(member.getId());
		dsEntity.setBoardrestep((long) 0); // 글 작성시 초기 값 0 입력 (테이블에는 타입이 Long 이여서 null로 값이 들어감)
		dsEntity.setBoardrelevel((long) 0);
		dsEntity.setBoardrecom((long) 0);
		dsEntity.setBoardyn("N");
		dsService.saveQnA(dsEntity);

		return "redirect:/qnaList";
	}

	@RequestMapping("/qnaDetail/{boardnum}")
	public String qnaDetail(@PathVariable Long boardnum, Model m, @ModelAttribute("member") Member member,@RequestParam(name = "p", defaultValue = "1") int pNum) {
		if (member.getId() == null) {
			return "redirect:/loginView";
		} else {
			DsEntity detail = dsService.qnaDetail(boardnum);
			m.addAttribute("detail", detail);
		
			
			//댓글부분
			Page<DsComment> pageList = null;
			pageList = dsCoService.QnAComment(pNum, boardnum); //해당 게시판 번호의 댓글 1페이지 출력
			
			List<DsComment>coList = pageList.getContent(); // 보여질 글
			
			int totalPageCount = pageList.getTotalPages();// 전체 페이지 수
			long total = pageList.getTotalElements(); //전제 글 수		
			
			m.addAttribute("totalPage", totalPageCount);
			m.addAttribute("total", total);

			int pageNum = 2;
			int begin = (pNum - 1) / pageNum * pageNum + 1;
			int end = begin + pageNum - 1;
			if (end > totalPageCount) {
				end = totalPageCount;
			}
			
			m.addAttribute("begin", begin);
			m.addAttribute("end", end);
			m.addAttribute("coList", coList);
			
			return "/DsBoard/qnaDetail";
		}
		
		
	}

	@RequestMapping("/deleteChk")
	public String qnaDeletechk(int[] valueArr, Long[] valueRef) {

		int size = valueArr.length; // 선택된 체크박스의 길이를 변수에 정의

		for (int i = 0; i < size; i++) {
			dsService.deleteChk(valueArr[i], valueRef[i]);
		}

		return "redirect:/qnaList";

	}

	@GetMapping("/deleteQnA/{boardnum}/{boardref}")
	public String qnaDelete(@PathVariable Long boardnum, @PathVariable Long boardref) {
		System.out.println("boardref:::" + boardref);
		dsService.deleteQnA(boardnum, boardref);
		return "redirect:/qnaList";

	}

	@RequestMapping("/updateQnAform/{boardnum}")
	public String qnaUpdateForm(@PathVariable Long boardnum, Model m) {

		m.addAttribute("boardnum", boardnum);
		return "/DsBoard/qnaUpdate";
	}

	@PostMapping("/updateQnA")
	public String qnaUpdate(DsEntity dsEntity, @ModelAttribute("member") Member member) {
		dsEntity.setBoardwriter(member.getId());
		dsService.saveQnA(dsEntity);
		return "redirect:/qnaList";
	}

	@RequestMapping("/qnaReplyForm/{boardnum}/{boardref}/{boardrestep}/{boardrelevel}")
	public String writeReply(@PathVariable Long boardnum, @PathVariable Long boardref, @PathVariable Long boardrestep,
			@PathVariable Long boardrelevel, Model m) {

		m.addAttribute("boardnum", boardnum);
		m.addAttribute("ref", boardref);
		m.addAttribute("restep", boardrestep);
		m.addAttribute("relevel", boardrelevel);

		return "/DsBoard/qnaReplyForm";
	}

	@PostMapping("/qnaReply")
	public String saveReply(DsEntity dsEntity, DsEmail dsEmail, @ModelAttribute("member") Member member)
			throws Exception {
		dsService.saveReply(dsEntity.getBoardref(), dsEntity.getBoardrestep(), dsEntity.getBoardrelevel());
		dsEntity.setBoardrestep(dsEntity.getBoardrestep() + 1); // 답변 달릴 때 + 1
		dsEntity.setBoardrelevel(dsEntity.getBoardrelevel() + 1);

		dsEntity.setBoardwriter(member.getId()); // 임의 아이디 추가

		dsService.saveQnA(dsEntity);

		String receiver = "gpdlqnd@gmail.com"; // Receiver.

		String subject = "답변메일입니다."; // 메일 제목

		String content = "답변을 확인해주세요"; // 메일 내용

		dsEmail.setReceiver(receiver);
		dsEmail.setSubject(subject);
		dsEmail.setContent(content);

		emailService.sendMail(dsEmail);

		return "redirect:/qnaList";
	}

	@RequestMapping("/pageIntro") // 페이지 소개
	public String exTemp() {
		return "/DsBoard/pageIntro";

	}

	@RequestMapping("/benefit") // 기대효과
	public String benfit() {
		return "/DsBoard/benefit";

	}

	//QnA 내가 쓴글
	@RequestMapping("/myQnABoardList/{boardmemnum}")
	public String myList(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum, @PathVariable Long boardmemnum){
	
		Page<DsEntity> pageList = null;
		int pageNum = 5;
		
	
	
		pageList = dsService.AAllListQnA(pNum, boardmemnum);
		
		List<DsEntity> list = pageList.getContent();  
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

		return "/DsBoard/myQnABoardList";
		}
	
	@RequestMapping("myAllBoardList")
	public String myAllList() {
		return "/DsBoard/myAllBoardList";
	}
	
	
	
}
