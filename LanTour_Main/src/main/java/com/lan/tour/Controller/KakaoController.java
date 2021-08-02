package com.lan.tour.Controller;

import java.util.HashMap;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lan.tour.model.biz.KakaoService;
import com.lan.tour.model.biz.MemberBiz;
import com.lan.tour.model.dto.MemberDto;

@Controller
public class KakaoController {

	@Autowired
    private KakaoService kakaoService;

	@Autowired
	private MemberBiz biz;

	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	
	@RequestMapping("/kakaologin.do")
	public String Kakao(@RequestParam(value = "code", required = false) String code, HttpSession session) throws Exception{
		
		
		
		System.out.println("#########" + code);
        String access_Token = kakaoService.getAccessToken(code);
        System.out.println("###access_Token#### : " + access_Token);
        
        HashMap<String, Object> userInfo = kakaoService.getUserInfo(access_Token);
        
        session.setAttribute("token", access_Token.toString());
        
        
        System.out.println("###id#### : " + userInfo.get("id"));
        System.out.println("###nickname#### : " + userInfo.get("nickname"));
        System.out.println("###email#### : " + userInfo.get("email"));
        System.out.println("###gender#### : " + userInfo.get("has_gender"));
        
        MemberDto dto = new MemberDto();
        dto.setMember_id(userInfo.get("id").toString());
        
        MemberDto res = biz.idCheck(dto);
        if(res != null) {
        	
        	session.setAttribute("login", res);
        } else { //아이디가 존재하지않는 경우
        	if(biz.checkEmail(userInfo.get("email").toString())!= null) { //가입된 이메일이 있는경우
        		return "redirect:main.do";//특정상황에 경고창 띄워주게 만들어줄것
        	} else {	//가입된 이메일이 없는경우
        		System.out.println("11");
        		session.setAttribute("userInfo", userInfo);
        		return "signup_kakao";
        	}
        }
        	
        
        return "redirect:main.do";
    }
	
	
	@RequestMapping("/signup_kakaores.do")
	public String signup_kakaores(HttpSession session, MemberDto dto) {	
		  
			
			HashMap<String, Object> userInfo = (HashMap<String, Object>)session.getAttribute("userInfo");
			
			dto.setMember_id(userInfo.get("id").toString());
	        dto.setMember_name(userInfo.get("nickname").toString());
			dto.setMember_email(userInfo.get("email").toString());
			
		
			
	        if(biz.insert(dto) > 0) {
	        	session.setAttribute("login", biz.idCheck(dto));
	        	
	        	return "redirect:main.do";
	        } 
	        
	        return "signup_kakao";
	}
}