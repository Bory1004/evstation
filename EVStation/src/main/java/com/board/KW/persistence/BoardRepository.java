package com.board.KW.persistence;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.board.KW.domain.Board;

public interface BoardRepository extends JpaRepository<Board, Long>{

	Page<Board> findByOrderByNumDesc(Pageable page);
	
	/*
	 * Page<Board> findAll(Pageable page);
	 * 
	 * @Query( value =
	 * "select * from chargelist where st_name like %:st_name% or st_address1 like %:st_address1"
	 * , countQuery =
	 * "SELECT COUNT(*) FROM chargelist WHERE st_name like %:st_name% or st_address1 like %:st_address1"
	 * ) Page<Board> findAllSearch(String title, String content, Pageable page);
	 */
	
	
}
