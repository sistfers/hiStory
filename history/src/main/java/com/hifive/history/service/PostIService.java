package com.hifive.history.service;

import com.hifive.history.repository.PostDao;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

/**
 * Created by Admin on 2017-03-24.
 */
@Service
public class PostIService implements iService {

	@Autowired
	private PostDao postDao;
	
	static String FILE_URL = "";	//저장할 경로
	static final String SAVE_URL = "http://localhost:8190/resources/uploadImages";	// 불러올 경로
	
	@SuppressWarnings("resource")
	public void ckeditorImageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile file) throws Exception {
		FILE_URL = request.getSession().getServletContext().getRealPath("/")+"resources\\uploadImages\\";
		System.out.println("getContextPath() : " + request.getContextPath());
		System.out.println("getRealPath(\"/\") : " + request.getSession().getServletContext().getRealPath("/"));
		System.out.println("catalina home : " + FILE_URL);
		OutputStream out = null;
		PrintWriter printWriter = null;	
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String fileName = file.getOriginalFilename();
		byte[] bytes = file.getBytes();
		String uploadPath = FILE_URL + fileName; //저장 경로
		
		System.out.println(uploadPath);
		out = new FileOutputStream(new File(uploadPath));
		out.write(bytes);
		String callback = request.getParameter("CKEditorFuncNum");
		
		printWriter = response.getWriter();
		String fileUrl = SAVE_URL + "/" +fileName; //url 경로
		
		printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
	               + callback
	               + ",'"
	               + fileUrl
	               + "','이미지를 업로드 하였습니다.'"
	               + ")</script>");
	       printWriter.flush();
	       
	       
	}
}
