package com.board.ds.persistence;



import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.data.jpa.repository.Query;

import com.board.ds.domain.DsComment;
import com.board.km.domain.BoardComment;

public interface DsCommentRepository extends JpaRepository<DsComment, Long> {

	
	//댓글 갯수 	
	@Query("SELECT count(c) from DsComment c where c.boardnum = ?1")
	int getComentCount(Long comnum);
	
	List<DsComment>findByComgroupnum(Long comgroupnum); //알람 테이블에 추가할 멤버번호들 가져오기
	
	List<DsComment> findByBoardnumAndComrestepOrderByComdateAsc(Long comnum, Long comrestep);  // 일반댓글만 불러오기
	List<DsComment> findByBoardnumAndComrestepGreaterThanOrderByComdateAsc(Long comnum, Long comrestep); //대댓글만 불러오기
	
	
	
	
	
	
	//모든 댓글
	//해당 게시물의 댓글
	Page<DsComment> findByBoardnumOrderByComnumDesc(Pageable page, Long boardnum);
	
	@Transactional
	@Modifying
	@Query("DELETE FROM DsComment d WHERE d.commemnum = ?1")
	void deleteByMemnum(Long memnum);


}
