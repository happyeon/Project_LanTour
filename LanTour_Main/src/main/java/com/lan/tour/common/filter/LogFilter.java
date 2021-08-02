package com.lan.tour.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LogFilter implements Filter {

	private Logger logger = LoggerFactory.getLogger(LogFilter.class);

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest req = (HttpServletRequest) request;

		String addr = req.getRemoteAddr();
		String uri = req.getRequestURI();
		String url = req.getRequestURL().toString();
		String query = req.getQueryString();

		String referer = req.getHeader("referer");
		String agent = req.getHeader("User-Agent");

		StringBuffer sb = new StringBuffer();

		sb.append(" * remoteAddr : " + addr + "\n").append(" * uri : " + uri + "\n").append(" * url : " + url + "\n")
				.append(" * query : " + query + "\n").append(" * referer : " + referer + "\n")
				.append(" * agent : " + agent + "\n");

		logger.info("LOG FILTER \n" + sb);

		chain.doFilter(request, response);

	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

}
