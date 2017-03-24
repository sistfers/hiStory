package com.hifive.history.service;

import com.hifive.history.repository.CommentDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Admin on 2017-03-24.
 */
@Service
public class CommentService implements iService {

	@Autowired
	private CommentDao commentDao;
}
