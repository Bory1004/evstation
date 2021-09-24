package com.board.km.controller;



import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import com.board.ds.domain.DsEntity;
import com.board.hj.domain.Member;
import com.board.km.domain.Alarm;
import com.board.km.domain.BoardComment;
import com.board.km.domain.ReviewBoard;
import com.board.km.domain.ReviewFile;
import com.board.km.service.AlarmService;
import com.board.km.service.CommentService;
import com.board.km.service.ReRecomService;
import com.board.km.service.ReviewFileService;
import com.board.km.service.ReviewService;
import com.google.gson.Gson;

@SessionAttributes("member")
@Controller
public class ReviewController implements ApplicationContextAware {

	private WebApplicationContext context = null;


	// session에 member가 없으면 실행, 있으면 실행되지 않는다.
	@ModelAttribute("member")
	public Member getMember() {
		return new Member();
	}// test


	@Autowired
	private ReviewService reviewService;

	@Autowired
	private CommentService commentService;

	@Autowired
	private AlarmService alarmService;

	@Autowired
	private ReviewFileService reviewFileService;

	@Autowired
	private ReRecomService rerecomService;

	@RequestMapping("/reviewList")
	public String reviewList(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum, String search,
			@RequestParam(defaultValue = "-1") int searchn,
			@RequestParam(name = "stnum", defaultValue = "1") Long stnum) {

		Page<ReviewBoard> pageList = null;
		if (search != null) { // 검색값이 있을때
			pageList = reviewService.getReviewBoardList(pNum, stnum, searchn, search);
			String search_msg = "\"" + search + "\" 검색결과";
			m.addAttribute("search_msg", search_msg);
		} else {
			pageList = reviewService.getReviewBoardList(pNum, stnum); // 페이지번호와 충전소번호
		}

		List<ReviewBoard> rList = pageList.getContent();
		m.addAttribute("rList", rList);

		// 여기서부터 페이징 부분
		int totalPageCount = pageList.getTotalPages();
		long total = pageList.getTotalElements(); // 글의 총개수
		// System.out.println(rList.get(0).getBoardnum());
		m.addAttribute("totalPage", totalPageCount);
		m.addAttribute("total", total); // 글이없으면 글이 없다고 출력
		m.addAttribute("pNum", pNum);

		int pageNum = 5; // 페이지크기
		int begin = (pNum - 1) / pageNum * pageNum + 1; // 1 1 1 1 1 6 6 6 6 6 11 11....
		int end = begin + pageNum - 1; // 5 5 5 5 5 10 10 10 10 ..
		if (end > totalPageCount) {
			end = totalPageCount;
		}
		m.addAttribute("begin", begin);
		m.addAttribute("end", end);
		m.addAttribute("search", search);
		m.addAttribute("searchn", searchn);
		m.addAttribute("stnum", stnum);
		return "kmboard/review/reviewlist";
	}

	@RequestMapping("deleteReview/{boardnum}")
	public String deleteReview(@PathVariable Long boardnum) {
		commentService.deleteComment(boardnum);
		reviewService.deleteReview(boardnum);
		return "redirect:/reviewList";
	}

	@RequestMapping("content/{boardtype}/{num}")
	public String getReview(@PathVariable Long num, @RequestParam(name = "p", defaultValue = "1") int pNum,
			String search, @RequestParam(name = "p", defaultValue = "-1") int searchn,
			@ModelAttribute("member") Member member, Model m) {

		if (member.getId() == null) {
			return "redirect:/loginView";
		}

		ReviewBoard review = reviewService.getReview(num);
		int commentCnt = commentService.getCount(num);
		m.addAttribute("Cnt", commentCnt);

		m.addAttribute("review", review); // 가져온 리뷰객체
		m.addAttribute("pNum", pNum); // 목록으로 돌아갈때 필요
		m.addAttribute("search", search); // 목록으로 돌아갈때 필요
		m.addAttribute("searchn", searchn); // 목록으로 돌아갈때 필요

		// -------------------------------------------------- 댓글 로딩 부분
		List<BoardComment> comments = commentService.getComments(1, num, (long) 0);
		m.addAttribute("comments", comments); // 제목댓글만받아오기
		List<BoardComment> replycomments = commentService.getReplyComments(num, (long) 0);
		m.addAttribute("replycomments", replycomments); // 대댓글만 받아오기
		// ---------------------------------------------------- 파일 이미지 부분
		List<ReviewFile> reviewFiles = reviewFileService.getFile(num);
		m.addAttribute("reviewFiles", reviewFiles);
		// --------------------------------------------------추천수 부분
		int result = rerecomService.isRecom(num, member.getId());
		m.addAttribute("result", result);
		int recomCnt = rerecomService.getRecom(num);
		m.addAttribute("recomCnt", recomCnt);
		return "kmboard/review/getreview";
	}

