package com.board.review.persistence;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.board.review.domain.ReviewRecom;

public interface ReviewRecomRepository extends JpaRepository<ReviewRecom, Long> {

	
	@Transactional //추천했는지 확인
	@Query("SELECT COUNT(r) FROM ReviewRecom r WHERE r.num=?1 AND r.id=?2")
	int isRecom(Long num, String id);
	
	@Transactional // 해당글의 추천수
	@Query("SELECT COUNT(r) FROM ReviewRecom r WHERE r.num=?1")
	int getRecom(Long num);
	
	@Transactional
	@Modifying
	@Query(value="INSERT INTO ReviewRecom(temp, num, id) VALUES(recom_seq.nextval, :num, :id)", nativeQuery=true)
	int insertRecom(Long num,String id);
	
	@Transactional
	@Modifying
	@Query("DELETE FROM ReviewRecom WHERE num=?1 AND id=?2") 
	void deleteRecom(Long num,String id);
	
}
