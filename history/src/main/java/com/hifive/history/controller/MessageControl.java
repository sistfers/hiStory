package com.hifive.history.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hifive.history.service.MessageService;

/**
 * Created by Admin on 2017-03-24.
 */
@Controller
public class MessageControl {
	
	Logger loger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private MessageService messageService; 
	
	@RequestMapping("message/sned_message_list.hi")
	public ModelAndView do_search(HttpServletRequest res) {
				
		loger.debug("<<<<<<<<<< sned_message_list.hi");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("empty");
		
		loger.debug("sned_message_list.hi >>>>>>>>>>");
		
		return mav;		
	}

	@RequestMapping("message/message_list.hi")
	public String messageList() {
		return "/message/message_list";
	}

	@RequestMapping("message/write.hi")
	public String messageWrite() {
		return "/message/write";
	}
}


