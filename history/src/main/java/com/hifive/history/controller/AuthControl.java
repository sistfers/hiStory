package com.hifive.history.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AuthControl {	
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "userAuth.hi", method = RequestMethod.GET)
	public ModelAndView join(HttpServletRequest request) {

		String uri = request.getRequestURI();
		
		try {
			String decodeResult = URLDecoder.decode(uri, "UTF-8");
			logger.debug("[[[decodeResult  ]] "+decodeResult);
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("/auth/welcome");
		
		return mav;
	}
}
