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
<<<<<<< HEAD
=======
		// TODO Auto-generated method stub
>>>>>>> origin/master
		return 0;
	}

	@Override
	public int hi_update(iDto dto) {
<<<<<<< HEAD
=======
		// TODO Auto-generated method stub
>>>>>>> origin/master
		return 0;
	}

	@Override
	public iDto hi_detail(iDto dto) {
<<<<<<< HEAD
=======
		// TODO Auto-generated method stub
>>>>>>> origin/master
		return null;
	}

	@Override
	public int hi_delete(int cnt) {
<<<<<<< HEAD
=======
		// TODO Auto-generated method stub
>>>>>>> origin/master
		return 0;
	}

	@Override
<<<<<<< HEAD
	public List<Map<String, Object>> hi_selectPage(Map<String, Object> dto) throws Exception {
		return null;
	}
=======
	public List<Map<String, Object>> hi_selectList(Map<String, Object> condition) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	
>>>>>>> origin/master
}
