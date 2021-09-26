package com.board.free.persistence;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.board.free.domain.FreeRecom;

public interface FreeRecomRepository extends JpaRepository<FreeRecom, Long> {

	@Transactional //추천했는지 확인
	@Query("SELECT COUNT(r) FROM FreeRecom r WHERE r.num=?1 AND r.id=?2")
	int isRecom(Long num, String id);
	
	
	
	@Transactional
	@Modifying
	@Query(value="INSERT INTO FREERECOM(temp, num, id) VALUES(freerecom_seq.nextval, :num, :id)", nativeQuery=true)
	int insertRecom(Long num,String id);
	
	@Transactional
	@Modifying
	@Query("DELETE FROM FreeRecom WHERE num=?1 AND id=?2") 
	void deleteRecom(Long num,String id);
}
