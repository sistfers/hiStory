package com.hifive.history.controller;

import java.util.List;
import java.util.Map;

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
	
	//테스트용
	@RequestMapping("main/index.hi")
	public String home() {
		SearchDto search = new SearchDto();
		search.setS_id("Y4366");
		search.setSearch_word("대구");
		loger.debug("=HomeControl============================");
		int flag = searchSvc.hi_insert(search);
		loger.debug("=flag============================"+flag);
		//loger.debug("=============flag : " + flag);
		
		List<Map<String, Object>> rankList = searchSvc.hi_selectRankList();
		
		for(int i=0; i< rankList.size(); ++i){
			loger.debug(i+1 + "번째 rank의 RNUM : " +  rankList.get(i).get("RNUM"));
			loger.debug(i+1 + "번째 rank의 CNT : " +  rankList.get(i).get("CNT"));
			loger.debug(i+1 + "번째 rank의 검색어 : " +  rankList.get(i).get("SEARCH_WORD"));
		}
		
		return "/main/index";
	}
	

}
