package com.hifive.history.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.hifive.history.model.PostDto;
import com.hifive.history.service.PostService;

@Controller
public class BlogControl {
	Logger loger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private PostService postSvc;
	
	@Autowired
	private PostDto postDto;
	
	
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
	public String main() {
		
		
		
		//postSvc.hi_selectList(condition);
		return "/post/main";
	}

	//블로그 글 쓰기
	@RequestMapping("post/write.hi")
	public String postWrite(HttpServletRequest request) {
		// view에서 넘어온값 받기
		
		// 아래는 임시
//		int seq, int ct_seq, String id, String field, String title, String content, String wdate,
//		String hashtag, String state, String co_state
		postDto = new PostDto(0,0,"1","field","title","content",null,"hashtag","0","0");
		
		postSvc.hi_insert(postDto);
		return "/post/write";
	}
	
	
}
