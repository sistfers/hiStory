package com.hifive.history.util;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StopWatch;

@Aspect
public class PerformMeasure {
	 Logger log=LoggerFactory.getLogger(this.getClass());
	 
	 @Around("execution(* com..history.controller.*Control.*(..))")
	 public Object logging(ProceedingJoinPoint joinPoint) throws Throwable {
		 
		    String type = joinPoint.getSignature().getDeclaringTypeName();
		    String name= joinPoint.getSignature().getName();
		    log.debug("===================================type="+type);
		    log.debug("===================================name="+name);
		    System.out.println(name+"기록 시작:"+type);
	        
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
	            System.out.println(joinPoint.getSignature().getName() + "메서드 실행 시간 : " 
	                + stopWatch.getTotalTimeMillis());
	        }

		 

	 }

}
