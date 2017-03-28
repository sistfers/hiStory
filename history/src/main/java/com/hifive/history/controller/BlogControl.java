package com.hifive.history.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hifive.history.model.CategoryDto;
import com.hifive.history.model.PostDto;
import com.hifive.history.service.CategoryService;
import com.hifive.history.service.PostService;

@Controller
public class BlogControl {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private PostService postSvc;
	
	private PostDto postDto;
	
	private	int		CT_SEQ;
	private	String	ID;
	private	String	FIELD;
	private	String	TITLE;
	private	String	CONTENT;
	private	String	WDATE;
	private	String	HASHTAG;
	private	String	STATE;
	private String	CO_STATE;	
	
	
	@RequestMapping(value="post/ckeditorImageUpload.hi", method=RequestMethod.POST)
	public void ckeditorImageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) throws     Exception {
			
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset-utf-8");
		
		System.out.println("getContextPath() : " + request.getContextPath());
		System.out.println("getRealPath(\"/\") : " + request.getSession().getServletContext().getRealPath("/"));
		
		try {
			postSvc.ckeditorImageUpload(request, response, upload);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	//블로그 메인(글 보여주기)
	@RequestMapping("post/main.hi")
	public ModelAndView main(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Map<String, Object> condition = new HashMap<String, Object>();
		String ID = "1";
		
		// 최신 글 내용 보여주기
		postDto = new PostDto(0,0,"1",null,null,null,null,null,null,null);
		PostDto DTO = (PostDto) postSvc.hi_detail(postDto);
		mav.addObject("DTO"   ,DTO);		
		
		
		String PAGE_NUM = request.getParameter("PAGE_NUM")==null||request.getParameter("PAGE_NUM").equals("")?"1":request.getParameter("PAGE_NUM");         //페이지NUM
		
		condition.put("ID", ID);
		condition.put("PAGE_NUM", PAGE_NUM);
		
		// 아래 5개 목록 리스트 보여주기
		List<Map<String, Object>> lists = postSvc.hi_selectList(condition);
		logger.debug("BlogControl.lists.toString() = "+lists.toString());
		
		mav.addObject("lists",lists);
		mav.addObject("PAGE_NUM"   ,PAGE_NUM);
		mav.setViewName("post/main");
		
		return mav;
	}

	//블로그 글 쓰기
	@RequestMapping("post/write.hi")
	public String postWrite() {
		// view에서 넘어온값 받기
//		CT_SEQ 	= Integer.parseInt(request.getParameter("ct_seq"));
//		ID		= request.getParameter("ct_seq");      
//		FIELD	= request.getParameter("ct_seq");   
//		TITLE	= request.getParameter("ct_seq");   
//		CONTENT	= request.getParameter("ct_seq"); 
//		HASHTAG	= request.getParameter("ct_seq"); 
//		STATE	= request.getParameter("ct_seq");   
//		CO_STATE= request.getParameter("ct_seq");
//		postDto = new PostDto(0,CT_SEQ,ID,FIELD,TITLE,CONTENT,null,HASHTAG,STATE,CO_STATE);
		
		// 아래는 임시
//		int seq, int ct_seq, String id, String field, String title, String content, String wdate,
//		String hashtag, String state, String co_state
//		postDto = new PostDto(0,0,"1","field","title","content",null,"hashtag","0","0");
//		
//		logger.debug("BlogControl.postDto.toString() = "+postDto.toString());
//		
//		postSvc.hi_insert(postDto);
		return "post/write";
	}
	
	//블로그 글 수정
	@RequestMapping("post/update.hi")
	public String postUpdate() {
		return "post/update";
	}
	//블로그 카테고리
	@RequestMapping("post/menu.hi")
	public ModelAndView postMenu(HttpServletRequest request, HttpSession session){
		
		ModelAndView mav = new ModelAndView();
		String id = (String)session.getAttribute("id");
		System.out.println(id);
		Map<String, String> dto = new HashMap<>();
		dto.put("id", "1");
		
		List<CategoryDto> categoryList = categoryService.hi_selectCategory(dto);
		mav.setViewName("post/menu");
		mav.addObject("categoryList", categoryService.hi_selectCategory(dto));
		
		return mav;
	}
	
	
	
}

