package com.hifive.history.controller;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AuthControl {
	
	@Autowired
	private JavaMailSender mailSender;

	@RequestMapping(value = "userAuth.hi", method = RequestMethod.GET)
	public ModelAndView join(HttpServletRequest request) {
//
//		String sender = "sisthifive@gmail.com";
//		String title = "[Hifive] Please verify your email address";
//		String content = "htt";
//
//		try {
//			MimeMessage message = mailSender.createMimeMessage();
//			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
//
//			messageHelper.setFrom(sender); // 보내는사람 생략하거나 하면 정상작동을 안함
//			messageHelper.setTo("kalgoorlie@naver.com"); // 받는사람 이메일
//			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
//			messageHelper.setText(content); // 메일 내용
//
//			mailSender.send(message);
//
//		} catch (MessagingException e) {
//			e.printStackTrace();
//		}
//
//		ModelAndView mav = new ModelAndView();
//		mav.setViewName("/auth/welcome");

		return null;
	}
}
