package com.hifive.history.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hifive.history.model.SearchDto;
import com.hifive.history.service.SearchService;

/**
 * Created by Admin on 2017-03-23.
 */
@Controller
public class HomeControl {
	Logger loger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	SearchService searchSvc;
	
	@RequestMapping("main/index1.hi")
	public String home() {
		SearchDto search = new SearchDto();
		search.setS_id("Y4366");
		search.setSearch_word("대구");
		
		int flag = searchSvc.hi_insert(search);
		loger.debug("=============flag : " + flag);
		return "/main/index";
	}
	

}
