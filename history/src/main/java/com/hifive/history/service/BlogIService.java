package com.hifive.history.service;

import com.hifive.history.model.iDto;
import com.hifive.history.repository.BlogDao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BlogIService implements iService {

	@Autowired
	private BlogDao blogDao;

	@Override
	public int hi_insert(iDto dto) {
		
		return blogDao.hi_insert(dto);
	}

	@Override
	public int hi_update(iDto dto) {
		return blogDao.hi_update(dto);
	}

	@Override
	public iDto hi_detail(iDto dto) {
		return blogDao.hi_detail(dto);
	}

	@Override
	public int hi_delete(int cnt) {
		return blogDao.hi_delete(cnt);
	}

	@Override
<<<<<<< HEAD
	public List<Map<String, Object>> hi_selectPage(Map<String, Object> dto) throws Exception {
=======
	public List<Map<String, Object>> hi_selectList(Map<String, Object> dto) throws Exception {
>>>>>>> origin/master
		return blogDao.hi_selectList(dto);
	}
}
