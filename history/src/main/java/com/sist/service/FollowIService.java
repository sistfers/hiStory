package com.sist.service;

import com.sist.repository.FollowDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
/**
 * Created by Admin on 2017-03-24.
 */
@Service
public class FollowIService implements iService {

	@Autowired
	private FollowDao followDao;
}