	@RequestMapping("/updateReRecom/{num}/{id}")
	@ResponseBody
	public int updateReRecom(@PathVariable Long num, @PathVariable String id) {
		int result = rerecomService.isRecom(num, id);
		int recomCnt;
		if (result == 0) {
			rerecomService.insertRecom(num, id);
			recomCnt = rerecomService.getRecom(num);
		} else {
			rerecomService.deleteRecom(num, id);
			recomCnt = rerecomService.getRecom(num);
		}

		reviewService.updateRecom(num,(long) recomCnt);

		return recomCnt;
	}

	@RequestMapping("/reviewwrite")
	public String gowriteform(@RequestParam(name = "stnum", defaultValue = "-1") Long stnum, Member member, Model m) {
		m.addAttribute("stnum", stnum);
		if (member.getId() == null) {
			return "redirect:/loginView";
		}
		if (stnum == -1) {
			return "redirect:/reviewList";
		}
		return "kmboard/review/reviewwrite";
	}

	@PostMapping("/reviewwrite")
	public String reviewwrite(ReviewBoard board, List<MultipartFile> files) {
		reviewService.saveReview(board);

		if (files.get(0).getSize() != 0) {
			String path = getFilePath(files.get(0));
			board.setBoardthumbnail(path);
			System.out.println(files.get(0).getContentType());
			ReviewFile fi = new ReviewFile();
			fi.setBoardnum(board.getBoardnum());
			fi.setFilepath(path);
			reviewFileService.saveFile(fi);
		}
		System.out.println("비어있는지 확인");
		System.out.println(files.get(0).getSize());
		System.out.println(files.get(0).isEmpty());
		// System.out.println(files.isEmpty());
		System.out.println(files.size());
		if (files.get(0).getSize() != 0) {
			// 파일 데이터베이스에 업로드
			// for (MultipartFile file : files)
			int i;
			for (i = 1; i < files.size(); i++) {
				String path = getFilePath(files.get(i)); // 파일을 폴더에 저장하고 저장된 경로를 리턴
				ReviewFile fi = new ReviewFile();
				fi.setBoardnum(board.getBoardnum());
				fi.setFilepath(path);
				// fi.setOrigFilename(file.getOriginalFilename());

				// save
				reviewFileService.saveFile(fi);
			}

		}
		return "redirect:/reviewList";
	}

