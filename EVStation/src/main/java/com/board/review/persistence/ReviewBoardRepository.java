package com.board.review.persistence;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.board.review.domain.AllTableDTO;
import com.board.review.domain.ReviewBoard;

@Repository
public interface ReviewBoardRepository extends JpaRepository<ReviewBoard, Long> {
	
	Page<ReviewBoard> findByBoardstnumOrderByBoardnumDesc(Long i,Pageable page);

	Page<ReviewBoard> findByBoardstnumAndBoardtitleContainingIgnoreCaseOrderByBoardnumDesc(Long i,String search, Pageable page);

	Page<ReviewBoard> findByBoardstnumAndBoardwriterContainingIgnoreCaseOrderByBoardnumDesc(Long i,String search, Pageable page);

	Page<ReviewBoard> findByBoardstnumAndBoardcontentContainingIgnoreCaseOrderByBoardnumDesc(Long i,String search, Pageable page);

	ReviewBoard findByBoardnum(Long num);
	
	//관리자 페이지 stnum 상관없이 다 불러오기 위해서
	Page<ReviewBoard>findByOrderByBoardnumDesc(Pageable page);
	Page<ReviewBoard>findByBoardtitleContainingIgnoreCase(String boardtitle, Pageable page);
	Page<ReviewBoard>findByBoardcontentContainingIgnoreCase(String boardcontent, Pageable page);
	Page<ReviewBoard>findByBoardwriterContainingIgnoreCase(String boardwriter, Pageable page);
	
	@Transactional
	@Modifying
	@Query("UPDATE ReviewBoard b SET b.boardsee = b.boardsee+1 WHERE b.boardnum=:boardnum")
	int updateCnt(@Param("boardnum") Long num); //"UPDATE ReviewBoard b SET b.boardsee = b.boardsee+1 WHERE b.boardnum=?1" JPQL
							                    // "UPDATE Board01 b SET b.board_see = b.board_see+1 WHERE b.board_num=?1" 네이티브쿼리


	//내가 쓴글  //대순이씀...
	 Page<ReviewBoard>findByBoardmemnumOrderByBoardnumDesc( Long boardmemnum, Pageable page);
	 
	@Transactional
	@Modifying
	@Query("DELETE FROM ReviewBoard d where d.boardmemnum = ?1")
	void deleteByMemnum(Long memnum);

	
	@Transactional
	@Query(name="find_alltable",
			/*
			 * countQuery= "select count(te) from" + "(" +
			 * "   select board_num as boardnum ,board_title as boardtitle ,board_writer as boardwriter,"
			 * +
			 * "	  board_date as boarddate ,board_see as boardsee ,board_recom as boardrecom from board02 a where a.board_mem_num =?1"
			 * + "   union all" +
			 * "   select board_num as boardnum ,board_title as boardtitle ,board_writer as boardwriter,"
			 * +
			 * "   board_date as boarddate ,board_see as boardsee, board_recom as boardrecom from qnaboard b where b.board_mem_num =?1"
			 * + "   union all" + "   select boardnum, boardtitle, boardwriter ," +
			 * "   boarddate , boardsee  , boardrecom from freeboard c where c.memnum =?1" +
			 * ") te " + "order by boarddate desc ",
			 */
	nativeQuery=true)

	List<AllTableDTO> findAllBoard(Long boardmemnum);
	
	@Transactional
	@Modifying
	@Query("UPDATE ReviewBoard d SET d.boardrecom = ?1 WHERE d.boardnum = ?2")
	void updateRecom(Long recomCnt,Long num); 



	

}
