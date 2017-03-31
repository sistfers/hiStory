package com.hifive.history.util;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import com.hifive.history.model.UserDto;

@Component
public class EmailSenderUtil {

	@Autowired
	private JavaMailSender mailSender;	

	public EmailSenderUtil() {
		
	}

	public ModelAndView eamilSender(UserDto dto) {
		
		IssueAnTokenUtil issueAnTokenUtil = new IssueAnTokenUtil();
		String tmp = issueAnTokenUtil.tokenMaker(dto);
		
		String sender  = "sisthifive@gmail.com";
		String title   = "[Hifive] Please verify your email address";		
		String content = "http://localhost:8080/userAuth/" + tmp + ".hi";
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper 
			= new MimeMessageHelper(message, true, "UTF-8");
			
			messageHelper.setFrom(sender);   		// 보내는사람 생략하거나 하면 정상작동을 안함
		    messageHelper.setTo(dto.getEmail());    // 받는사람 이메일
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

//	@RequestMapping("mail/sender.hi") 
//	public ModelAndView eamilSender(@RequestParam(value = "reciever", required=true) String reciever,
//			@RequestParam(value = "title", required=true) String title,
//			@RequestParam(value = "content", required=true) String content) {
//		
//		String sender = "sisthifive@gmail.com";
//		
//		try {
//			MimeMessage message = mailSender.createMimeMessage();
//			MimeMessageHelper messageHelper 
//			= new MimeMessageHelper(message, true, "UTF-8");
//			
//			messageHelper.setFrom(sender);   // 보내는사람 생략하거나 하면 정상작동을 안함
//		    messageHelper.setTo(reciever);   // 받는사람 이메일
//		    messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
//		    messageHelper.setText(content);  // 메일 내용
//		    
//		    mailSender.send(message);
//			
//		} catch (MessagingException e) {
//			e.printStackTrace();
//		}
//		
//		ModelAndView mav = new ModelAndView();
//		mav.setViewName("/auth/welcome");
//		
//		return mav;
//	}
}
