package com.board.charge.persistence;


import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.board.charge.domain.Charge;


public interface ChargeRepository extends JpaRepository<Charge, Long>{
	

	Page<Charge> findByOrderByNumDesc(Pageable page);
	Page<Charge> findByStnameContainingIgnoreCase(String st_name,Pageable page);
	Page<Charge> findByStaddress1ContainingIgnoreCase(String st_address1,Pageable page);
	
	@Transactional
	@Query("SELECT COUNT(*) FROM Book r WHERE r.num=?1 AND r.id=?2")
	int isRecom(Long num, String id);
	
	@Transactional
	@Modifying
	@Query(value="INSERT INTO BOOKMARK(temp, num, id) VALUES(bookmark_seq.nextval, :num, :id)" , nativeQuery=true)
	int insertRecom(Long num,String id);
	

	@Transactional
	@Modifying
	@Query("DELETE FROM Book WHERE id=?1 AND num=?2") 
	void del(String id, Long num);

	@Transactional
	@Query(value="SELECT * FROM CHARGELIST2 c WHERE c.ST_NUM IN (SELECT b.num FROM BOOKMARK b WHERE b.id =?1)",nativeQuery=true)
	Page<Charge> findByOrderByNumDesc(String id, Pageable page);
	
	@Transactional
	@Modifying
	@Query(value="DELETE FROM BOOKMARK WHERE NUM = ?1" ,nativeQuery=true)
	void deleteBookmark(Long stnum);
	
	@Transactional
	@Modifying
	@Query(value="DELETE FROM Charge c WHERE c.stnum = ?1")
	void deleteAdminChargeChk(Long stnum);

	
}
