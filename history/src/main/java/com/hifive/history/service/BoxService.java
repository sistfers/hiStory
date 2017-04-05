package com.hifive.history.service;

import com.hifive.history.model.BoxDto;
import com.hifive.history.model.iDto;
import com.hifive.history.repository.BoxDao;
import com.hifive.history.util.FileUtils;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class BoxService implements iService {

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
	public List<Map<String, Object>> hi_selectList(Map<String, Object> condition) throws Exception {
		return boxDao.hi_selectList(condition);
	}
}
