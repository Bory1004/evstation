package com.board.qna.controller;

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

import com.board.hj.domain.FreeBoard;
import com.board.hj.domain.Member;
import com.board.hj.service.FreeBoardService;
import com.board.km.domain.BoardComment;
import com.board.km.domain.ReviewBoard;
import com.board.km.service.ReviewService;
import com.board.qna.domain.QnABoardComment;
import com.board.qna.domain.QnAEmail;
import com.board.qna.domain.QnABoard;
import com.board.qna.persistence.QnARecomRepository;
import com.board.qna.service.QnACommentService;
import com.board.qna.service.QnARecomService;
import com.board.qna.service.QnABoardService;
import com.board.qna.service.QnAEmailService;
import com.google.gson.Gson;

@SessionAttributes("member")
@Controller
public class QnAConstroller {

	// session에 member가 없으면 실행, 있으면 실행되지 않는다.
	@ModelAttribute("member")
	public Member getMember() {
		return new Member();
	}

	@Autowired
	private QnABoardService dsService;

	@Autowired
	private QnAEmailService emailService;
	
	@Autowired
	private QnACommentService dsCoService;
	
	
	@Autowired
	private FreeBoardService boardService;
	
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private QnARecomService dsRecomService;
	
	

	@RequestMapping("/qnaList") // 리스트에 페이징 처리, 검색 처리

	public String qnaList(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum, String search,
			@RequestParam(defaultValue = "-1") int searchn) {

		int pageNum = 5;
		Page<QnABoard> pageList = null;
		if (search != null) {
			pageList = dsService.AllListQnA(pNum, searchn, search);
			String search_msg = "\"" + search + "\" 검색 결과";
			m.addAttribute("search_msg", search_msg);
		} else {
			pageList = dsService.AllListQnA(pNum);
		}
		List<QnABoard> list = pageList.getContent();
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
		return "/board/qna/qnaList";
	}

	@GetMapping("/insertQnA") // 글쓰기 폼으로 이동
	public String insertQnaView(@ModelAttribute("member") Member member) {
		if (member.getId() == null) {
			return "redirect:/loginView";
		} else {
			return "/board/qna/insertQnA";
		}
	}

