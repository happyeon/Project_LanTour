package com.lan.tour.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lan.tour.model.biz.MemberBiz;
import com.lan.tour.model.dto.MemberDto;

@Controller
public class FindController {

	@Autowired
	private MemberBiz biz;

	@Autowired
	private BCryptPasswordEncoder pwEncoder;

	@RequestMapping("/findid.do")
	public String findid() {
		return "findid";
	}

	@RequestMapping("/findpassword.do")
	public String findpassword() {
		return "findpassword";
	}

	@RequestMapping("/findidres.do")
	public String findidres(MemberDto dto, Model model) {
		String id = biz.findId(dto);

		model.addAttribute("id", id);
		return "findresultId";
	}

	@RequestMapping("/findpasswordres.do")
	public String findpwres(MemberDto dto, Model model) {
		if (biz.findpw(dto) != null) {
			model.addAttribute("dto", biz.findpw(dto));
			return "findupdatepw";
		}
		model.addAttribute("fail", "fail");
		return "findpassword";

	}
	
	@RequestMapping("/findupdatepwres.do")
	public String findupdatepwres(MemberDto dto) {
		dto.setMember_password(pwEncoder.encode(dto.getMember_password()));
		if(biz.updatepw(dto) > 0) {
			return "redirect:loginform.do";
		}
		return "redirect:findpassword.do";
	}
}
