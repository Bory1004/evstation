package com.board.hj.persistence;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.board.hj.domain.Board;

public interface BoardRepository extends JpaRepository<Board, Long>{

	Page<Board> findByOrderByBoardnumDesc(Pageable page);
	
	//조회수
	@Transactional
	@Modifying
	@Query("UPDATE Board b SET b.boardsee = b.boardsee+1 WHERE b.boardnum=?1")
	int updateBoardsee(Long boardnum);
	
	Page<Board> findByBoardtitleContainingIgnoreCase(String boardtitle,Pageable page);
	Page<Board> findByBoardcontentContainingIgnoreCase(String boardcontent,Pageable page);
	Page<Board> findByBoardwriterContainingIgnoreCase(String boardwriter,Pageable page);
}
