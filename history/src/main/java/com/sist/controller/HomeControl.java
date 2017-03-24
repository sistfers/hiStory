package com.sist.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Admin on 2017-03-23.
 */
@Controller
public class HomeControl {

	@RequestMapping("index.hi")
	public String home() {
		return "/post/main";
	}
	@RequestMapping("header.hi")
	public String header() {
		return "main/header";
	}
}
