package com.hifive.history.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.google.gson.Gson;
import com.hifive.history.model.MessageDto;
import com.hifive.history.model.UserDto;
import com.hifive.history.service.MessageService;

/**
 * Created by Admin on 2017-03-24.
 */
@Controller
public class MessageControl {
	
	Logger loger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private MessageService messageService; 
	
	
	@RequestMapping(value="message/filtered.hi", method=RequestMethod.POST,
			produces = "application/json; charset=utf8")
	public @ResponseBody String do_filtered(HttpServletRequest res) {
		
		loger.debug("----------------------------------------------------------");
		loger.debug("<<S..<<T..<<A..<<R..<<T..<<.. REQUEST: message/filtered.hi");	
		
		
		String id 	 = res.getParameter("id");
		String words = res.getParameter("words");
		String condi = res.getParameter("condi");
		
		Map<String, Object> search_info = new HashMap<String, Object>();			
		
		search_info.put("id", id);
		search_info.put("words", words);
		search_info.put("condi", condi);
		search_info.put("PAGE_NUM", 1);
		loger.debug("[[[id	   ]]] " + id);
		loger.debug("[[[words  ]]] " + words);
		loger.debug("[[[condi  ]]] " + condi);
//		loger.debug("[[[PAGE_NUM  ]]] " + PAGE_NUM);
		
		
		List<Map<String, Object>> filteredList = messageService.hi_select_filtered(search_info);
		
		Gson gson = new Gson();
		
		
		loger.debug("<<E..<<N..<<D..<<.. REQUEST: message/filtered.hi");
		loger.debug("----------------------------------------------------------");
		
		return gson.toJson(filteredList);
	}	
	
	@RequestMapping("message/writeForm.hi")
	public ModelAndView do_write_ready(HttpServletRequest res) {
		
		loger.debug("----------------------------------------------------------");
		loger.debug("<<S..<<T..<<A..<<R..<<T..<<.. REQUEST: message/writeForm.hi");	
		
		
		ModelAndView mav = new ModelAndView();
		if(res.getParameter("list") != null) {
			String list = res.getParameter("list");
			loger.debug("답장 보낼 대상 -> "+ list);
			
			String values[] = list.split(",");			
			
			String ids = "";
//			Map<String, String> ids = new HashMap<String, String>();
			for(int i = 0; i < values.length; i++) {
				int startIdx = values[i].indexOf('(');
				loger.debug("values list -> "+ values[i].substring(0, startIdx));
				ids = ids + values[i].substring(0, startIdx) + ",";
//				ids.put(i + "", values[i].substring(0, startIdx));
				loger.debug("ids list -> " + ids);
			}
			
//			String TAKEID =ids;
			ids = ids.substring(0, ids.lastIndexOf(","));
			loger.debug("TAKEID -> " + ids);
			
			mav.setViewName("/message/writeForm");
			mav.addObject("TAKEID", ids);	
			
		} else {
//			String SENDID ="";
			String TAKEID ="";
			String NAME	  ="";
			
//			SENDID = res.getParameter("SENDID");
			TAKEID = res.getParameter("TAKEID");	
			NAME   = res.getParameter("NAME");
			
			mav.setViewName("/message/writeForm");
//			mav.addObject("SENDID", SENDID);
			mav.addObject("TAKEID", TAKEID);
			mav.addObject("NAME", NAME);
		}
		
		
		loger.debug("<<E..<<N..<<D..<<.. REQUEST: message/writeForm.hi");
		loger.debug("----------------------------------------------------------");

		return mav;
	}
	
