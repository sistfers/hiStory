package com.hifive.history.service;

import com.hifive.history.model.iDto;
import com.hifive.history.repository.VisitDao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by Admin on 2017-03-24.
 */
@Service
public class VisitService implements iService {

	@Autowired
	private VisitDao visitDao;

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
		// TODO Auto-generated method stub
		return null;
	}
	public int hi_getToday(String id){
		return visitDao.hi_getToday(id);
	}
	public int hi_getTotal(String id){
		return visitDao.hi_getTotal(id);
	}
}
