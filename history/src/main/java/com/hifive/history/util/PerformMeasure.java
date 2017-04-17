package com.hifive.history.util;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StopWatch;

import com.hifive.history.model.PerformDto;
import com.hifive.history.service.IPerformService;

@Aspect
public class PerformMeasure {
	 Logger log=LoggerFactory.getLogger(this.getClass());
	 
	 @Autowired
	 private IPerformService performService;
	 
	 @Around("execution(* com..history.controller.*Control.*(..))")
	 public Object logging(ProceedingJoinPoint joinPoint) throws Throwable {
		 	PerformDto dto=new PerformDto();
		 
		    String type = joinPoint.getSignature().getDeclaringTypeName();
		    String name= joinPoint.getSignature().getName();
		    dto.setID(CommonUtils.getRandomString());
		    dto.setCLASS_NM(type);
		    dto.setMETHOD_NM(name);
	        
		    StopWatch stopWatch = new StopWatch();

	        try {
	            stopWatch.start();
	            
	            // 핵심 로직 실행.
	            Object retValue = joinPoint.proceed();
	            
	            return retValue;
	        } catch(Throwable e) {
	            throw e;
	        } finally {
	        	stopWatch.stop();
	            System.out.println("기록 종료");
	            log.debug("====================================");
	            dto.setP_TIME(stopWatch.getTotalTimeMillis());
	            performService.hi_insert(dto);
	        }

		 

	 }

}