	@RequestMapping("message/write.hi")
	public ModelAndView do_write(HttpServletRequest res) {
		
		loger.debug("----------------------------------------------------------");
		loger.debug("<<S..<<T..<<A..<<R..<<T..<<.. REQUEST: message/write.hi");
		
		
		String SENDID ="";
		String TAKEID ="";
		String note   ="";
		
		SENDID = res.getParameter("SEND_ID");
		TAKEID	 = res.getParameter("TAKE_ID");		
		note = res.getParameter("NOTE");
		loger.debug("SENDID -> " + SENDID);
		loger.debug("TAKEID -> " + TAKEID);
		loger.debug("note   -> " + note);
		
		
		/*
		private	int		seq;
		private	String	send_id;
		private	String	take_id;
		private String  contents;
		private	String	wdate;
		private	String	rdate;
		private	String	state;
		private String  nick;	*/
		
		ModelAndView mav = new ModelAndView();
		if(TAKEID.matches(".*,*.")) {	
			loger.debug("전체  쪽지");
			String[] arrIdx = TAKEID.split(",");
			
			for (int i = 0; i < arrIdx.length; i++) {
				MessageDto dto = new MessageDto();
				dto.setSeq(0);
				dto.setSend_id(SENDID);
				dto.setTake_id(arrIdx[i]);
				dto.setContents(note);
				dto.setWdate("");
				dto.setRdate("");
				dto.setState("");
				dto.setname("");
				
				int result = messageService.hi_insert(dto);
				
				if(result == 1) {
					mav.setView(new RedirectView(("send.hi")));
				}	
			}			
		} else {
			loger.debug("단일  쪽지");
			
			MessageDto dto = new MessageDto();
			dto.setSeq(0);
			dto.setSend_id(SENDID);
			dto.setTake_id(TAKEID);
			dto.setContents(note);
			dto.setWdate("");
			dto.setRdate("");
			dto.setState("");
			dto.setname("");
			
			int result = messageService.hi_insert(dto);
			
			if(result == 1) {
				mav.setView(new RedirectView(("send.hi")));
			}	
		}						
		
		
		loger.debug("<<E..<<N..<<D..<<.. REQUEST: message/write.hi");
		loger.debug("----------------------------------------------------------");
		
		
		return mav;
	}
	
