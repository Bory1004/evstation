package com.board.review.persistence;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.board.review.domain.Alarm;

@Repository
public interface AlarmRepository extends JpaRepository<Alarm, Long> {

	public List<Alarm> findByMemnum(Long memnum);

	@Query("SELECT count(a) FROM Alarm a WHERE a.memnum=?1")
	public int countAlarm(Long memnum);
	
	@Transactional
	@Modifying
	@Query("UPDATE Alarm a set a.alacheck = 1 where a.alanum = ?1")
	public void checkAlarm(Long alanum);

	@Transactional
	@Modifying
	@Query("DELETE FROM Alarm d WHERE d.frommemnum=?1")
	public void deleteByMemnum(Long memnum);
		
	
}
