package com.sist.service;

import com.sist.repository.CategoryDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Admin on 2017-03-24.
 */
@Service
public class CategoryIService implements iService {

	@Autowired
	private CategoryDao categoryDao;
}
