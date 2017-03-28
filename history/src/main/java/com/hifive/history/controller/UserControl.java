package com.hifive.history.controller;

import com.hifive.history.model.UserDto;
import com.hifive.history.service.BlogService;
import com.hifive.history.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Admin on 2017-03-24.
 */
@Controller
@SessionAttributes("user")
public class UserControl {

	@Autowired
	UserService userService;

	@Autowired
	BlogService blogService;

	@RequestMapping(value = "user/join.hi", method = RequestMethod.POST)
	public String join(HttpServletRequest request, Model model) {
		List<String> areaList = new ArrayList<String>();


		// 회원 가입 시
		if (request.getParameter("do_join") != null) {
			UserDto userDto = new UserDto();
			userDto.setId(request.getParameter("id"));
			userDto.setName(request.getParameter("name"));
			userDto.setPassword(request.getParameter("password"));
			userDto.setEmail(request.getParameter("email"));
			userDto.setArea(request.getParameter("area"));
			userDto.setBirth(request.getParameter("birth"));
			userDto.setSex(request.getParameter("sex"));
			userDto.setPf_content(request.getParameter("profileCon"));
			userDto.setPf_image(request.getParameter("profileImg"));
			System.out.println(userDto.toString());
		}
		return "/user/join";
	}
}
