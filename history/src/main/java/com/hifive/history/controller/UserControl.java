package com.hifive.history.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.hifive.history.model.UserDto;
import com.hifive.history.service.BlogService;
import com.hifive.history.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	@RequestMapping(value = "user/idCheck.hi", method = RequestMethod.POST)
	@ResponseBody
	public String idCheck(HttpServletRequest request) {
		Map<String, Object> condition = new HashMap<>();
		condition.put("SEARCH_CON", "idcheck");
		condition.put("id", request.getParameter("id"));
		int flag = userService.hi_usercheck(condition);

		JsonObject jobj = new JsonObject();

		if(flag < 1)
			jobj = new JsonParser().parse("{\"msg\":\"true\"}").getAsJsonObject();
		else
			jobj = new JsonParser().parse("{\"msg\":\"false\"}").getAsJsonObject();
		Gson gson = new Gson();
		return gson.toJson(jobj);
	}
}
