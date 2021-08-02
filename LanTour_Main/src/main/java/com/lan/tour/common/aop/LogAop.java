package com.lan.tour.common.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Aspect
public class LogAop {

	@Before("execution(public * com.lan.tour.model.dao.*Dao*.*(..))")
	public void before(JoinPoint join) {
		Logger logger = LoggerFactory.getLogger(join.getTarget() + "");
		logger.info("-------------------AOP start----------------------");

		Object[] args = join.getArgs();
		if (args != null) {
			logger.info("method : " + join.getSignature().getName());
		}
		for (int i = 0; i < args.length; i++) {
			logger.info(i + "번째 : " + args[i]);
		}

	}

	@After("execution(public * com.lan.tour.model.dao.*Dao*.*(..))")
	public void after(JoinPoint join) {
		Logger logger = LoggerFactory.getLogger(join.getTarget() + "");
		logger.info("-------------------AOP End----------------------");
	}

	@AfterThrowing("execution(public * com.lan.tour.model.dao.*Dao*.*(..))")
	public void afterThrowing(JoinPoint join) {
		Logger logger = LoggerFactory.getLogger(join.getTarget() + "");
		logger.info("-------------------AOP ERROR----------------------");
		logger.info("ERROR : " + join.getArgs());
		logger.info("ERROR : " + join.toString());

	}
}
