package com.hifive.history.util;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.servlet.ModelAndView;

import com.hifive.history.model.UserDto;

public class EmailSenderUtil {

	@Autowired
	private static JavaMailSender mailSender;

	public static ModelAndView eamilSender(UserDto dto) {
		
		String sender  = "sisthifive@gmail.com";
		String title   = "[Hifive] Please verify your email address";
		String content = "<p>Hi <strong>@"+ dto.getId() +"</strong>!</p>"+
				"<p>Help us secure your GitHub account by verifying your email address (<a class=\"m_-8909468775075422849plaintext\" href=\"mailto:"
				+ dto.getEmail()+" target=\"_blank\">"+ dto.getEmail() + "</a>). This lets you access all of GitHub's features.</p>"+
				"<hr />"+
				"<p class=\"m_-8909468775075422849email-text-small m_-8909468775075422849email-text-gray\">Button not working? Paste the following link into your browser:<br /> <a href=\"https://github.com/users/sisthifive/emails/29885124/confirm_verification/c56e6cda617e4e98303c50ac91eb40f5dd5d6ecf?utm_campaign=github-email-verification&utm_content=html&utm_medium=email&utm_source=verification-email\" target=\"_blank\" data-saferedirecturl=\"https://www.google.com/url?hl=ko&q=https://github.com/users/sisthifive/emails/29885124/confirm_verification/c56e6cda617e4e98303c50ac91eb40f5dd5d6ecf?utm_campaign%3Dgithub-email-verification%26utm_content%3Dhtml%26utm_medium%3Demail%26utm_source%3Dverification-email&source=gmail&ust=1491028170679000&usg=AFQjCNHetHKc49QsKOsx3u4DE8FV6FlxLg\">https://github.com/users/sisthifive/emails/29885124/confirm_verification/c56e6cda617e4e98303c50ac91eb40f5dd5d6ecf</a></p>"+
				"<p class=\"m_-8909468775075422849email-text-small m_-8909468775075422849email-text-gray\">You’re receiving this email because you recently created a new GitHub account or added a new email address. "+
				"If this wasn’t you, please ignore this email.</p>";		
		
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
