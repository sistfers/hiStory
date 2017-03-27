package com.hifive.history.service;

import com.hifive.history.model.iDto;
import com.hifive.history.repository.BoxDao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoxIService implements iService {

	@Autowired
	private BoxDao boxDao;

	@Override
	public int hi_insert(iDto dto) {
		return boxDao.hi_insert(dto);
	}

	@Override
	public int hi_update(iDto dto) {
		return boxDao.hi_update(dto);
	}

	@Override
	public iDto hi_detail(iDto dto) {
		return boxDao.hi_detail(dto);
	}

	@Override
	public int hi_delete(int cnt) {
		return boxDao.hi_delete(cnt);
	}

	@Override
	public List<Map<String, Object>> hi_selectPage(Map<String, Object> dto) throws Exception {
		return boxDao.hi_selectList(dto);
	}
}
