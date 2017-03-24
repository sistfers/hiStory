package com.sist.service;

import com.sist.repository.BoxDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Admin on 2017-03-24.
 */
@Service
public class BoxIService implements iService {

	@Autowired
	private BoxDao boxDao;
}
