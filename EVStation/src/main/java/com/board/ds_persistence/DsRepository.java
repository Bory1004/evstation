package com.board.ds_persistence;

import org.springframework.data.jpa.repository.JpaRepository;

import com.board.ds_entity.DsEntity;

public interface DsRepository extends JpaRepository<DsEntity, Long> {

}
