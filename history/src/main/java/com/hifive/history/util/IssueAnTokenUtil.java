package com.hifive.history.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Component;

import com.hifive.history.model.UserDto;

@Component
public class IssueAnTokenUtil {	

	public String tokenMaker(UserDto dto) {		
		
		long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		
		String origin = dto.getEmail() + "t" + dayTime.format(new Date(time));
		String generatedToken = origin;
				
		return generatedToken;		
	}
}