	@RequestMapping(value = "content/2/insertCommentReview", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String insertComment(BoardComment board) { // 댓글달기
		commentService.saveComment(board); // comnum,boardnum,comcontent 저장
		commentService.saveReply(board.getComnum()); // comgroupnum,comrestep 저장
		Long comnum = board.getComnum();

		return "redirect:/content2?comnum=" + comnum;
	}

	@RequestMapping(value = "/replyComment", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String replyComment(BoardComment comment, Long frommemnum) { // 대댓글달기 boardnum,comcontent,comgroupnum 변수필요
		commentService.saveComment(comment); // comnum,boardnum,comcontent,comgroupnum 저장
		// ystem.out.println(board);
		commentService.saveReStep(comment.getComgroupnum(), comment.getComnum()); // 여기서 comgroup,comrestep의 값을 저장한다.
		// ------------------------------------------여기서부터 알람부분
		System.out.println("------------알림부분");
		List<BoardComment> memnums = commentService.getmembernum(comment.getComgroupnum()); // 알람테이블에 추가하려면 해당댓글을 단 멤버들의
																							// 멤버번호들을 담은 객체들을 가져옴
		Alarm alarm = null;

		Long boarnnum = comment.getBoardnum(); // 댓글이 어느게시물에있는지 식별하기위해
		for (int i = 0; i < memnums.size(); i++) {
			// System.out.println("----------------------------------"+i+"번째");
			// System.out.println(memnums.get(i).getCommemnum() == frommemnum);
			// System.out.println(memnums.get(i).getCommemnum());
			// System.out.println(frommemnum);
			if (memnums.get(i).getCommemnum() != frommemnum) { // 보낸사람의 멤버번호와 받는사람의 멤버번호가 다를 때 알림테이블에 추가한다.
				alarm = new Alarm();
				// System.out.println(memnums.get(i).getCommemnum());
				alarm.setMemnum(memnums.get(i).getCommemnum()); // 각각의 멤버번호를 가져와서 세이브
				alarm.setAlatype((long) 2);
				alarm.setAlacheck((long) 0);
				alarm.setBoardnum(boarnnum);
				alarm.setFrommemnum(frommemnum); // 알람테이블에 보낸이 아이디를 저장
				alarmService.saveAlarm(alarm);
			}
		}

		return "redirect:/content2?comnum=" + comment.getComnum();
	}

	@RequestMapping(value = "content2", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String goComment(Long comnum) { // 댓글달기와 대댓글달기 이어서받음. 요청을나눈이유는 바로 ajax로 가면 데이터베이스에는 저장되있는데 엔티티에는 저장이 안되있음.
		BoardComment list = commentService.getComment(comnum).get();
		Gson json = new Gson();
		return json.toJson(list);
	}

	@RequestMapping(value = "/content/2/deleteComment", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String deleteComment(Long comnum, Long comgroupnum) {// 댓글삭제
		// System.out.println(comnum);
		// System.out.println(comgroupnum);
		String cnt = commentService.deleteComment(comnum, comgroupnum) + "";
		return cnt;
	}

	@RequestMapping(value = "updateComment", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String updateComment(Long comnum, String comcontent) { // 댓글수정
		commentService.updateComment(comnum, comcontent);
		return "Success!!";
	}

	// (이미지)실제 업로드할 경로 만드는 부분
	private String getFilePath(MultipartFile image) {

		String oriName = image.getOriginalFilename(); // 저장 된 파일의 원본 이름
		int index = oriName.lastIndexOf(".");
		String ext = oriName.substring(index + 1); // 파일 이름 겹치지 않게 지정
		Random r = new Random();
		String fileName = System.currentTimeMillis() + "_" + r.nextInt(50) + "." + ext;

		String path = context.getServletContext().getRealPath("File/" + fileName + "/");
		System.out.println(path);
		System.out.println(File.separator);

		try {
			image.transferTo(new File(path));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}

		return "/File/" + fileName;
	}

	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {

		this.context = (WebApplicationContext) applicationContext;
	}

	// 내가 쓴글 // 대순이씀
	@RequestMapping("/myReviewBoardList/{boardmemnum}")
	public String myList(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum,
			@PathVariable Long boardmemnum) {

		Page<ReviewBoard> pageList = null;
		int pageNum = 5;

		pageList = reviewService.myReviewList(pNum, boardmemnum);

		List<ReviewBoard> list = pageList.getContent();
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


		return "kmboard/review/myReviewBoardList";
	}


	@RequestMapping("/deleteReviewChk")
	public String reviewDeletechk(int[] valueArr) {

		int size = valueArr.length; // 선택된 체크박스의 길이를 변수에 정의

		for (int i = 0; i < size; i++) {

			commentService.deleteComment((long) valueArr[i]);

			reviewService.deleteChk(valueArr[i]);
		}

		return "redirect:/reviewList";

	}

	
	//관리자페이지 리뷰관리
	//관리자 페이지 
	@RequestMapping("/adminReview")
	public String adminReview(Model m, @RequestParam(name = "p", defaultValue = "1") int pNum, String search,
			@RequestParam(defaultValue = "-1") int searchn,
			@RequestParam(name = "stnum", defaultValue = "1") Long stnum) {

		Page<ReviewBoard> pageList = null;
		if (search != null) { // 검색값이 있을때
			pageList = reviewService.getReviewBoardList(pNum, stnum, searchn, search);
			String search_msg = "\"" + search + "\" 검색결과";
			m.addAttribute("search_msg", search_msg);
		} else {
			pageList = reviewService.getReviewBoardList(pNum, stnum); // 페이지번호와 충전소번호
		}

		List<ReviewBoard> rList = pageList.getContent();
		m.addAttribute("rList", rList);

		// 여기서부터 페이징 부분
		int totalPageCount = pageList.getTotalPages();
		long total = pageList.getTotalElements(); // 글의 총개수
		// System.out.println(rList.get(0).getBoardnum());
		m.addAttribute("totalPage", totalPageCount);
		m.addAttribute("total", total); // 글이없으면 글이 없다고 출력
		m.addAttribute("pNum", pNum);

		int pageNum = 5; // 페이지크기
		int begin = (pNum - 1) / pageNum * pageNum + 1; // 1 1 1 1 1 6 6 6 6 6 11 11....
		int end = begin + pageNum - 1; // 5 5 5 5 5 10 10 10 10 ..
		if (end > totalPageCount) {
			end = totalPageCount;
		}
		m.addAttribute("begin", begin);
		m.addAttribute("end", end);
		m.addAttribute("search", search);
		m.addAttribute("searchn", searchn);
		m.addAttribute("stnum", stnum);
		// System.out.println("test");
		return "kmboard/review/adminReview";
	}
}
