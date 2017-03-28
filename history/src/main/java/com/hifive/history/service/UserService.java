package com.hifive.history.service;

import com.hifive.history.model.iDto;
import com.hifive.history.repository.UserDao;

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
public class UserService implements iService {

	@Autowired
	private UserDao userDao;

	@Override
	public int hi_insert(iDto dto) {
		return userDao.hi_insert(dto);
	}

	@Override
	public int hi_update(iDto dto) {
		return userDao.hi_update(dto);
	}

	@Override
	public iDto hi_detail(iDto dto) {
		return userDao.hi_detail(dto);
	}

	public int hi_usercheck(Map<String, Object> condition) {
		return userDao.hi_usercheck(condition);
	}

	@Override
	public int hi_delete(int cnt) {
		return userDao.hi_delete(cnt);
	}

	@Override
	public List<Map<String, Object>> hi_selectList(Map<String, Object> condition) throws Exception {
		return userDao.hi_selectList(condition);
	}

	public iDto hi_login(iDto dto) {
		return userDao.hi_login(dto);
	}
	
	
}
