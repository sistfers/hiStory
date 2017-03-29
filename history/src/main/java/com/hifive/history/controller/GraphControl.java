package com.hifive.history.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hifive.history.model.BlogDto;
import com.hifive.history.model.CategoryDto;
import com.hifive.history.model.PostDto;
import com.hifive.history.model.iDto;
import com.hifive.history.service.BlogService;
import com.hifive.history.service.CategoryService;
import com.hifive.history.service.PostService;

/**
 * Created by Admin on 2017-03-24.
 */
@Controller
public class GraphControl {
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private BlogService blogService;
	@Autowired
	PostService postService;
	
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
	@RequestMapping("chart/love.hi")
	public ModelAndView love(HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		Date date = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("YY/MM/dd");
		String startdate = "17/03/01";
		String enddate = sd.format(date);
		
		// 전체조회
		HashMap<String,String> map = new HashMap<>();
		map.put("ID", "1");
		map.put("START_DAY", startdate);
		map.put("END_DAY", enddate);
		
		List<HashMap<String, Object>> loveRank = postService.hi_selectLoveRank(map);
		mav.setViewName("chart/love");
		mav.addObject("loveRank", loveRank);
		
		// 기간조회
		HashMap<String,String> map2 = new HashMap<>();
		
		if(request.getParameter("startdate")!=null){
			startdate = request.getParameter("startdate");
			enddate = request.getParameter("enddate");			
		}
		map2.put("ID", "1");
		map2.put("START_DAY", startdate );
		map2.put("END_DAY", enddate );
		List<HashMap<String, Object>> loveSelectRank = postService.hi_selectLoveRank(map2);
				
		mav.addObject("loveSelectRank", loveSelectRank);
		
		return mav;
	}
	@RequestMapping("chart/comment.hi")
	public ModelAndView comment() {
		ModelAndView mav = new ModelAndView();
		List<HashMap<String, Object>> postList = postService.hi_selectCommentRank("1");
		mav.setViewName("chart/comment");
		mav.addObject("postList", postList);
		return mav;
	}
	@RequestMapping("chart/control.hi")
	public ModelAndView chartMenu(HttpServletRequest request, HttpSession session){
		
		ModelAndView mav = new ModelAndView();
		//카테고리 불러오기(전체)
		Map<String, String> dto = new HashMap<>();
		dto.put("id", "1");
		dto.put("isAll", "true");
		List<CategoryDto> categoryBefore = categoryService.hi_selectCategory(dto);
		boolean b = true;
		if(request.getParameter("name")!=null){
			String name = request.getParameter("name");
			String state = request.getParameter("state").equals("true")?"0":"1";
			for(int i = 0 ; i < categoryBefore.size();++i){
				if(categoryBefore.get(i).getName().equals(name)){
					b = false;
					break;
				}
			}
			if(b){
				CategoryDto dto2 = new CategoryDto();
				dto2.setId("1");
				dto2.setName(name);
				dto2.setState(state);
				
				if(categoryService.hi_insert(dto2)>0){System.out.println("::::::::::::::::::데이터입력성공");};
			}			
		}
		//블로그 타이틀 바꾸기
		if(request.getParameter("title")!=null){
			String title = request.getParameter("title");
			String theme = request.getParameter("theme");
			BlogDto bdto = new BlogDto("Q328", title, theme);
			if(blogService.hi_update(bdto)>0){System.out.println("::::::::::::::::::블로그테마 변경 성공");};
		}
		//카테고리 목록 뿌리기
		List<CategoryDto> categoryList = categoryService.hi_selectCategory(dto);		
		mav.setViewName("chart/control");
		mav.addObject("categoryList", categoryList);
		
		return mav;
	}
}
