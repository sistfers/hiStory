package com.sist.service;

import com.sist.repository.MessageDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Admin on 2017-03-24.
 */
@Service
public class MessageService implements iService {

	@Autowired
	private MessageDao messageDao;


}
