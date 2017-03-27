package com.hifive.history.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hifive.history.model.iDto;
import com.hifive.history.repository.MessageDao;

/**
 * Created by Admin on 2017-03-24.
 */
@Service
public class MessageService implements iService {

	Logger loger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private MessageDao messageDao;

	@Override
	public int hi_insert(iDto dto) {
		
		return 0;
	}

	@Override
	public int hi_update(iDto dto) {
		
		return 0;
	}

	@Override
	public iDto hi_detail(iDto dto) {
		
		return null;
	}

	@Override
	public int hi_delete(int cnt) {
		
		return 0;
	}

	@Override
	public List<Map<String, Object>> hi_selectList(Map<String, Object> condition) throws Exception {
		
		return null;
	}

	// 보낸 쪽지함
	public List<Map<String, Object>> hi_select_sendlist(String sendId) {
			
		return messageDao.hi_select_sendlist(sendId);
	}
}


