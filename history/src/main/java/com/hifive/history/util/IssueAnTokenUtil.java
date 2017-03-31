package com.hifive.history.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.hifive.history.model.UserDto;

public class IssueAnTokenUtil {

	public static String tokenMaker(UserDto dto) {		
		
		long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		
		String origin = dto.getEmail() + " " + dayTime.format(new Date(time));
		String generatedToken = origin;
				
		return generatedToken;		
	}
}
