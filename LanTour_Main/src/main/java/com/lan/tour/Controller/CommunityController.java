package com.lan.tour.Controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.lan.tour.model.biz.CommentBiz;
import com.lan.tour.model.biz.CommunityBiz;
import com.lan.tour.model.dto.CommunityDto;

@Controller
public class CommunityController {

	@Autowired
	private CommunityBiz biz;

	@Autowired
	private CommentBiz biz2;

	@RequestMapping("community.do")
	public String community(Model model) {
		model.addAttribute("list", biz.selectList());

		return "community";
	}

	@RequestMapping("communityinsert.do")
	public String communityinsert() {
		return "communityinsert";
	}

	@RequestMapping("communityinsertres.do")
	public String communityinsertres(CommunityDto dto) {
		if (biz.insert(dto) > 0) {
			return "redirect:community.do";
		}

		return "redirect:communityinsert.do";
	}

	@RequestMapping("communitydetail.do")
	public String communitydetail(Model model, int community_no) {
		biz.readcount(community_no);

		model.addAttribute("dto", biz.selectOne(community_no));

		return "communitydetail";
	}

	@RequestMapping("communitydelete.do")
	public String communitydelete(int community_no) {
		if (biz.delete(community_no) > 0) {
			return "redirect:community.do";
		}

		return "redirect:communitydetail.do?community_no=" + community_no;
	}

	@RequestMapping("communityupdate.do")
	public String communityupdate(Model model, int community_no) {
		model.addAttribute("dto", biz.selectOne(community_no));

		return "communityupdate";
	}

	@RequestMapping("communityupdateres.do")
	public String communityupdateres(CommunityDto dto) {
		if (biz.update(dto) > 0) {
			return "redirect:communitydetail.do?community_no=" + dto.getCommunity_no();
		}

		return "redirect:communityupdate.do?community_no=" + dto.getCommunity_no();
	}

	@ResponseBody
	@RequestMapping("communityupload.do")
	public Map<String, String> fileupload(@RequestParam("file") MultipartFile file, HttpServletRequest request) {

		String name = file.getOriginalFilename();
		String path = "";

		String[] new_name = name.split("\\.");
		System.out.println(new_name[0]);
		String na = new_name[0];
		String renew_na = na;

		String full_na = renew_na + "." + new_name[1];
		InputStream inputStream = null;
		OutputStream outputStream = null;
		try {
			inputStream = file.getInputStream();
			path = WebUtils.getRealPath(request.getSession().getServletContext(), "/resources/communityimg");

			File hotelimg = new File(path);
			if (!hotelimg.exists()) {
				hotelimg.mkdirs();
			}

			File newFile = null;

			for (int i = 1;; i++) {
				newFile = new File(path + "/" + full_na);
				if (!newFile.exists()) {
					newFile.createNewFile();
					break;
				} else {
					renew_na = na + "(" + i + ")";
					full_na = renew_na + "." + new_name[1];
				}
			}

			outputStream = new FileOutputStream(newFile);
			int read = 0;
			byte[] b = new byte[(int) file.getSize()];

			while ((read = inputStream.read(b)) != -1) {
				outputStream.write(b, 0, read);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			try {
				inputStream.close();
				outputStream.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		String return_path = "resources/communityimg/" + full_na;
		System.out.println(return_path);

		Map<String, String> map = new HashMap<String, String>();

		map.put("path", return_path);

		return map;
	}

	@RequestMapping("community_titlesearch.do")
	public String communitytitlesearch(Model model, String community_content) {
		model.addAttribute("list", biz.selecttitlesearchList(community_content));
		model.addAttribute("community_content", community_content);
		model.addAttribute("filter", "title");

		return "community";
	}

	@RequestMapping("community_contentsearch.do")
	public String communitycontentsearch(Model model, String community_content) {
		model.addAttribute("list", biz.selectcontentsearchList(community_content));
		model.addAttribute("community_content", community_content);
		model.addAttribute("filter", "content");

		return "community";
	}

	@RequestMapping("community_namesearch.do")
	public String communitynamesearch(Model model, String community_content) {
		model.addAttribute("list", biz.selectnamesearchList(community_content));
		model.addAttribute("community_content", community_content);
		model.addAttribute("filter", "name");

		return "community";
	}

}
