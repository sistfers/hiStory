package com.hifive.history.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Admin on 2017-03-24.
 */
@Controller
public class testControl {

	@RequestMapping("main/index.hi")
	public String home() {
		return "/views/main/index";
	}

	@RequestMapping("post/main.hi")
	public String main() {
		return "/views/post/main";
	}

	@RequestMapping("user/join.hi")
	public String join() {
		return "/views/user/join";
	}

	@RequestMapping("main/login.hi")
	public String login() {
		return "/views/main/login";
	}

	@RequestMapping("message/message_list.hi")
	public String messageList() {
		return "/views/message/message_list";
	}

	@RequestMapping("message/write.hi")
	public String messageWrite() {
		return "/views/message/write";
	}

	@RequestMapping("post/write.hi")
	public String postWrite() {
		return "/views/post/write";
	}
}
