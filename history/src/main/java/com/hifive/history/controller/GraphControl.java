package com.hifive.history.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hifive.history.model.CategoryDto;
import com.hifive.history.model.iDto;
import com.hifive.history.service.CategoryService;

/**
 * Created by Admin on 2017-03-24.
 */
@Controller
public class GraphControl {
	@Autowired
	private CategoryService categoryService;
	
	@RequestMapping("chart/visit.hi")
	public String visit() {
		return "/chart/visit";
	}
	@RequestMapping("chart/age.hi")
	public String age() {
		return "/chart/age";
	}
	@RequestMapping("chart/menu.hi")
	public String menu() {
		return "/chart/menu";
	}
	@RequestMapping("chart/neighbor.hi")
	public String neighbor() {
		return "/chart/neighbor";
	}
	@RequestMapping("chart/control.hi")
	public ModelAndView chartMenu(HttpServletRequest request, HttpSession session){
		
		ModelAndView mav = new ModelAndView();
		//카테고리 불러오기(전체)
		Map<String, String> dto = new HashMap<>();
		dto.put("id", "1");
		dto.put("isAll", "true");
		List<CategoryDto> categoryList = categoryService.hi_selectCategory(dto);
		
		
		if(request.getParameter("name")!=null){
			String name = request.getParameter("name");
			String state = request.getParameter("state").equals("true")?"0":"1";
			
			CategoryDto dto2 = new CategoryDto();
			dto2.setId("1");
			dto2.setName(name);
			dto2.setState(state);
			
			if(categoryService.hi_insert(dto2)>0){System.out.println("::::::::::::::::::데이터입력성공");};
		}
				
		mav.setViewName("chart/control");
		mav.addObject("categoryList", categoryList);
		
		return mav;
	}
}
