package com.board.ay.persistence;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.board.ay.domain.Board3;

@Repository
public interface BoardRepository3 extends JpaRepository<Board3, Long>{
	
	Page<Board3> findByOrderByNumDesc(Pageable page);
	
	@Transactional
	@Modifying
	@Query("UPDATE Board3 b SET b.cnt = b.cnt+1 WHERE b.num=?1")
	int updateCnt(Long num);
	//특정컬럼만 변경하고 싶을 때 update!사용.. 여기서는 조회수 때문에 사용함.entity클래스 이름 지정해야함.table이름말고!
	//update문 @Transactional,@Modifying 얘네 둘 항상 같이 다님!
	
	@Transactional
	@Modifying
	@Query("UPDATE Board3 b SET b.recom = b.recom+1 WHERE b.num=?1")
	int upRecom(Long num);
	
	
	Page<Board3> findByTitleContainingIgnoreCase(String title,Pageable page);
	Page<Board3> findByContentContainingIgnoreCase(String content,Pageable page);

	//09
	@Transactional
	@Query("SELECT COUNT(*) FROM Recom r WHERE r.num=?1 AND r.id=?2")
	int isRecom(Long num, String id);
	
	@Transactional
	@Modifying
	@Query(value="INSERT INTO Recom(temp, num, id) VALUES(recom_seq.nextval, :num, :id)", nativeQuery=true)
	int insertRecom(Long num,String id);
	
	//추천한 적 있다면 추천수 내림
	@Transactional
	@Modifying
	@Query("UPDATE Board3 b SET b.recom = b.recom-1 WHERE b.num=?1")
	int dnRecom(Long num);

	@Transactional
	@Modifying
	@Query("DELETE FROM Recom WHERE id=?1 AND num=?2") 
	void del(String id, Long num);
	
	
}
