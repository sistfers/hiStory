package com.hifive.history.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.hifive.history.model.BlogDto;
import com.hifive.history.model.UserDto;
import com.hifive.history.service.BlogService;
import com.hifive.history.service.CodeDService;
import com.hifive.history.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

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

	@Autowired
	CodeDService codeDService;

	@RequestMapping(value = "user/join.hi", method = RequestMethod.POST)
	public ModelAndView join(HttpServletRequest request, Model model) {
		ModelAndView mav = new ModelAndView();

		// 회원 가입 버튼 클릭해서 넘어왔을 시
		if (request.getParameter("do_join") != null) {
			// 회원 추가
			UserDto userDto = new UserDto();
			userDto.setId(request.getParameter("id"));
			userDto.setName(request.getParameter("name"));
			userDto.setPassword(request.getParameter("password"));
			userDto.setEmail(request.getParameter("email"));
			userDto.setArea(request.getParameter("area"));
			userDto.setBirth(request.getParameter("birth"));
			userDto.setSex(request.getParameter("sex"));
			userDto.setPf_content(request.getParameter("profileCon"));
			userDto.setPf_image("");
//			userDto.setPf_image(request.getParameter("profileImg"));
			userService.hi_insert(userDto);

			// 블로그 추가
			BlogDto blogDto = new BlogDto();
			blogDto.setId(request.getParameter("id"));
			blogDto.setTitle(request.getParameter("id") + "님의 블로그");
			blogService.hi_insert(blogDto);

			// 세션에 로그인정보 추가
			userDto = (UserDto) userService.hi_login(userDto);
			model.addAttribute("user", userDto);
			mav.setViewName("redirect:/");

		} else {
			// 지역 리스트 가져오기
			List<Map<String, Object>> areaMapList = new ArrayList<Map<String, Object>>();
			Map<String, Object> condition = new HashMap<>();
			List<String> code_list = new ArrayList<String>();
			code_list.add("120");
			condition.put("code_list", code_list);
			try {
				areaMapList = codeDService.hi_selectList(condition);
			} catch (Exception e) {
				e.printStackTrace();
			}
			List<String> areaList = new ArrayList<String>();
			for (int i = 0; i < areaMapList.size(); i++)
				areaList.add((String) areaMapList.get(i).get("CD_D_NM"));
			mav.addObject("areaList", areaList);
			mav.setViewName("/user/join");
		}

		return mav;
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
