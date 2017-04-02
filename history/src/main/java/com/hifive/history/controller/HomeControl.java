package com.hifive.history.controller;


import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.hifive.history.model.UserDto;
import com.hifive.history.portal.Channel;
import com.hifive.history.portal.Item;
import com.hifive.history.portal.Rss;
import com.hifive.history.service.CodeDService;
import com.hifive.history.service.PostService;
import com.hifive.history.service.SearchService;
import com.hifive.history.service.UserService;

/**
 * Created by Admin on 2017-03-23.
 */
@Controller
@SessionAttributes("user")
public class HomeControl {
	Logger loger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	SearchService searchSvc;

	@Autowired
	UserService userService;
	
	@Autowired
	PostService postSvc;
	
	@Autowired
	CodeDService codeDSvc;
	
	@RequestMapping(value = "main/index.hi")
	public ModelAndView home(HttpServletRequest request, HttpSession session) throws Exception{
		List<Map<String, Object>> themeCode = new ArrayList<Map<String, Object>>(); 	//Page코드 : 100 글 주제
		if (session.getAttribute("user") != null) {
			UserDto dto = (UserDto) session.getAttribute("user");
			System.out.println(dto.toString());
		}
		Map<String, Object> condition = new HashMap<String, Object>(); 
		Map<String, Object> codeMap = new HashMap<String, Object>();
		List<String> codeList = new ArrayList<String>();
		codeList.add("100");
		codeMap.put("code_list", codeList);
		
		List<Map<String, Object>> codes = (List<Map<String, Object>>)codeDSvc.hi_selectList(codeMap); //주제 코드 가져오기
		for(int i=0; i<codes.size(); ++i){
			Map<String, Object> codeData = (Map<String, Object>)codes.get(i);
			if((Integer)(codeData.get("CD_ID")) == 100) themeCode.add(codeData);
		}
		for(int i=0; i<themeCode.size(); ++i){
			condition.put("THEME"+(i+1),themeCode.get(i).get("CD_D_NM"));
		}
		ModelAndView mav = new ModelAndView();
		List<Map<String, Object>> searchRank = searchSvc.hi_selectRankList();
		List<Map<String, Object>> themeList = postSvc.hi_selectThemeList(condition);
		
		mav.setViewName("/main/index");
		mav.addObject("searchRank", searchRank);
		mav.addObject("themeList", themeList);
		mav.addObject("themeCode", themeCode);
		return mav;
	}

	@RequestMapping(value = "main/login.hi", method = RequestMethod.POST)
	public ModelAndView login(HttpServletRequest request, HttpSession session, Model model) {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("/main/login");

		// 로그인 시
		if (request.getParameter("do_login") != null) {
			String id = (String)request.getParameter("id");
			String password = (String)request.getParameter("password");
			UserDto loginDto = new UserDto();
			loginDto.setId(id);
			loginDto.setPassword(password);

			UserDto userDto = (UserDto)userService.hi_login(loginDto);
			if (userDto == null) {
				mav.addObject("fail", "아이디 혹은 패스워드를 확인해 주세요.");
				return mav;
			}
			model.addAttribute("user", userDto);
			mav.setViewName("redirect:/");
			return mav;
		}
		return mav;
	}

	@RequestMapping("header.hi")
	public String header() {
		return "/main/header";
	}

	@RequestMapping("main/logout.hi")
	public String logout(ModelMap modelMap, HttpSession session) {
		modelMap.remove("user");
		session.removeAttribute("user");
		return "redirect:/";
	}
	
	@RequestMapping(value="main/do_search.hi",method=RequestMethod.POST)
	public ModelAndView do_search(HttpServletRequest res)throws Exception{
		ModelAndView mav = new ModelAndView();
		
		String apiSearch_word = res.getParameter("search_word").trim();
		String search_word = "%"+apiSearch_word+"%";
		String PAGE_SIZE 	= "10";	//페이지사이즈
		String PAGE_NUM		= "1";	//페이지NUM
		
		PAGE_NUM		= (res.getParameter("PAGE_NUM")==null || res.getParameter("PAGE_NUM").equals("")) ? "1" : res.getParameter("PAGE_NUM");	//페이지NUM
		loger.debug("들어왔다!!!!!!! 단어는 ::"+ search_word);
		Map<String, Object> condition = new HashMap();
		
		condition.put("PAGE_SIZE", PAGE_SIZE);
		condition.put("PAGE_NUM", PAGE_NUM);
		condition.put("SEARCH_WORD", search_word);
		condition.put("SEARCH_TAG","#"+apiSearch_word+"#");
		List<Map<String, Object>> searchList = postSvc.hi_selectSearchList(condition);
		
		for(int i=0; i<searchList.size(); ++i){
			loger.debug(i+"번째 blog_title" + searchList.get(i).get("blog_title"));
		}
		
		mav.setViewName("/main/home_search");
		mav.addObject("searchList", searchList);
		mav.addObject("PAGE_NUM"  , PAGE_NUM  );
		mav.addObject("search_word"  , apiSearch_word);
		mav.addObject("blogItem", getNaverBlog(apiSearch_word));
		return mav;
	}
	
	private List<Item> getNaverBlog(String search_word)
	{
		String clientId = "O0vtAeL1SFMdVcoY_DVQ";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "hN2z81uZ_T";//애플리케이션 클라이언트 시크릿값";
        
        List<Item> items=null;
        try{
        	  String text = URLEncoder.encode(search_word, "UTF-8");
              
              String apiURL = "https://openapi.naver.com/v1/search/blog.xml?display=20&query="+ text; // xml 결과
              URL url = new URL(apiURL);
              HttpURLConnection con = (HttpURLConnection)url.openConnection();
              con.setRequestMethod("GET");
              con.setRequestProperty("X-Naver-Client-Id", clientId);
              con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
              int responseCode = con.getResponseCode();
              
			  JAXBContext jc=JAXBContext.newInstance(Rss.class); 
			  Unmarshaller um=jc.createUnmarshaller();
			  Rss rss =(Rss)um.unmarshal( con.getInputStream());
			
			  Channel channel = (Channel)rss.getChannel();
			  items=(List<Item>) channel.getItem();
			  for(Item item:items)
			  {
				  loger.debug("::::"+item.getTitle());
				  loger.debug("::::"+item.getPostdate());
				  loger.debug("::::"+item.getBloggername());
			  }
        }catch(Exception e){
        	
        }		
        return items;
        
	}
}
