package com.hifive.history.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Admin on 2017-03-24.
 */
@Controller
public class UserControl {

	@RequestMapping("user/join.hi")
	public String join() {
		return "/user/join";
	}
}
