package com.board.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.review.domain.Alarm;
import com.board.review.persistence.AlarmRepository;

@Service
public class AlarmServiceImpl implements AlarmService {

	@Autowired
	AlarmRepository alarmRepo;
	
	public void saveAlarm(Alarm alarm) {
		alarmRepo.save(alarm);
	}
	
	public List<Alarm> getAlarms(Long memnum) {
		return alarmRepo.findByMemnum(memnum);
	}

	@Override
	public int countAlarm(Long memnum) {
		int counts = alarmRepo.countAlarm(memnum);
		return counts;
	}
	
	@Override
	public void delAlarm(Long alanum) {
		alarmRepo.deleteById(alanum);
	}
	
	@Override
	public void	checkAlarm(Long alanum) {
		alarmRepo.checkAlarm(alanum);
	}

	@Override
	public void withdraw(Long memnum) {
		alarmRepo.deleteByMemnum(memnum);
	}
}
