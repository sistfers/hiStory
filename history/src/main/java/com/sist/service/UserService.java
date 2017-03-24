package com.sist.service;

import com.sist.repository.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Admin on 2017-03-24.
 */
@Service
public class UserService implements iService {

	@Autowired
	private UserDao userDao;
}
