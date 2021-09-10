package com.board.km.persistence;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.board.km.domain.Alarm;

@Repository
public interface AlarmRepository extends JpaRepository<Alarm, Long> {

	public List<Alarm> findByMemnum(Long memnum);
}
