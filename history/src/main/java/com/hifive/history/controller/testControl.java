package com.hifive.history.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Admin on 2017-03-24.
 */
@Controller
public class testControl {

	@RequestMapping("user/join.hi")
	public String join() {
		return "/user/join";
	}

	@RequestMapping("main/login.hi")
	public String login() {
		return "/main/login";
	}

	@RequestMapping("message/message_list.hi")
	public String messageList() {
		return "/message/message_list";
	}

	@RequestMapping("message/write.hi")
	public String messageWrite() {
		return "/message/write";
	}

}
