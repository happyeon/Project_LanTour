package com.lan.tour.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lan.tour.model.biz.CalendarBiz;
import com.lan.tour.model.biz.MemberBiz;
import com.lan.tour.model.biz.ReservationBiz;
import com.lan.tour.model.dto.CalendarDto;

@Controller
public class CalendarController {
	
	@Autowired
	private MemberBiz biz;
	
	@Autowired
	private CalendarBiz CBiz;
	
	@Autowired
	private ReservationBiz RBiz;
	
	@RequestMapping("/mytrip.do")
	public String mytrip(Model model, String member_no) {
		
		int member_no1 = Integer.parseInt(member_no);
		System.out.println(member_no1);
		
		model.addAttribute("listLan", RBiz.selectListLanM(member_no1));
		model.addAttribute("listRoom", RBiz.selectListRoomM(member_no1));
		model.addAttribute("listCal", CBiz.selectList(member_no1));
		
		return "mytrip";
	}
	
	@RequestMapping("/popupDetail.do")
	public String popupDetail(Model model, CalendarDto dto) {
		
		model.addAttribute("dto", CBiz.selectOne(dto.getCal_no()));
		
		return "popup_calDetail";
	}
	
	@RequestMapping("/popupInsert.do")
	public String popupInsert() {
		return "popup_calInsert";
	}
	
	@ResponseBody
	@RequestMapping("/popupInsertRes.do")
	public String popupInsertRes(CalendarDto dto) {
		System.out.println(dto);
		if (CBiz.insert(dto) > 0) {
			return "redirect:mytrip.do";
		}
		
		return "redirect:popupInsert.do";
	}

	@RequestMapping("/popupUpdate.do")
	public String popupUpdate(Model model, CalendarDto dto) {
		
		model.addAttribute("dto", CBiz.selectOne(dto.getCal_no()));
		
		return "popup_calUpdate";
	}
	
	@ResponseBody
	@RequestMapping("/popupUpdateRes.do")
	public String popupUpdateRes(CalendarDto dto) {
		
		if (CBiz.update(dto) > 0) {
			return "redirect:mytrip.do";
		}
		
		return "redirect:popupUpdate.do";
	}
	
	@ResponseBody
	@RequestMapping("/popupDelete.do")
	public String popupDelete(int cal_no) {

		if (CBiz.delete(cal_no) > 0) {
			return "redirect:mytrip.do";
		}
		
		return "redirect:popupDetail.do";
	}
	
	@ResponseBody
	@RequestMapping("/dragUpdate.do")
	public String dragUpdate(CalendarDto dto) {
		
		if (CBiz.dragUpdate(dto) > 0) {
			return "y";
		}
		
		return "n";
	}

}
