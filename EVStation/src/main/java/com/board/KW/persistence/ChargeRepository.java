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
	
	/*
	 * @Transactional
	 * 
	 * @Modifying
	 * 
	 * @Query("UPDATE chargelist b SET b.cnt = b.cnt+1 WHERE b.num=?1") int
	 * updateCnt(Long num);
	 */
	
}