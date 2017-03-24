package com.sist.service;

import com.sist.repository.VisitDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Admin on 2017-03-24.
 */
@Service
public class VisitIService implements iService {

	@Autowired
	private VisitDao visitDao;
}
