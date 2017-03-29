package com.hifive.history.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.hifive.history.model.CategoryDto;
import com.hifive.history.model.CommentDto;
import com.hifive.history.model.PostDto;
import com.hifive.history.model.UserDto;
import com.hifive.history.service.CategoryService;
import com.hifive.history.service.CodeDService;
import com.hifive.history.service.CommentService;
import com.hifive.history.service.PostService;

@Controller
public class BlogControl {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private PostService postSvc;
	@Autowired
	private CodeDService codeDSvc;
	@Autowired
	private CommentService commentSve;
	
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
		
		
		String ID = "1";
		
		// 최신 글 내용 보여주기
		postDto = new PostDto(0,2,"1",null,null,null,null,null,null,null);
		PostDto DTO = (PostDto) postSvc.hi_detail(postDto);
		mav.addObject("DTO"   ,DTO);		
		
		// 해당글의 댓글 보여주기
		Map<String, Object> comment_con = new HashMap<String, Object>();
		String  co_PAGE_NUM = request.getParameter("co_PAGE_NUM")==null||request.getParameter("co_PAGE_NUM").equals("")?"1":request.getParameter("co_PAGE_NUM");         //페이지NUM
		comment_con.put("POST_SEQ",DTO.getSeq());
		comment_con.put("PAGE_NUM",co_PAGE_NUM);
		
		ArrayList commentList = (ArrayList)commentSve.hi_selectList(comment_con);
		mav.addObject("commentList",commentList);
		
		
		// 아래 5개 목록 리스트 보여주기
		Map<String, Object> condition = new HashMap<String, Object>();
		String PAGE_NUM = request.getParameter("PAGE_NUM")==null||request.getParameter("PAGE_NUM").equals("")?"1":request.getParameter("PAGE_NUM");         //페이지NUM
		
		condition.put("ID", ID);
		condition.put("PAGE_NUM", PAGE_NUM);
		
		List<Map<String, Object>> lists = postSvc.hi_selectList(condition);
		logger.debug("BlogControl.lists.toString() = "+lists.toString());
		
		mav.addObject("lists",lists);
		mav.addObject("PAGE_NUM"   ,PAGE_NUM);
		mav.setViewName("post/main");
		
		return mav;
	}

	//블로그 글 쓰기
	@RequestMapping("post/write.hi")
	public ModelAndView postWrite(HttpSession session) throws Exception{
		List<Map<String, Object>> themeCode = new ArrayList<Map<String, Object>>(); //Page코드 : 100 글 주제
		List<Map<String, Object>> reviewCode = new ArrayList<Map<String, Object>>(); //Page코드 : 130 댓글허용 여부
		List<Map<String, Object>> postViewCode = new ArrayList<Map<String, Object>>(); //Page코드 : 140 글 공개 여부
		
		ModelAndView mav = new ModelAndView();
		Map<String, String> dto = new HashMap<String, String>();
		dto.put("isAll", "false");
		dto.put("id", ((UserDto)session.getAttribute("user")).getId());

		Map<String, Object> codeMap = new HashMap<String, Object>();
		List<String> codeList = new ArrayList<String>();
		codeList.add("100");
		codeList.add("130");
		codeList.add("140");
		codeMap.put("code_list", codeList);
		
		List<CategoryDto> categoryList = (List<CategoryDto>)categoryService.hi_selectCategory(dto);
		List<Map<String, Object>> codes = (List<Map<String, Object>>)codeDSvc.hi_selectList(codeMap);
		
		for(int i=0; i<codes.size(); ++i){
			Map<String, Object> codeData = (Map<String, Object>)codes.get(i);
			
			if((Integer)(codeData.get("CD_ID")) == 130) reviewCode.add(codeData);
			else if((Integer)(codeData.get("CD_ID")) == 140) postViewCode.add(codeData);
			else if((Integer)(codeData.get("CD_ID")) == 100) themeCode.add(codeData);
		}
		
		mav.setViewName("post/write");
		mav.addObject("categoryList", categoryList);
		mav.addObject("reviewCode", reviewCode);
		mav.addObject("postViewCode", postViewCode);
		mav.addObject("themeCode", themeCode);
		
		return mav;
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
			
	}
	
	//블로그 글 수정
	@RequestMapping("post/update.hi")
	public String postUpdate() {
		return "post/update";
	}
	//블로그 카테고리
	@RequestMapping("post/menu.hi")
	public ModelAndView postMenu(HttpServletRequest request, HttpSession session) throws Exception{
		session.setAttribute("id", "1");
	      ModelAndView mav = new ModelAndView();
	      String id = (String)session.getAttribute("id");
	      System.out.println(id);
	      Map<String, String> dto = new HashMap<>();
	      dto.put("id", "1");
	      dto.put("isAll", "false");
	      
	      List<CategoryDto> categoryList = categoryService.hi_selectCategory(dto);
	      mav.setViewName("post/menu");
	      mav.addObject("categoryList", categoryList);
	      
	      return mav;
	}
		
	
	// 댓글 등록 (ajax)
	@RequestMapping(value="post/replyInsert.hi",method=RequestMethod.POST)
	@ResponseBody
	public String replyInsert(HttpServletRequest res, HttpSession session) {
		UserDto userDto = (UserDto) session.getAttribute("user");
		
		int    POST_SEQ = Integer.parseInt(res.getParameter("POST_SEQ"));
		String ID  		= userDto.getId();
		String NAME  	= userDto.getName();
		String CONTENT 	= res.getParameter("CONTENT");
		String STATE 	= res.getParameter("STATE").equals("false") ? "0" : "1";
		
		/*int seq, int post_seq, String id, String name, String content, int parent, String state*/
		CommentDto commentDto = new CommentDto(0,POST_SEQ,ID,NAME,CONTENT,0,STATE,null);
		int flag = commentSve.hi_insert(commentDto);
		
		JsonObject jsonObject = new JsonObject();
	      if(flag > 0){
	    	  jsonObject = new JsonParser().parse("{\"msg\":\"true\"}").getAsJsonObject();
	       }else{
	    	   jsonObject = new JsonParser().parse("{\"msg\":\"false\"}").getAsJsonObject();
	       }
		Gson gson = new Gson();
		
		return gson.toJson(jsonObject);
	}
	
	
	
}

