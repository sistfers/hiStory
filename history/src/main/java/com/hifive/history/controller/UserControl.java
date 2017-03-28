package com.hifive.history.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by Admin on 2017-03-24.
 */
@Controller
public class UserControl {

	@RequestMapping(value = "user/join.hi", method = RequestMethod.POST)
	public String join() {
		return "/user/join";
	}
}
