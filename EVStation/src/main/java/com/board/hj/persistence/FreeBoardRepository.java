package com.board.hj.persistence;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.board.hj.domain.FreeBoard;

public interface FreeBoardRepository extends JpaRepository<FreeBoard, Long>{

	Page<FreeBoard> findByOrderByBoardnumDesc(Pageable page);
	
	//조회수
	@Transactional
	@Modifying
	@Query("UPDATE FreeBoard b SET b.boardsee = b.boardsee+1 WHERE b.boardnum=?1")
	int updateBoardsee(Long boardnum);
	
	Page<FreeBoard> findByBoardtitleContainingIgnoreCase(String boardtitle,Pageable page);
	Page<FreeBoard> findByBoardcontentContainingIgnoreCase(String boardcontent,Pageable page);
	Page<FreeBoard> findByBoardwriterContainingIgnoreCase(String boardwriter,Pageable page);
	
	//해당 게시물의 댓글수
	@Transactional
	@Query("select count(*) from FreeBoardComment c where c.boardnum=?1")
	int getCommentCount(Long boardnum);
	
	//Page<FreeBoard> findByMemberContainingIgnoreCase(String boardwriter,Pageable page);
	
	//내가 쓴글  //대순이씀...
		 Page<FreeBoard>findByBoardmennumOrderByBoardnumDesc( Long boardmemnum, Pageable page); 	
}
