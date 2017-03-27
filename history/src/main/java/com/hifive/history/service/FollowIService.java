package com.hifive.history.service;

import com.hifive.history.model.iDto;
import com.hifive.history.repository.FollowDao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
/**
 * Created by Admin on 2017-03-24.
 */
@Service
public class FollowIService implements iService {

	@Autowired
	private FollowDao followDao;

	@Override
	public int hi_insert(iDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int hi_update(iDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public iDto hi_detail(iDto dto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int hi_delete(int cnt) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Map<String, Object>> hi_selectList(Map<String, Object> condition) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
