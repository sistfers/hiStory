package com.hifive.history.controller;

import java.util.List;
import java.util.Map;

import com.hifive.history.model.UserDto;
import com.hifive.history.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hifive.history.model.SearchDto;
import com.hifive.history.service.SearchService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by Admin on 2017-03-23.
 */
@Controller
public class HomeControl {
	Logger loger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	SearchService searchSvc;

	@Autowired
	UserService userService;
	
	@RequestMapping("main/index.hi")
	public String home() {

		return "/main/index";
	}

	@RequestMapping("main/login.hi")
	public String login(HttpServletRequest request, HttpSession session) {

		// 로그인 시
		if (request.getParameter("do_login") != null) {
			String id = (String)request.getParameter("id");
			String password = (String)request.getParameter("password");
			UserDto loginDto = new UserDto();
			loginDto.setId(id);
			loginDto.setPassword(password);

			UserDto userDto = (UserDto)userService.hi_login(loginDto);
			if (userDto == null) {
				request.setAttribute("fail", "아이디 혹은 패스워드를 확인해 주세요.");
				return "/main/login";
			}
			session.setAttribute("user", userDto);
			return "/main/index";
		}

		return "/main/login";
	}

	@RequestMapping("header.hi")
	public String header() {
		return "/main/header";
	}
	

}
