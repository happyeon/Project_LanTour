package com.lan.tour.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.lan.tour.model.dto.MemberDto;

public class LoginInterceptor implements HandlerInterceptor {

	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		if (request.getRequestURI().contains("/updateRtcAddr.do")) {
			return true;
		}
		
		if(!request.getRequestURI().contains("find")) {
			if(request.getRequestURI().contains("reservation")||
					request.getRequestURI().contains("my")||	
					request.getRequestURI().contains("My")||	
					request.getRequestURI().contains("insert")||			
					request.getRequestURI().contains("delete")||
					request.getRequestURI().contains("update")||
					request.getRequestURI().contains("Insert")||			
					request.getRequestURI().contains("Delete")||
					request.getRequestURI().contains("Update")||
					request.getRequestURI().contains("payment")||
					request.getRequestURI().contains("payment")) {
					if(request.getSession().getAttribute("login")==null) {
						response.sendRedirect("loginRedirect.do");
						return false;
					}
				}
		}
		
		if(request.getRequestURI().contains("admin")&&((MemberDto)request.getSession().getAttribute("login")).getMember_grade().equals("A")) {
			response.sendRedirect("main.do");
			return false;
		}
			
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

	}

}
