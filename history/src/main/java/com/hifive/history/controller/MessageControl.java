package com.hifive.history.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hifive.history.model.MessageDto;
import com.hifive.history.service.MessageService;

/**
 * Created by Admin on 2017-03-24.
 */
@Controller
public class MessageControl {
	
	Logger loger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private MessageService messageService; 
	
	
	@RequestMapping("message/read.hi")
	public ModelAndView do_read(@RequestParam(value = "note", required=false) int seq,
								@RequestParam(value = "nick", required=false) String nick) {
	
		loger.debug("----------------------------------------------------------");
		loger.debug("<<S..<<T..<<A..<<R..<<T..<<.. REQUEST: message/read.hi");	
		
		/*
		private	int		seq;
		private	String	send_id;
		private	String	take_id;
		private String  contents;
		private	String	wdate;
		private	String	rdate;
		private	String	state;	*/
		MessageDto dto = new MessageDto();
		dto.setSeq(seq);
		dto.setSend_id("");
		dto.setTake_id("");
		dto.setContents("");
		dto.setWdate("");
		dto.setRdate("");
		dto.setState("");
		dto.setNick(nick);
		
		MessageDto note = new MessageDto();
		note = (MessageDto) messageService.hi_detail(dto);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/message/read");
		mav.addObject("note", note);		
		
		
		loger.debug("<<E..<<N..<<D..<<.. REQUEST: message/read.hi");
		loger.debug("----------------------------------------------------------");
		
		return mav;
	}

	@RequestMapping("message/write.hi")
	public String messageWrite() {
		
		return "/message/write";
	}
	
	@RequestMapping("message/send_message_list.hi")
	public ModelAndView do_search(HttpServletRequest res) {
			
		loger.debug("----------------------------------------------------------");
		loger.debug("<<S..<<T..<<A..<<R..<<T..<<.. REQUEST: sned_message_list.hi");		
		
		
		Map<String, Object> search_info = new HashMap<String, Object>();
		
		String PAGE_NUM = 
				(res.getParameter("PAGE_NUM") == null || res.getParameter("PAGE_NUM").equals(""))
				?"1":res.getParameter("PAGE_NUM");
		
		search_info.put("PAGE_NUM", PAGE_NUM);
		search_info.put("TAKEID", "Patricia");
//		search_info.put("TAKEID", "Patri2cia");
		loger.debug("search_info -> " + search_info.toString());
		
		// 리스트 가져오기
		List<Map<String, Object>> getList = messageService.hi_select_getlist(search_info);		
		loger.debug("getlist size -> " + getList.size());
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/message/message_list");
		mav.addObject("getList", getList);
		mav.addObject("PAGE_NUM", PAGE_NUM);
		
		
		loger.debug("<<E..<<N..<<D..<<.. REQUEST: sned_message_list.hi");
		loger.debug("----------------------------------------------------------");
		
		return mav;		
	}

	@RequestMapping("message/message_list.hi")
	public String messageList() {
		return "/message/message_list";
	}

}


