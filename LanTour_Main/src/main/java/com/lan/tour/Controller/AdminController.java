package com.lan.tour.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lan.tour.model.biz.CommentBiz;
import com.lan.tour.model.biz.CommunityBiz;
import com.lan.tour.model.biz.HotelBiz;
import com.lan.tour.model.biz.LantourBiz;
import com.lan.tour.model.biz.MemberBiz;
import com.lan.tour.model.biz.ReservationBiz;
import com.lan.tour.model.dto.CommunityDto;
import com.lan.tour.model.dto.HotelDto;
import com.lan.tour.model.dto.LantourDto;
import com.lan.tour.model.dto.MemberDto;
import com.lan.tour.model.dto.ReservationDto;

@Controller
public class AdminController {

	@Autowired
	private MemberBiz mem_biz;

	@Autowired
	private CommunityBiz com_biz;

	@Autowired
	private CommentBiz comment_biz;

	@Autowired
	private ReservationBiz reser_biz;

	@Autowired
	private HotelBiz ho_biz;

	@Autowired
	private LantourBiz lan_biz;

	// 관리자 페이지로 이동
	@RequestMapping("/adminmember.do")
	public String adminmember(Model model) {
		model.addAttribute("m_list", mem_biz.selectList());

		return "adminmember";
	}

	@RequestMapping("/adminmemberupdate.do")
	public String update(MemberDto dto) {
		System.out.println(dto.getMember_grade());

		mem_biz.memberupdate(dto);
		return "redirect:adminmember.do";

	}

	@RequestMapping("/admincommunity.do")
	public String admincommunity(Model model) {
		model.addAttribute("c_list", com_biz.selectList());

		return "admincommunity";
	}

	@RequestMapping("/admincommunityAlldelete.do")
	public String admincommunityAlldelete(int community_no) {
		if (comment_biz.selectList(community_no).size()>=0&&comment_biz.deleteAll(community_no) > 0) {
			if (com_biz.communityAlldelete(community_no) > 0) {
				return "redirect:admincommunity.do";
			}
		}else {
			if (com_biz.communityAlldelete(community_no) > 0) {
				return "redirect:admincommunity.do";
			}
		}
		return "redirect:main.do";
	}

	@RequestMapping("/admincommunity_refaire.do")
	public String admincommunity_refaire(int community_no) {
		if (com_biz.community_refaire(community_no) > 0) {
			return "redirect:admincommunity.do";
		}
		return "redirect:main.do";
	}

	@RequestMapping("/adminchart.do")
	public String adminchart() {
		return "adminchart";
	}

	@ResponseBody
	@RequestMapping("/adminreservationchart.do")
	public Map<String, List<ReservationDto>> reservation() {
		List<ReservationDto> r_list = reser_biz.selectchart();

		Map<String, List<ReservationDto>> map = new HashMap<String, List<ReservationDto>>();
		map.put("r_list", r_list);

		return map;
	}

	@ResponseBody
	@RequestMapping("/adminmemberchart.do")
	public Map<String, List<MemberDto>> chartmember() {
		List<MemberDto> m_list = mem_biz.manchartmember();
		List<MemberDto> w_list = mem_biz.womanchartmember();

		Map<String, List<MemberDto>> map = new HashMap<String, List<MemberDto>>();
		map.put("m_list", m_list);
		map.put("w_list", w_list);

		return map;
	}

	@ResponseBody
	@RequestMapping("/admincommunitychart.do")
	public Map<String, List<CommunityDto>> admincommunitychart() {
		List<CommunityDto> list = com_biz.communitychart();

		Map<String, List<CommunityDto>> map = new HashMap<String, List<CommunityDto>>();
		map.put("list", list);

		return map;
	}

	@ResponseBody
	@RequestMapping("/adminhotelchart.do")
	public Map<String, List<HotelDto>> adminhotelchart() {
		List<HotelDto> list = ho_biz.hotelchart();

		Map<String, List<HotelDto>> map = new HashMap<String, List<HotelDto>>();
		map.put("list", list);

		return map;
	}

	@ResponseBody
	@RequestMapping("/adminlantourchart.do")
	public Map<String, List<LantourDto>> adminlantourchart() {
		List<LantourDto> list = lan_biz.lantourchart();

		Map<String, List<LantourDto>> map = new HashMap<String, List<LantourDto>>();
		map.put("list", list);

		return map;
	}

	@RequestMapping("admincommunity_titlesearch.do")
	public String communitytitlesearch(Model model, String community_content) {
		model.addAttribute("c_list", com_biz.selecttitlesearchList(community_content));
		model.addAttribute("community_content", community_content);
		model.addAttribute("filter", "title");

		return "admincommunity";
	}

	@RequestMapping("admincommunity_contentsearch.do")
	public String communitycontentsearch(Model model, String community_content) {
		model.addAttribute("c_list", com_biz.selectcontentsearchList(community_content));
		model.addAttribute("community_content", community_content);
		model.addAttribute("filter", "content");

		return "admincommunity";
	}

	@RequestMapping("admincommunity_namesearch.do")
	public String communitynamesearch(Model model, String community_content) {
		model.addAttribute("c_list", com_biz.selectnamesearchList(community_content));
		model.addAttribute("community_content", community_content);
		model.addAttribute("filter", "name");

		return "admincommunity";
	}

	@RequestMapping("/adminmembersearch.do")
	public String adminmembersearch(Model model, String member_id) {
		model.addAttribute("m_list", mem_biz.searchmember(member_id));
		return "adminmember";
	}

}
