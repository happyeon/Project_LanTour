package com.lan.tour.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lan.tour.model.biz.CommunityBiz;
import com.lan.tour.model.biz.HotelBiz;
import com.lan.tour.model.biz.LantourBiz;
import com.lan.tour.model.biz.NoticeBiz;

@Controller
public class MainController {

	@Autowired
	private HotelBiz h_biz;

	@Autowired
	private CommunityBiz c_biz;

	@Autowired
	private NoticeBiz n_biz;
	
	@Autowired
	private LantourBiz l_biz;
	
	
	@RequestMapping("/main.do")
	public String main(Model model) {
		model.addAttribute("popup_list", n_biz.selectPopupList());
		model.addAttribute("h_list", h_biz.selectList());
		model.addAttribute("c_list", c_biz.selectList());
		model.addAttribute("n_list", n_biz.noticelist());
		model.addAttribute("l_list", l_biz.lantourList());

		return "main";
	}
}
