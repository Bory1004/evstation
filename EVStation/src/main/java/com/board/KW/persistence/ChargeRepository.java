package com.board.KW.persistence;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.board.KW.domain.Charge;


public interface ChargeRepository extends JpaRepository<Charge, Long>{

	Page<Charge> findByOrderByNumDesc(Pageable page);
	Page<Charge> findByStnameContainingIgnoreCase(String st_name,Pageable page);
	Page<Charge> findByStaddress1ContainingIgnoreCase(String st_address1,Pageable page);
	
	@Transactional
	@Query("SELECT COUNT(*) FROM KRecom r WHERE r.num=?1 AND r.id=?2")
	int isRecom(Long num, String id);
	
	@Transactional
	@Modifying
	@Query(value="INSERT INTO KRecom(temp, num, id) VALUES(recom_seq.nextval, :num, :id)", nativeQuery=true)
	int insertRecom(Long num,String id);
	
	@Transactional
	@Modifying
	@Query("DELETE FROM KRecom WHERE id=?1 AND num=?2") 
	void del(String id, Long num);
	
}
