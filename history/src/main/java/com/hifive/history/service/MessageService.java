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

	// 쪽지 쓰기
	@Override
	public int hi_insert(iDto dto) {
		
		return messageDao.hi_insert(dto);
	}

	@Override
	public int hi_update(iDto dto) {
		
		return 0;
	}

	// 쪽지 읽기
	@Override
	public iDto hi_detail(iDto dto) {
		
		return messageDao.hi_detail(dto);
	}
	
	// 쪽지 읽고 나서
	public int hi_detail_state(int seq) {
		
		return messageDao.hi_detail_state(seq);
	}

	// 쪽지 삭제
	@Override
	public int hi_delete(int cnt) {
		
		return messageDao.hi_delete(cnt);
	}

	@Override
	public List<Map<String, Object>> hi_selectList(Map<String, Object> condition) throws Exception {
		
		return null;
	}
	
	// 받은 쪽지함
	public List<Map<String, Object>> hi_select_getlist(Map<String, Object> search_info) {
		
		return messageDao.hi_select_getlist(search_info);
	}

	// 보낸 쪽지함
	public List<Map<String, Object>> hi_select_sendlist(Map<String, Object> search_info) {
			
		return messageDao.hi_select_sendlist(search_info);
	}
	
	// 검색 결과(내용)
	public List<Map<String, Object>> hi_select_filtered(Map<String, Object> search_info) {
		
		return messageDao.hi_select_filtered(search_info);
	}
}


