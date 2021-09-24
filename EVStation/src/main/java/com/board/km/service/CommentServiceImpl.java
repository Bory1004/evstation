package com.board.km.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.board.km.domain.BoardComment;
import com.board.km.persistence.CommentRepository;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	CommentRepository commentRepo;
	
	@Override
	public Optional<BoardComment> getComment(Long comnum) {
		return commentRepo.findById(comnum);
	}
	
	
	@Override
	public void saveComment(BoardComment board) {
		commentRepo.save(board);
	}

	@Override
	public void saveReply(Long comnum) { //제목 댓글 저장
		commentRepo.updategroupnumandcomrestep(comnum);
	}

	@Override
	public List<BoardComment> getComments(int cNum, Long num, Long comrestep) {
		Pageable page =  PageRequest.of(cNum-1, 10); // 불러올페이지, 페이지크기
		return commentRepo.findByBoardnumAndComrestepOrderByComdateAsc(num,comrestep); //일반댓글만 불러오기
	}
	@Override
	public List<BoardComment> getReplyComments(Long num,Long comrestep) {
		
		return commentRepo.findByBoardnumAndComrestepGreaterThanOrderByComdateAsc(num,comrestep); //대댓글만 불러오기
	}

	@Override
	public int deleteComment(Long comnum,Long comgroupnum) { //commentRepo.deleteByComroupnum
		if ( (long)comnum == (long)comgroupnum) { //일반댓글인 경우 대댓글까지 다지움
			int count =commentRepo.countComment(comgroupnum);
			commentRepo.deleteByComgroupnum(comgroupnum);
			return count;
		}else { //대댓글인경우
			commentRepo.deleteById(comnum);
			return 1;
		}
	}


	@Override
	public void updateComment(Long comnum, String comcontent) {
		commentRepo.updateComment(comnum,comcontent);
	}

	@Override
	public void saveReStep(Long groupnum,Long comnum) { //대댓글 저장
		commentRepo.updaterestep(groupnum,comnum);

	}
	
	@Override
	public List<BoardComment> getmembernum(Long comgroupnum) { //해당그룹번호에 해당하는 멤버번호가져오기
		return commentRepo.findByComgroupnum(comgroupnum);
	}


	@Override //글지울때 지우는 메서드
	public void deleteComment(Long boardnum) {
		commentRepo.deleteByBoardnum(boardnum);
		
	}
	@Override
	public int getCount(Long num) {
		return commentRepo.getCount(num);
	}


	@Override
	public void withdraw(Long memnum) {
		commentRepo.deleteByMemnum(memnum);
	}

}