	@RequestMapping("message/read.hi")
	public ModelAndView do_read(
			@RequestParam(value = "note", required=true) int seq) {
	
		loger.debug("----------------------------------------------------------");
		loger.debug("<<S..<<T..<<A..<<R..<<T..<<.. REQUEST: message/read.hi");	
		
		
		MessageDto dto = new MessageDto();
		dto.setSeq(seq);
		dto.setSend_id("");
		dto.setTake_id("");
		dto.setContents("");
		dto.setWdate("");
		dto.setRdate("");
		dto.setState("");
		dto.setname("");
		
		MessageDto note = new MessageDto();
		note = (MessageDto) messageService.hi_detail(dto);
		
		if(note.getState().equals("0")) {
			messageService.hi_detail_state(note.getSeq());
			
		} else {
			
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/message/read");
		mav.addObject("note", note);		
		
		
		loger.debug("<<E..<<N..<<D..<<.. REQUEST: message/read.hi");
		loger.debug("----------------------------------------------------------");
		
		return mav;
	}
	
	@RequestMapping("message/delete.hi")
	public ModelAndView do_delete(
			@RequestParam(value = "idx", required=true) 
						String paramMap,
			@RequestParam(value = "to", required=true) 
			String to) {
		
		loger.debug("----------------------------------------------------------");
		loger.debug("<<S..<<T..<<A..<<R..<<T..<<.. REQUEST: message/delete.hi");	
		
		
		loger.debug("paramMap -> "+paramMap.toString());
		String[] arrIdx = paramMap.split(",");
		for (int i = 0; i < arrIdx.length; i++) {
			int result = messageService.hi_delete(Integer.parseInt(arrIdx[i]));
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setView(new RedirectView((to+".hi")));
		
		
		loger.debug("<<E..<<N..<<D..<<.. REQUEST: message/delete.hi");
		loger.debug("----------------------------------------------------------");
		
		return mav;
	}
	
	@RequestMapping("message/reply.hi")
	public ModelAndView do_reply(
			@RequestParam(value = "idx", required=true) 
						String paramMap,
			@RequestParam(value = "to", required=true) 
			String to) {
		
		loger.debug("----------------------------------------------------------");
		loger.debug("<<S..<<T..<<A..<<R..<<T..<<.. REQUEST: message/reply.hi");	
		
		
		loger.debug("paramMap -> "+paramMap.toString());
		String[] arrIdx = paramMap.split(",");
		for (int i = 0; i < arrIdx.length; i++) {
			int result = messageService.hi_delete(Integer.parseInt(arrIdx[i]));
			
			
			
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setView(new RedirectView((to+".hi")));
		
		
		loger.debug("<<E..<<N..<<D..<<.. REQUEST: message/reply.hi");
		loger.debug("----------------------------------------------------------");
		
		return mav;
	}	
	
	@RequestMapping("message/receive.hi")
	public ModelAndView do_search(HttpServletRequest res) {
			
		loger.debug("----------------------------------------------------------");
		loger.debug("<<S..<<T..<<A..<<R..<<T..<<.. REQUEST: receive.hi");		
		
					
		HttpSession session = res.getSession(false); 
		
		ModelAndView mav = new ModelAndView();
		String PAGE_NUM = 
				(res.getParameter("PAGE_NUM") == null || res.getParameter("PAGE_NUM").equals(""))
				?"1":res.getParameter("PAGE_NUM");
		
		if(session.getAttribute("user") != null) {
			loger.debug("session info -> " + session.toString());
			UserDto dto = (UserDto) session.getAttribute("user");
			
			Map<String, Object> search_info = new HashMap<String, Object>();			
			
			search_info.put("PAGE_NUM", PAGE_NUM);
			search_info.put("TAKEID", dto.getId());
			loger.debug("session.getId() -> " + dto.getId());
			loger.debug("search_info 	 -> " + search_info.toString());
			
			// 리스트 가져오기
			List<Map<String, Object>> getList = messageService.hi_select_getlist(search_info);		
			loger.debug("getlist size -> " + getList.size());			
			
			mav.setViewName("/message/message_list1");
			mav.addObject("getList", getList);
			mav.addObject("PAGE_NUM", PAGE_NUM);
			///////////////////////////////////////////////////<--////////////////////////////////
			mav.addObject("My_Id", dto.getId());
			
		} else {
			loger.debug("session.getAttribute(user) -> null");
			mav.setViewName("/main/login");
		}	
		
		
		loger.debug("<<E..<<N..<<D..<<.. REQUEST: receive.hi");
		loger.debug("----------------------------------------------------------");
		
		return mav;		
	}

	@RequestMapping("message/send.hi")
	public ModelAndView messageList(HttpServletRequest res) {
		
		loger.debug("----------------------------------------------------------");
		loger.debug("<<S..<<T..<<A..<<R..<<T..<<.. REQUEST: send.hi");		
		
		
		HttpSession session = res.getSession(false); 
				
		ModelAndView mav = new ModelAndView();
		String PAGE_NUM = 
				(res.getParameter("PAGE_NUM") == null || res.getParameter("PAGE_NUM").equals(""))
				?"1":res.getParameter("PAGE_NUM");
		
		if(session.getAttribute("user") != null) {
			loger.debug("session info -> " + session.toString());
			UserDto dto = (UserDto) session.getAttribute("user");
			
			Map<String, Object> search_info = new HashMap<String, Object>();	
			
			search_info.put("PAGE_NUM", PAGE_NUM);
			search_info.put("SENDID", dto.getId());
			loger.debug("session.getId() -> " + dto.getId());
			loger.debug("search_info -> " + search_info.toString());
			
			// 리스트 가져오기
			List<Map<String, Object>> getList = messageService.hi_select_sendlist(search_info);
			loger.debug("sendlist size -> " + getList.size());
			
			mav.setViewName("/message/message_list2");
			mav.addObject("getList", getList);
			mav.addObject("PAGE_NUM", PAGE_NUM);
			
		} else {
			loger.debug("session.getAttribute(user) -> null");
			mav.setViewName("/main/login");
		}		
		
		loger.debug("<<E..<<N..<<D..<<.. REQUEST: send.hi");
		loger.debug("----------------------------------------------------------");
		
		return mav;	
	}

}


