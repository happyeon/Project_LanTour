package com.lan.tour.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lan.tour.model.biz.CommentBiz;
import com.lan.tour.model.dto.CommentDto;

@Controller
public class CommentController {

	@Autowired
	private CommentBiz biz;

	@ResponseBody
	@RequestMapping("/commentlist.do")
	public Map<String, List<CommentDto>> commentlist(int community_no) {
		List<CommentDto> list = new ArrayList<CommentDto>();
		list = biz.selectList(community_no);

		Map<String, List<CommentDto>> list_map = new HashMap<String, List<CommentDto>>();

		list_map.put("list", list);
		return list_map;
	}

	@ResponseBody
	@RequestMapping("/commentinsert.do")
	public Map<String, Boolean> commentinsert(CommentDto dto) {
		Boolean check = false;
		if (biz.insert(dto) > 0) {
			check = true;
		}
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("check", check);

		return map;
	}

	@ResponseBody
	@RequestMapping("/commentupdate.do")
	public Map<String, Boolean> commentupdate(CommentDto dto) {
		Boolean check = false;
		if (biz.update(dto) > 0) {
			check = true;
		}
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("check", check);

		return map;
	}


	@RequestMapping("comment_list.do")
	public String commentlist(Model model) {
		List<CommentDto> list = new ArrayList<CommentDto>();
		list = biz.commentlist();
		
		

		return "comment_list";
	}
	@ResponseBody
	@RequestMapping("/commentdelete.do")
	public Map<String, Boolean> commentdelete(int comment_no) {
		Boolean check = false;
		if (biz.delete(comment_no) > 0) {
			check = true;
		}
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("check", check);
		return map;

	}

}
