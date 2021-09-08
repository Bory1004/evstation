package com.board.ds_controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.board.ds_entity.DsEmail;
import com.board.ds_entity.DsEntity;
import com.board.ds_persistence.DsRepository;
import com.board.ds_service.DsService;
import com.board.ds_service.EmailService;

@SessionAttributes("tempId")
@Controller
public class DsConstroller {
	
	@ModelAttribute("tempId")
	public String tempId() {
		return "tempId";
	}
	
	@Autowired  
	private DsService dsService;
	
	@Autowired
	private EmailService emailService;
	
//	@Autowired                                            
//	private DsRepository dsRepo;
		
	@RequestMapping("qnaList")
		public String qnaList(Model m, @RequestParam(name = "p", defaultValue ="1")int pNum, String search, @RequestParam(defaultValue = "-1") int searchn ) {	
		
		int pageNum = 5;
		Page<DsEntity> pageList = null;
		if(search != null) {
		pageList = dsService.AllListQnA(pNum, searchn, search);
		}else {
		pageList = dsService.AllListQnA(pNum);	
		}
		List<DsEntity> list = pageList.getContent();
		int totalPageCount = pageList.getTotalPages();
		long total = pageList.getTotalElements();
		m.addAttribute("list",list); 
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
		

			return "/DsBoard/qnaList";
		}
	
	@GetMapping("insertQnA")
	public String insertQnaView() {
		return "/DsBoard/insertQnA";
	}
	@PostMapping("insertQnA")
	public String insertQnA(DsEntity dsEntity, @ModelAttribute("tempId")String tempId) {
		dsEntity.setBoardwriter(tempId);
		dsEntity.setRestep((long) 0); //글 작성시 초기 값 0 입력 (테이블에는 타입이 Long 이여서 null로 값이 들어감)
		dsEntity.setRelevel((long) 0);
		
		dsService.saveQnA(dsEntity);
		
		return "redirect:/qnaList";
	}
	@RequestMapping("qnaDetail/{boardnum}")
	public String qnaDetail(@PathVariable Long boardnum, Model m) {
		DsEntity detail=dsService.qnaDetail(boardnum);
		m.addAttribute("detail",detail);
		return "/DsBoard/qnaDetail";
	}
	@GetMapping("deleteQnA")
	public String qnqDeletechk(Long boardnum) {
		dsService.deleteQnA(boardnum);
		return  "redirect:/qnaList"; 
		
	}
	
	@GetMapping("deleteQnA/{boardnum}")
	public String qnaDelete(@PathVariable Long boardnum) {
		dsService.deleteQnA(boardnum);
		return  "redirect:/qnaList"; 
		
	}
	@RequestMapping("updateQnAform/{boardnum}")
	public String qnaUpdateForm(@PathVariable Long boardnum, Model m) {
		m.addAttribute("boardnum",boardnum);
		return "/DsBoard/qnaUpdate";
	}
	@PostMapping("updateQnA")
	public String qnaUpdate(DsEntity dsEntity) { 
		dsService.saveQnA(dsEntity);
		return "redirect:/qnaList";
	}


	@RequestMapping("qnaReplyForm/{boardnum}/{ref}/{restep}/{relevel}")
	    public String writeReply(@PathVariable Long boardnum,@PathVariable Long ref,@PathVariable Long restep,@PathVariable Long relevel, Model m) {
		m.addAttribute("boardnum", boardnum);
		m.addAttribute("ref",ref);
		m.addAttribute("restep", restep);
		m.addAttribute("relevel", relevel);
		//
	        return "/DsBoard/qnaReplyForm";
}

	@PostMapping("qnaReply")
	public String saveReply(DsEntity dsEntity, DsEmail dsEmail ) throws Exception { 
		System.out.println(dsEntity.getRef()+" "+dsEntity.getRestep()+"  "+dsEntity.getBoardnum());	
		dsService.saveReply(dsEntity.getRef(), dsEntity.getRestep(), dsEntity.getRelevel());	
		
		dsEntity.setRestep(dsEntity.getRestep()+1);
		dsEntity.setRelevel(dsEntity.getRelevel()+1);
		dsEntity.setBoardyn(dsEntity.getBoardyn()+1);

		dsService.saveQnA(dsEntity);


		String receiver = "gpdlqnd@gmail.com"; // Receiver.

		String subject = "답변메일입니다."; // 메일 제목
		
		String content =  "답변을 확인해주세요";  //메일 내용
		
		dsEmail.setReceiver(receiver);
		dsEmail.setSubject(subject);
		dsEmail.setContent(content);
		
		emailService.sendMail(dsEmail);

		return "redirect:/qnaList";
}
}





//	   @GetMapping("qnaReply")
//	   public String qnaRelpy(Long boardnum, Model m, Integer pNum, Integer pageSize) {
//		   Page<DsEntity> reply = dsService.getfindAll(pNum, pageSize);
//		   Long groupNo = dsService.getfindOne(boardnum).getGroupNo();
//	        m.addAttribute("groupNo", groupNo);
//	        m.addAttribute("parentNo", boardnum);
//	        m.addAttribute("reply", reply);	
//			return "redirect:/qnaList";
//		   
//	   }
//}
	
	   
	   //   @ResponseBody
//	    public String writeReply(@RequestBody DsEntity dsEntity, Model m) {
//
//	      //  String writer = principal.getName();
//	        // 작성자인지 확인
//	 //       if(!writer.equals("") &&  writer.trim().length() > 0) {
//
//		    Long groupNo = dsEntity.getGroupNo();
//            Long parentNo = dsEntity.getParentNo();
//	            // 원글의 답글인 경우
//	            if(parentNo == 0) {
//	                parentNo = groupNo;
//	            }
//
//	            // parentNo로 부모글 컬럼 가져오기
//	            DsEntity parentBoard = dsRepo.findDsEntityByBoardnum(parentNo);
//
//	            // 부모글 groupSeq
//	            Long parentGroupSeq = parentBoard.getGroupSeq();
//
//	            // 현재 넣으려는 글의 seq
//	            Long nextGroupSeq = parentGroupSeq + 1;
//
//	            // 부모글 depth
//	            Long parentDepth = parentBoard.getDepth();
//
//	            // 작성한 글의 depth
//	            Long depth = parentDepth + 1;
//
//	            // max Seq
//	            Long maxGroupSeq = dsRepo.findMaxGroupSeqByGroupNo(groupNo); 
//
//	            if(nextGroupSeq <= maxGroupSeq){
//	                // 답글이 존재함(이미 존재하는 group_seq인지 확인)
//	                DsEntity findBoard = dsRepo.findDsEntityByGroupNoAndGroupSeq(groupNo,nextGroupSeq);
//	                if(findBoard.getParentNo() != parentNo) {
//	                	dsEntity.setGroupSeq(nextGroupSeq);
//	                    dsRepo.updateAllGroupSeq(findBoard.getGroupNo(), findBoard.getGroupSeq());
//	                }
//	            }
//	            if(dsEntity.getGroupSeq() == 0) {
//	            	dsEntity.setGroupSeq(maxGroupSeq + 1);
//	            }
//	            dsEntity.setParentNo(parentNo);
//	            dsEntity.setDepth(depth);
//	            dsEntity.setBoardwriter(writer);
//
//	            return "qnaList";
//	        }else{
//	            return "qnaList";
//	            		 }
//}
//}
