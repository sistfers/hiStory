package com.hifive.history.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import com.hifive.history.model.UserDto;

@Component
public class EmailSenderUtil {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private JavaMailSender mailSender;

	public ModelAndView eamilSender(UserDto dto, String token) {
				
		String sender  = "sisthifive@gmail.com";
		String title   = "[Hifive] Please verify your email address";		
		String content = "http://localhost:8080/userAuth.hi/" + token;
		
		logger.debug("[[[content  ]] "+content);
		
//		try {
//			content = URLEncoder.encode(content, "UTF-8");
//			
//		} catch (UnsupportedEncodingException e1) {
//			e1.printStackTrace();
//		}
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper 
			= new MimeMessageHelper(message, true, "UTF-8");
			
			messageHelper.setFrom(sender);   		// 보내는사람 생략하거나 하면 정상작동을 안함
		    messageHelper.setTo("kalgoorlie@naver.com");    // 받는사람 이메일
		    messageHelper.setSubject(title); 		// 메일제목은 생략이 가능하다
		    messageHelper.setText(content); 		// 메일 내용
		    
		    mailSender.send(message);
			
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/auth/welcome");
		
		return mav;
	}
}
