package com.board.km.service;

import java.util.List;

import com.board.km.domain.Alarm;

public interface AlarmService {

	void saveAlarm(Alarm alarm);

	List<Alarm> getAlarms(Long memnum);

	int countAlarm(Long memnum);

	void delAlarm(Long alanum);

	void checkAlarm(Long alanum);


}
