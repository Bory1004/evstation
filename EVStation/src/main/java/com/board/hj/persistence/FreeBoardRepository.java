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
	
	//프로필 사진
	@Transactional
	@Query("SELECT m.memphoto FROM Member m WHERE m.memnum=?1")
	String getMemberPhoto(Long boardmennum);
}
