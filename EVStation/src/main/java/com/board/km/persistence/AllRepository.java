package com.board.km.persistence;

import org.springframework.data.jpa.repository.JpaRepository;

import com.board.km.domain.AllTable;

public interface AllRepository extends JpaRepository<AllTable, Long> {
	
	

}