	@PostMapping("/insertQnA")
	public String insertQnA(QnABoard dsEntity, @ModelAttribute("member") Member member) {
		dsEntity.setMember(member);
		dsEntity.setBoardwriter(member.getId());
		dsEntity.setBoardmemnum(member.getMemnum());
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
			QnABoard detail = dsService.qnaDetail(boardnum);
			m.addAttribute("detail", detail);
			
			//댓글부분
			int commentCnt = dsCoService.getComentCount(boardnum);
			m.addAttribute("Cnt", commentCnt);  //댓글 갯수 
			//-------------------댓글로딩
			List<QnABoardComment>comments = dsCoService.getComments(boardnum, (long) 0);
			m.addAttribute("comments",comments); //댓글
			List<QnABoardComment>replycomments = dsCoService.getReplyComments(boardnum, (long) 0);
			m.addAttribute("replycomments",replycomments); //대댓글
			//-------------------------------------------------- 추천수 부분
			int result = dsRecomService.isRecom(boardnum,member.getId());
			m.addAttribute("result",result);
				
			
			return "/board/qna/qnaDetail";
		}
	}
	
	//추천기능
	@RequestMapping("/updateQnaRecom/{num}/{id}")
	@ResponseBody
	public long updateQnaRecom(@PathVariable Long num, @PathVariable String id) {
		int result = dsRecomService.isRecom(num, id);
		QnABoard dsEntity = null ;
		if(result == 0) {
			dsRecomService.insertRecom(num,id);
			dsEntity = dsService.upRecom(num); 
		}else { 
			dsRecomService.deleteRecom(num,id);
			dsEntity = dsService.dnRecom(num);
		}
		return dsEntity.getBoardrecom();
	}
	
	
	
	@RequestMapping("/deleteChk")

	public String qnaDeletechk(int[] valueArr, Long[] valueRef, Long[] valueRestep) {

		int size = valueArr.length; // 선택된 체크박스의 길이를 변수에 정의

		try {
			for (int i = 0; i < size; i++) {
					if(valueRestep[i] == 0) {
						dsService.deleteChk(valueArr[i], valueRef[i]);
						dsService.deleteReply(valueRef[i]);
		
					}else {
						dsService.deleteChk(valueArr[i], valueRef[i]);
					}
					System.out.println(valueRestep[i]);
					System.out.println(valueArr[i]);
					System.out.println(valueRestep[i]);
				}
		}catch (Exception e) {
				return "redirect:/qnaList";
		}	
		return "redirect:/qnaList";
	}

	@GetMapping("/deleteQnA/{boardnum}/{boardref}/{boardrestep}")
	public String qnaDelete(@PathVariable Long boardnum, @PathVariable Long boardref, @PathVariable Long boardrestep) {
		System.out.println("boardref:::" + boardref);
		System.out.println("boardrestep:::" + boardrestep);
		
		if(boardrestep == 0) {
		dsService.deleteQnA(boardnum, boardref);
		dsService.deleteReply(boardref);
		}else{
		dsService.deleteQnA(boardnum, boardref);
		}
		

		return "redirect:/qnaList";

	}

	@RequestMapping("/updateQnAform/{boardnum}/{boardmemnum}/{boardrecom}/{boardrelevel}/{boardrestep}/{boardref}")
	public String qnaUpdateForm(@PathVariable Long boardnum, @PathVariable Long boardmemnum,@PathVariable Long boardrecom,@PathVariable Long boardrelevel,@PathVariable Long boardrestep,@PathVariable Long boardref,Model m) {

		m.addAttribute("boardnum", boardnum);
		m.addAttribute("boardmemnum",boardmemnum);
		m.addAttribute("boardrecom", boardrecom);
		m.addAttribute("boardrelevel", boardrelevel);
		m.addAttribute("boardrestep", boardrestep);
		m.addAttribute("boardref", boardref);

		System.out.println(boardmemnum);
		return "/board/qna/qnaUpdate";
	}

	@PostMapping("/updateQnA")
	public String qnaUpdate(QnABoard dsEntity, @ModelAttribute("member") Member member) {
		dsEntity.setBoardwriter(member.getId());
		dsEntity.setBoardmemnum(member.getMemnum());
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

		return "/board/qna/qnaReplyForm";
	}

	@PostMapping("/qnaReply")
	public String saveReply(QnABoard dsEntity, QnAEmail dsEmail, @ModelAttribute("member") Member member)
			throws Exception {
		dsService.saveReply(dsEntity.getBoardref(), dsEntity.getBoardrestep(), dsEntity.getBoardrelevel());
		dsEntity.setBoardrestep(dsEntity.getBoardrestep() + 1); // 답변 달릴 때 + 1
		dsEntity.setBoardrelevel(dsEntity.getBoardrelevel() + 1);
		dsEntity.setBoardrecom((long) 0);


		dsEntity.setBoardwriter(member.getId()); // 현재아이디(관리자)
		dsEntity.setBoardmemnum(member.getMemnum()); // 현재 회원번호


		dsService.saveQnA(dsEntity);

		String receiver =  member.getMememail(); // Receiver.

		String subject = "답변메일입니다."; // 메일 제목

		String content = "답변을 확인해주세요"; // 메일 내용

		dsEmail.setReceiver(receiver);
		dsEmail.setSubject(subject);
		dsEmail.setContent(content);

		emailService.sendMail(dsEmail);


		return "redirect:/adminQnAOnly";

	}

	@RequestMapping("/pageIntro") // 페이지 소개
	public String exTemp() {
		return "/main/pageIntro";

	}

	@RequestMapping("/benefit") // 기대효과
	public String benfit() {
		return "/main/benefit";

	}

	//QnA 내가 쓴글
	@RequestMapping("/myQnABoardList/{boardmemnum}")
	public String myList(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum, @RequestParam(name = "type", defaultValue = "1") int boardtype,@PathVariable Long boardmemnum){
	
		Page<QnABoard> pageList = null;
		int pageNum = 5;
		
	
	
		pageList = dsService.AAllListQnA(pNum, boardmemnum);
		
		
		
		
		
		List<QnABoard> list = pageList.getContent();  
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

		return "/member/mypage/myQnABoardList";
		}
	
	//관리자 페이지 
	@RequestMapping("/adminQnAOnly")
	public String adminOnly(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum, String search,
			@RequestParam(defaultValue = "-1") int searchn) {
		int pageNum = 5;
		Page<QnABoard> pageList = null;
		if (search != null) {
			pageList = dsService.AllListQnA(pNum, searchn, search);
		} else {
			pageList = dsService.AllListQnA(pNum);
		}
		List<QnABoard> list = pageList.getContent();
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
		
		return "/admin/adminQnAOnly";
		
	}

	
	
}
