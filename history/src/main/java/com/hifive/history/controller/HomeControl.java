package com.hifive.history.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.hifive.history.model.UserDto;
import com.hifive.history.service.PostService;
import com.hifive.history.service.SearchService;
import com.hifive.history.service.UserService;

/**
 * Created by Admin on 2017-03-23.
 */
@Controller
@SessionAttributes("user")
public class HomeControl {
	Logger loger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	SearchService searchSvc;

	@Autowired
	UserService userService;
	
	@Autowired
	PostService postSvc;
	
	@RequestMapping(value = "main/index.hi")
	public ModelAndView home(HttpServletRequest request, HttpSession session) {
		if (session.getAttribute("user") != null) {
			UserDto dto = (UserDto) session.getAttribute("user");
			System.out.println(dto.toString());
		}
		
		ModelAndView mav = new ModelAndView();
		List<Map<String, Object>> searchRank = searchSvc.hi_selectRankList();
		
		mav.setViewName("/main/index");
		mav.addObject("searchRank", searchRank);
		
		return mav;
	}

	@RequestMapping(value = "main/login.hi", method = RequestMethod.POST)
	public ModelAndView login(HttpServletRequest request, HttpSession session, Model model) {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("/main/login");

		// 로그인 시
		if (request.getParameter("do_login") != null) {
			String id = (String)request.getParameter("id");
			String password = (String)request.getParameter("password");
			UserDto loginDto = new UserDto();
			loginDto.setId(id);
			loginDto.setPassword(password);

			UserDto userDto = (UserDto)userService.hi_login(loginDto);
			if (userDto == null) {
				mav.addObject("fail", "아이디 혹은 패스워드를 확인해 주세요.");
				return mav;
			}
			model.addAttribute("user", userDto);
			mav.setViewName("redirect:/");
			return mav;
		}
		return mav;
	}

	@RequestMapping("header.hi")
	public String header() {
		return "/main/header";
	}

	@RequestMapping("main/logout.hi")
	public String logout(ModelMap modelMap, HttpSession session) {
		modelMap.remove("user");
		session.removeAttribute("user");
		return "redirect:/";
	}
	
	@RequestMapping(value="main/do_search.hi",method=RequestMethod.POST)
	public ModelAndView do_search(HttpServletRequest res)throws Exception{
		ModelAndView mav = new ModelAndView();
		
		
		String search_word = "%"+res.getParameter("search_word").trim()+"%";
		String PAGE_SIZE 	= "10";	//페이지사이즈
		String PAGE_NUM		= "1";	//페이지NUM
		
		PAGE_NUM		= (res.getParameter("PAGE_NUM")==null || res.getParameter("PAGE_NUM").equals("")) ? "1" : res.getParameter("PAGE_NUM");	//페이지NUM
		loger.debug("들어왔다!!!!!!! 단어는 ::"+ search_word);
		Map<String, Object> condition = new HashMap();
		
		condition.put("PAGE_SIZE", PAGE_SIZE);
		condition.put("PAGE_NUM", PAGE_NUM);
		condition.put("SEARCH_WORD", search_word);
		List<Map<String, Object>> searchList = postSvc.hi_selectSearchList(condition);
		
		mav.setViewName("/main/home_search");
		mav.addObject("searchList", searchList);
		mav.addObject("PAGE_NUM"  , PAGE_NUM  );
		return mav;
	}
}
