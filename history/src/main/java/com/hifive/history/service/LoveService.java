package com.hifive.history.service;

import com.hifive.history.model.iDto;
import com.hifive.history.repository.LoveDao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoveService implements iService{
	
	@Autowired
	private LoveDao loveDao;

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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int hi_delete(int cnt) {
		return 0;
	}

	@Override
	public List<Map<String, Object>> hi_selectPage(Map<String, Object> dto) throws Exception {
		return null;
	}
}
