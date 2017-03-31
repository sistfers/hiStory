package com.hifive.history.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AuthControl {	
	
	@RequestMapping(value = "userAuth.hi", method = RequestMethod.POST)
	public ModelAndView join(HttpServletRequest request) {
		
		return null;
	}
}

