package com.lan.tour.Controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.cxf.io.CachedOutputStream;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;


import net.sf.json.JSONObject;

@Controller
public class FestivalController {

	String ServiceKey = "vvRGNETMTer5g%2FtseMyAW8fIgf4srNxLxIXMNC5yM4f9ij2KKCMsNZyJ1i%2F0WP%2Fal6m4x1awA4%2FW3LpY8ZA7Mw%3D%3D";
	
	@RequestMapping("/festival.do")
	public String loginForm() {
		return "festival_search";
	}

	@RequestMapping(value = "/festivallist.do")
	public void festivalInfo(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam int pageNo, @RequestParam String eventStartDate, @RequestParam String eventEndDate, @RequestParam String areaCode, @RequestParam String arrange) throws IOException {
		request.setCharacterEncoding("UTF-8");
		//response.setContentType("text/html; charset=UTF-8");
		//response.setContentType("application/json; charset=utf-8");
		String addr = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?serviceKey=";
		
		//if (pagetest == null) {pagetest = "1";}
		
		String parameter = "";
		
		PrintWriter out = response.getWriter();
		parameter = parameter + "&" + "numOfRows=10";
		parameter = parameter + "&" + "pageNo=" + pageNo;
		parameter = parameter + "&" + "MobileOS=ETC";
		parameter = parameter + "&" + "MobileApp=AppTest";
		parameter = parameter + "&" + "arrange=" + arrange;
		parameter = parameter + "&" + "listYN=Y";
		parameter = parameter + "&" + "areaCode="+areaCode;
		parameter = parameter + "&" + "sigunguCode=";
		parameter = parameter + "&" + "eventStartDate=" + eventStartDate;
		parameter = parameter + "&" + "eventEndDate=" + eventEndDate;
		parameter = parameter + "&" + "modifiedtime=";
		parameter = parameter + "&" + "_type=json";
		
		addr = addr + ServiceKey + parameter;
		URL url = new URL(addr);
		
		InputStream in = url.openStream();
		CachedOutputStream bos = new CachedOutputStream();
		IOUtils.copy(in, bos);
		in.close();
		bos.close();
		
		String data = bos.getOut().toString();
		out.println(data);
		System.out.println("-------------------------------------------------------------------------------------------------------------");
		System.out.println(data);
		JSONObject json = new JSONObject();
		json.put("data", data);
		
		System.out.println(json);

		
		
	}
	
	
	@RequestMapping(value = "/festivaldetail.do")
	public String festivaldetail(Model model, String contentid, String eventstartdate, String eventenddate, HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
		
		model.addAttribute("contentid", contentid);
		model.addAttribute("eventstartdate", eventstartdate);
		model.addAttribute("eventenddate", eventenddate);

		
		return "festival_detail";
	}
	
	// 소개 정보 조회 부분 사용하기
		@RequestMapping(value = "/festivaldetaillist.do")
		public void festivaldetaillist(String contentid, HttpServletRequest request, HttpServletResponse response) throws IOException {
			request.setCharacterEncoding("UTF-8");
			
			String addr = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?serviceKey=";
			String parameter = "";
			PrintWriter out = response.getWriter();
			parameter = parameter + "&" + "MobileOS=ETC";
			parameter = parameter + "&" + "MobileApp=AppTest";
			parameter = parameter + "&" + "contentId=" + contentid;
			//parameter = parameter + "&" + "contentTypeId=" + contenttypeid;
			parameter = parameter + "&" + "defaultYN=Y";
			parameter = parameter + "&" + "firstImageYN=Y";
			//parameter = parameter + "&" + "areacodeYN=Y";
			//parameter = parameter + "&" + "catcodeYN=Y";
			parameter = parameter + "&" + "addrinfoYN=Y";
			parameter = parameter + "&" + "mapinfoYN=Y";
			parameter = parameter + "&" + "overviewYN=Y";
			parameter = parameter + "&" + "_type=json";
			
			addr = addr + ServiceKey + parameter;
			URL url = new URL(addr);

			
			InputStream in = url.openStream();
			CachedOutputStream bos = new CachedOutputStream();
			IOUtils.copy(in, bos);
			in.close();
			bos.close();
			
			String data = bos.getOut().toString();
			out.println(data);
			System.out.println("-------------------------------------------------------------------------------------------------------------");
			System.out.println(data);
			JSONObject json = new JSONObject();
			json.put("data", data);
			
			System.out.println(json);


		}
}
