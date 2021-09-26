package com.board.qna.persistence;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.board.qna.domain.QnARecom;

public interface QnARecomRepository extends JpaRepository<QnARecom, Long> {


	@Transactional //추천했는지 확인
	@Query("SELECT COUNT(r) FROM QnARecom r WHERE r.num=?1 AND r.id=?2")
	int isRecom(Long num, String id);
	
	
	
	@Transactional
	@Modifying
	@Query(value="INSERT INTO QNARECOM(temp, num, id) VALUES(qnarecom_seq.nextval, :num, :id)", nativeQuery=true)
	int insertRecom(Long num,String id);
	
	@Transactional
	@Modifying
	@Query("DELETE FROM QnARecom WHERE num=?1 AND id=?2") 
	void deleteRecom(Long num,String id);
	
}

