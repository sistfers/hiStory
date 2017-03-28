package com.hifive.history.controller;

import com.hifive.history.model.UserDto;
import com.hifive.history.service.FollowService;
import com.hifive.history.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Admin on 2017-03-24.
 */
@Controller
public class testControl {

	@Autowired
	FollowService followService;

	@Autowired
	UserService userService;

//	@RequestMapping("main/index.hi")
//	public String home() {
//		팔로우 리스트 테스트
//		Map<String, Object> search_con = new HashMap<String, Object>();
//		String SEARCH_CON = "ifollow";     // 조회 구분
//		String id = "Y4366";
//		String PAGE_SIZE = "10";
//		String PAGE_NUM = "1";
//		search_con.put("SEARCH_CON", SEARCH_CON);
//		search_con.put("id", id);
//		search_con.put("PAGE_SIZE", PAGE_SIZE);
//		search_con.put("PAGE_NUM", PAGE_NUM);
//
//		try {
//			System.out.println(followService.hi_selectList(search_con).toString());
//		} catch (Exception e) {
//			e.printStackTrace();
//		}

//		유저 테스트
//		Map<String, Object> search_con = new HashMap<String, Object>();
//		String SEARCH_CON = "idcheck";     // 조회 구분
//		String id = "Y4366";
//		search_con.put("SEARCH_CON", SEARCH_CON);
//		UserDto dto = new UserDto();
//		dto.setId("kokokk");
//		dto.setName("ddddddddd");
//		dto.setArea("ddddddddd");
//		dto.setBirth("2017-03-27");
//		dto.setEmail("kokokk@asasd");
//		dto.setGrade("GOLD");
//		dto.setSex("0");
//		dto.setPassword("asdasd");
//		dto.setPf_content("asdasd");
//		dto.setPf_image("asdasd");
//
//		try {
//			System.out.println(userService.hi_usercheck(search_con));
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return "/main/index";
//	}







}
