package com.hifive.history.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hifive.history.model.*;
import com.hifive.history.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

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

	@Autowired
	private VisitService visitService;

	@Autowired
	private UserService userSvc;

	@Autowired
	private LoveService loveSvc;

	@Autowired
	private FollowService followService;
	@Autowired
	private BlogService blogSvc;
	
	@Autowired
	private BoxService boxSvc;
	
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
	public ModelAndView main(HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		UserDto userDto = session.getAttribute("user") == null? null : (UserDto)session.getAttribute("user");
		
		String ID = request.getParameter("id");
		String ct_seqString = request.getParameter("ct_seq");
		Integer ct_seq;
		
		int	   seq 	= request.getParameter("seq")==null ? 0 : Integer.parseInt(request.getParameter("seq"));
		HashMap<String,String> dto = new HashMap<>();
		
		if(userDto != null){		// 로그인정보 없으면 방문자수 못올림 
			dto.put("id", userDto.getId());
			dto.put("vid", ID);
			dto.put("sex", userDto.getSex());
			dto.put("area", userDto.getArea());
			dto.put("birth", userDto.getBirth());
			
			visitService.hi_upsert(dto);
		}else if(session.getAttribute("ip")!=null){
			dto.put("id", (String)session.getAttribute("ip"));
			dto.put("vid", ID);
			dto.put("sex", "0");
			dto.put("area", "경인");
			dto.put("birth", "17/04/05");
			
			visitService.hi_upsert(dto);
		}
		
		BlogDto blogdto = blogSvc.getMyBlog(ID);
		mav.addObject("blogdto",blogdto);
		
		// 최신 글 내용 보여주기
		PostDto postDto = new PostDto();
		postDto.setId(ID);
		
		if (ct_seqString == null)
			ct_seq = 0;
		else
			ct_seq = Integer.parseInt(ct_seqString);
		
		postDto.setSeq(seq);
		postDto.setCt_seq(ct_seq);
		PostDto DTO = (PostDto) postSvc.hi_detail(postDto);

		mav.addObject("DTO"   ,DTO);		
		
		if(DTO != null){
			// 해당글의 댓글 보여주기
			Map<String, Object> comment_con = new HashMap<String, Object>();
			String  co_PAGE_NUM = request.getParameter("co_PAGE_NUM")==null||request.getParameter("co_PAGE_NUM").equals("")?"1":request.getParameter("co_PAGE_NUM");         //댓글페이지NUM
			comment_con.put("POST_SEQ",DTO.getSeq());
			comment_con.put("PAGE_NUM",co_PAGE_NUM);
			
			ArrayList commentList = (ArrayList)commentSve.hi_selectList(comment_con);
			mav.addObject("commentList",commentList);
			
			
			// 아래 5개 목록 리스트 보여주기
			Map<String, Object> condition = new HashMap<String, Object>();
			String PAGE_NUM = request.getParameter("PAGE_NUM")==null||request.getParameter("PAGE_NUM").equals("")?"1":request.getParameter("PAGE_NUM");         //페이지NUM
			condition.put("ID", ID);
			condition.put("PAGE_NUM", PAGE_NUM);
			condition.put("ct_seq", ct_seq);
		
			List<Map<String, Object>> lists = postSvc.hi_selectList(condition);
			logger.debug("BlogControl.lists.toString() = "+lists.toString());
		
			mav.addObject("lists",lists);
			mav.addObject("PAGE_NUM"   ,PAGE_NUM);
			
			if(userDto != null){
			//글 공감 확인하기
				LoveDto loveDto = new LoveDto();
				loveDto.setId(userDto.getId());							// 로그인한사람 id
				loveDto.setPost_seq(DTO.getSeq());						// 공감 누를 글의 번호
				LoveDto loveCheck = (LoveDto) loveSvc.hi_detail(loveDto);
				mav.addObject("loveCheck",loveCheck);
			}
			
		}
		//카테고리 갯수 뿌리기
		List<HashMap<String, Object>> cateCount = categoryService.getCategoryCount(ID);
		mav.addObject("cateCount", cateCount);
		
		mav.setViewName("post/main");
		
		return mav;
	}

	//블로그 글 쓰기창 열기
	@RequestMapping("post/write.hi")
	public ModelAndView postWrite(HttpServletRequest request, HttpSession session) throws Exception{
		List<Map<String, Object>> themeCode = new ArrayList<Map<String, Object>>(); 	//Page코드 : 100 글 주제
		List<Map<String, Object>> reviewCode = new ArrayList<Map<String, Object>>(); 	//Page코드 : 130 댓글허용 여부
		List<Map<String, Object>> postViewCode = new ArrayList<Map<String, Object>>(); 	//Page코드 : 140 글 공개 여부
		
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
			
	}
	
	
	//블로그 글 쓰기(insert)
	@RequestMapping("post/writeInsert.hi")
	public String postwriteInsert(HttpServletRequest request, HttpSession session) throws Exception{
		//ModelAndView mav = new ModelAndView();
		
		//첨부 파일!!!
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
	    Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
	    MultipartFile multipartFile = null;
	    while(iterator.hasNext()){
	        multipartFile = multipartHttpServletRequest.getFile(iterator.next());
	        if(multipartFile.isEmpty() == false){
	            logger.debug("------------- file start -------------");
	            logger.debug("name : "+multipartFile.getName());
	            logger.debug("filename : "+multipartFile.getOriginalFilename());
	            logger.debug("size : "+multipartFile.getSize());
	            logger.debug("-------------- file end --------------\n");
	        }
	    }
	    
		//끄읕--첨부파일
		
		
		
		// view에서 넘어온값 받기
	    Map<String, Object> map = new HashMap<String, Object>();
	    
		int	   ct_seq 	= Integer.parseInt(request.getParameter("ct_seq"));
		String id		= request.getParameter("id");
		String field	= request.getParameter("field");   
		String title	= request.getParameter("title");   
		String content	= request.getParameter("content"); 
		String hashtag	= request.getParameter("tag"); 
		String state	= request.getParameter("state");   
		String co_state= request.getParameter("co_state");
		
		map.put("ct_seq", ct_seq);
		map.put("id", id);
		map.put("field", field);
		map.put("title", title);
		map.put("content", content);
		map.put("hashtag", hashtag);
		map.put("state", state);
		map.put("co_state", co_state);
		
		logger.debug("BlogControl.postWrite.map.toString() = "+map.toString());
		
		int flag = postSvc.hi_insert(map, request);
		if(flag > 0){
			return "redirect:/post/main.hi?ct_seq="+ct_seq+"&id="+id; 
		}else{
			// 입력 실패했을때 어떻게 해야할지 모르겠다
		}
		
		return null;
	}
	
	
	//블로그 글 수정
	@RequestMapping("post/update.hi")
	public String postUpdate(HttpServletRequest request) {
		// view에서 넘어온값 받기
		int	   seq 		= Integer.parseInt(request.getParameter("seq"));
		int	   ct_seq 	= Integer.parseInt(request.getParameter("ct_seq"));
		String id		= request.getParameter("id");
		String field	= request.getParameter("field");   
		String title	= request.getParameter("title");   
		String content	= request.getParameter("content"); 
		String hashtag	= request.getParameter("tag"); 
		String state	= request.getParameter("state");   
		String co_state= request.getParameter("co_state");
		
		PostDto postDto = new PostDto(seq,ct_seq,id,field,title,content,null,hashtag,state,co_state);
		logger.debug("BlogControl.postWrite.postDto.toString() = "+postDto.toString());
		
		int flag = postSvc.hi_update(postDto);
		if(flag > 0){
			return "redirect:/post/main.hi?ct_seq="+ct_seq+"&id="+id; 
		}else{
			// 실패했을때 어떻게 해야할지 모르겠다
		}
		
		return null;
	}
	
	//블로그 글 수정 내용 보이기
	@RequestMapping("post/updateDetail.hi")
	public ModelAndView postUpdateDetail(HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		List<Map<String, Object>> themeCode = new ArrayList<Map<String, Object>>(); 	//Page코드 : 100 글 주제
		List<Map<String, Object>> reviewCode = new ArrayList<Map<String, Object>>(); 	//Page코드 : 130 댓글허용 여부
		List<Map<String, Object>> postViewCode = new ArrayList<Map<String, Object>>(); 	//Page코드 : 140 글 공개 여부
		
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
		
		mav.addObject("categoryList", categoryList);
		mav.addObject("reviewCode", reviewCode);
		mav.addObject("postViewCode", postViewCode);
		mav.addObject("themeCode", themeCode);
		
		String ID 	= request.getParameter("id");
		int	   seq 	= Integer.parseInt(request.getParameter("seq"));
		
		// 선택 글 내용 보여주기
		PostDto postDto = new PostDto();
		postDto.setId(ID);
		postDto.setSeq(seq);
		PostDto DTO = (PostDto) postSvc.hi_detail(postDto);
		

		mav.addObject("DTO"   ,DTO);	
		mav.setViewName("post/update");
		System.out.println("넘어오는 데이타 뭐니? PostDto"+DTO.toString());
		return mav;
	}
	
	
	
	//블로그 글 삭제
	@RequestMapping("post/delete.hi")
	public String postDelete(HttpServletRequest request) {
		int	   seq 	= Integer.parseInt(request.getParameter("seq"));
		String id	= request.getParameter("id");
		
		int flag = postSvc.hi_delete(seq);
		
		if(flag > 0){
			return  "redirect:/post/main.hi?id="+id;
		}else{
			// 삭제 실패했을때 어떻게 해야할지 모르겠다
		}
		
		return null;
	}
	
	//왼쪽menu 카테고리
	@RequestMapping("post/menu.hi")
	public ModelAndView postMenu(HttpServletRequest request, HttpSession session) throws Exception{
	    ModelAndView mav = new ModelAndView();
	    String id = request.getParameter("id");
		Boolean follow = false;

	    Map<String, String> condition = new HashMap<>();
	    condition.put("id", id);
	    condition.put("isAll", "false");
	    List<CategoryDto> categoryList = categoryService.hi_selectCategory(condition);
	      
	    UserDto dto = new UserDto();
	    dto.setId(id);
	    UserDto userDto =  (UserDto) userSvc.hi_detail(dto);
	      
	    Map<String, Integer> visit = new HashMap<>();
	    int today = visitService.hi_getToday(id);
	    int total = visitService.hi_getTotal(id);
	      
	    visit.put("today", today);
	    visit.put("total", total);

	    UserDto loginuser = (UserDto)session.getAttribute("user");
	    if (loginuser != null) {
		    FollowDto followCon = new FollowDto();
		    followCon.setMy_id(loginuser.getId());
		    followCon.setYou_id(id);

		    if (followService.hi_detail(followCon) != null) {
			    follow = true;
		    }
	    }

	    mav.setViewName("post/menu");
	    mav.addObject("visit", visit);
	    mav.addObject("userDto", userDto);
	    mav.addObject("categoryList", categoryList);
		mav.addObject("follow", follow);

	    return mav;
	}
		
	
	// 댓글 등록 (ajax)
	@RequestMapping(value = "post/replyInsert.hi", method = RequestMethod.POST)
	@ResponseBody
	public String replyInsert(HttpServletRequest res, HttpSession session) {
		UserDto userDto = (UserDto) session.getAttribute("user");

		int POST_SEQ = Integer.parseInt(res.getParameter("POST_SEQ"));
		String ID = userDto.getId();
		String NAME = userDto.getName();
		String CONTENT = res.getParameter("CONTENT");
		String STATE = res.getParameter("STATE").equals("false") ? "0" : "1";

		/*
		 * int seq, int post_seq, String id, String name, String content, int
		 * parent, String state
		 */
		CommentDto commentDto = new CommentDto(0, POST_SEQ, ID, NAME, CONTENT, 0, STATE, null);
		int flag = commentSve.hi_insert(commentDto);

		JsonObject jsonObject = new JsonObject();
		if (flag > 0) {
			jsonObject = new JsonParser().parse("{\"msg\":\"true\"}").getAsJsonObject();
		} else {
			jsonObject = new JsonParser().parse("{\"msg\":\"false\"}").getAsJsonObject();
		}
		Gson gson = new Gson();

		return gson.toJson(jsonObject);
	}
	
	// 대댓글 등록 (ajax)
	@RequestMapping(value = "post/rereInsert.hi", method = RequestMethod.POST)
	@ResponseBody
	public String rereInsert(HttpServletRequest res, HttpSession session) {
		UserDto userDto = (UserDto) session.getAttribute("user");

		int POST_SEQ = Integer.parseInt(res.getParameter("POST_SEQ"));
		String ID = userDto.getId();
		String NAME = userDto.getName();
		String CONTENT = res.getParameter("CONTENT");
		int PARENT = Integer.parseInt(res.getParameter("PARENT"));
		String STATE = res.getParameter("STATE").equals("false") ? "0" : "1";

		/*
		 * int seq, int post_seq, String id, String name, String content, int
		 * parent, String state
		 */
		CommentDto commentDto = new CommentDto(0, POST_SEQ, ID, NAME, CONTENT, PARENT, STATE, null);
		int flag = commentSve.hi_insertRe(commentDto);

		JsonObject jsonObject = new JsonObject();
		if (flag > 0) {
			jsonObject = new JsonParser().parse("{\"msg\":\"true\"}").getAsJsonObject();
		} else {
			jsonObject = new JsonParser().parse("{\"msg\":\"false\"}").getAsJsonObject();
		}
		Gson gson = new Gson();

		return gson.toJson(jsonObject);
	}
	
	// 댓글 삭제 (ajax)
	@RequestMapping(value = "post/replyDelete.hi", method = RequestMethod.POST)
	@ResponseBody
	public String replyDelete(HttpServletRequest res) {

		int	   seq 		= res.getParameter("seq")==null ? 0 : Integer.parseInt(res.getParameter("seq"));
		
		int flag = commentSve.hi_delete(seq);

		JsonObject jsonObject = new JsonObject();
		if (flag > 0) {
			jsonObject = new JsonParser().parse("{\"msg\":\"true\"}").getAsJsonObject();
		} else {
			jsonObject = new JsonParser().parse("{\"msg\":\"false\"}").getAsJsonObject();
		}
		Gson gson = new Gson();

		return gson.toJson(jsonObject);
	}
	
	// 공감 등록 (ajax)
	@RequestMapping(value="post/loveInsert.hi",method=RequestMethod.POST)
	@ResponseBody
	public String loveInsert(HttpServletRequest res, HttpSession session) {
		UserDto userDto = (UserDto) session.getAttribute("user");
		
		int	   seq 		= res.getParameter("seq")==null ? 0 : Integer.parseInt(res.getParameter("seq"));
		String id  		= userDto.getId();
		String sex  	= userDto.getSex();
		String area		= userDto.getArea();
		String birth 	= userDto.getBirth();
		
		LoveDto loveDto = new LoveDto(seq,id,null,sex,area,birth);
		
		int flag = loveSvc.hi_insert(loveDto);
		
		JsonObject jsonObject = new JsonObject();
	      if(flag > 0){
	    	  jsonObject = new JsonParser().parse("{\"msg\":\"intrue\"}").getAsJsonObject();
	       }else{
	    	  jsonObject = new JsonParser().parse("{\"msg\":\"infalse\"}").getAsJsonObject();
	       }
		Gson gson = new Gson();
		
		return gson.toJson(jsonObject);
	}
	
	// 공감 취소 (ajax)
	@RequestMapping(value="post/loveDelete.hi",method=RequestMethod.POST)
	@ResponseBody
	public String loveDelete(HttpServletRequest res) {
		
		int	   seq 		= res.getParameter("seq")==null ? 0 : Integer.parseInt(res.getParameter("seq"));
		
		int flag = loveSvc.hi_delete(seq);
		
		JsonObject jsonObject = new JsonObject();
	      if(flag > 0){
	    	  jsonObject = new JsonParser().parse("{\"msg\":\"deltrue\"}").getAsJsonObject();
	       }else{
	    	  jsonObject = new JsonParser().parse("{\"msg\":\"delfalse\"}").getAsJsonObject();
	       }
		Gson gson = new Gson();
		
		return gson.toJson(jsonObject);
	}

	@RequestMapping(value="followInsert.hi")
	@ResponseBody
	public String followInsert(HttpServletRequest request, HttpSession session) {
		String my_id = request.getParameter("my_id");
		String you_id = request.getParameter("you_id");
		String command = request.getParameter("command");

		UserDto user = (UserDto)session.getAttribute("user");


		FollowDto followDto = new FollowDto();
		followDto.setMy_id(my_id);
		followDto.setYou_id(you_id);
		followDto.setArea(user.getArea());
		followDto.setBirth(user.getBirth());
		followDto.setSex(user.getSex());

		if (command.equals("insert"))
			followDto.setState("0");
		else
			followDto.setState("1");

		if (followService.hi_insert(followDto) == 1)
			return "success";
		else
			return "fail";
	}
}

