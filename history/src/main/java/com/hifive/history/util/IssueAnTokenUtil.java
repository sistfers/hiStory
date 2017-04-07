package com.hifive.history.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.hifive.history.model.UserDto;

@Component
public class IssueAnTokenUtil {	
	
//	@Autowired
//	EncodeTokenUtil encodeTokenUtil;

	public String tokenMaker(UserDto dto) {		
		
		long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-ddhh:mm:ss");
		
		String origin = dto.getEmail() + "t" + dayTime.format(new Date(time));
		
		// 어떻게 암호화 시킬까?
//		encodeTokenUtil()
		
		String generatedToken = origin;
				
		return generatedToken;		
	}
}
