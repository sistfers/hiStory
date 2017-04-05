package com.hifive.history.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.hifive.history.model.BoxDto;
import com.hifive.history.model.iDto;
import com.hifive.history.repository.BoxDao;
import com.hifive.history.repository.PostDao;
import com.hifive.history.util.FileUtils;

@Service
public class PostService implements iService {
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private PostDao postDao;
	
	@Autowired
	private BoxDao boxDao;
	
	/*@Resource(name="fileUtils")
    private FileUtils fileUtils;*/
	
	static String FILE_URL = "";	//저장할 경로
	static final String SAVE_URL = "../resources/uploadImages";	// 불러올 경로
	
	public PostService() {
	}
	
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

	@Override
	public int hi_insert(iDto dto) {
		logger.debug("PostService.dto.toString() = "+dto.toString());
		return postDao.hi_insert(dto);
	}
	
	public int hi_insertMap(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int flag = postDao.hi_insertMap(map);
		
		/*List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(map, request);
        
		hi_insertList(list);	//첨부파일 인설트 (트랜잭션 적용)
*/		
		return flag;
	}

	@Override
	public int hi_update(iDto dto) {
		logger.debug("PostService.dto.toString() = "+dto.toString());
		return postDao.hi_update(dto);
	}

	@Override
	public iDto hi_detail(iDto dto) {
		logger.debug("PostService.dto.toString() = "+dto.toString());
		return postDao.hi_detail(dto);
	}

	@Override
	public int hi_delete(int cnt) {
		logger.debug("PostService.cnt = "+cnt);
		return postDao.hi_delete(cnt);
	}

	@Override
	public List<Map<String, Object>> hi_selectList(Map<String, Object> condition) throws Exception {
		logger.debug("PostService.condition.toString() = "+condition.toString());
		return postDao.hi_selectList(condition);
	}
	
	public List<Map<String, Object>> hi_bloggerRankList() {
		return postDao.hi_bloggerRankList();
	}
	public List<HashMap<String, Object>> hi_selectCommentRank(String id){
		return postDao.hi_selectCommentRank(id);
	}
	public List<HashMap<String, Object>> hi_selectTodayCommentRank(HashMap<String, String> map){
		return postDao.hi_selectTodayCommentRank(map);
	}
	public List<HashMap<String, Object>> hi_selectLoveRank(HashMap<String, String> map) throws Exception{
		return postDao.hi_selectLoveRank(map);
	}
	
	public List<Map<String, Object>> hi_selectFollowerList(Map<String, Object> condition) throws Exception {
		logger.debug("dto.toString() = "+condition.toString());
		return postDao.hi_selectFollowerList(condition);
	}
	
	public List<Map<String, Object>> hi_selectThemeList(Map<String, Object> condition) throws Exception {
		logger.debug("dto.toString() = "+condition.toString());
		return postDao.hi_selectThemeList(condition);
	}
	
	public List<Map<String, Object>> hi_selectSearchList(Map<String, Object> condition) throws Exception {
		logger.debug("dto.toString() = "+condition.toString());
		return postDao.hi_selectSearchList(condition);
	}
	
	/*@Transactional
	public int hi_insertList(List<Map<String, Object>> boxList) throws SQLException{
		int flagCnt = 0;
		for(Map<String, Object> map:boxList){
			int flag = boxDao.hi_insertMap(map);
			flagCnt += flag;
		}
		return flagCnt;
	}*/
	
	public List<Map<String, Object>> getLovePost(Map<String, String> dto)throws SQLException{
	      return postDao.getLovePost(dto);
	}
}
