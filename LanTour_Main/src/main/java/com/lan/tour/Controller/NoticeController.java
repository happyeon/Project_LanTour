package com.lan.tour.Controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.lan.tour.model.biz.NoticeBiz;
import com.lan.tour.model.dto.NoticeDto;
import com.lan.tour.model.dto.NoticePagingDto;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeBiz biz;
	
	@RequestMapping("/noticeList_category.do")
	public String selectKeywordList(Model model, NoticePagingDto dto) {

		int count = 0;
		
		String category = dto.getCategory();
		String keyword = dto.getKeyword();
		int nowPage = dto.getNowPage();
		
		if (category == null || category.equals("")) {
			count = biz.countTotal();
			System.out.println(count);
			NoticePagingDto dtoN = new NoticePagingDto(count, nowPage);
			
			model.addAttribute("list", biz.selectList(dtoN));
			model.addAttribute("dto", dtoN);
		} else if (category.equals("n_t")) {
			count = biz.countT(keyword);
			NoticePagingDto dtoN = new NoticePagingDto(count, nowPage, keyword, category);
			
			model.addAttribute("list", biz.selectTitleList(dtoN));
			model.addAttribute("dto", dtoN);
			
		} else if (category.equals("n_c")) {
			count = biz.countC(keyword);
			NoticePagingDto dtoN = new NoticePagingDto(count, nowPage, keyword, category);
			
			model.addAttribute("list", biz.selectContentList(dtoN));
			model.addAttribute("dto", dtoN);
			
		} else if (category.equals("n_t_c")) {
			count = biz.countTC(keyword);
			NoticePagingDto dtoN = new NoticePagingDto(count, nowPage, keyword, category);
			
			model.addAttribute("list", biz.selectTCList(dtoN));
			model.addAttribute("dto", dtoN);
			
		}
		
		return "notice_list";
	}
	

	
	@RequestMapping("/noticeInsertForm.do")
	public String insertForm() {
		return "notice_insert";
	}
	
	@RequestMapping("/noticeInsertRes.do")
	public String insertRes(NoticeDto dto) {
		
		if (biz.insert(dto) > 0) {
			return "redirect:noticeList_category.do?nowPage=" + 1;
		}
		
		return "redirect:noticeInsertForm.do";
	}
	
	@RequestMapping("/noticeSelectOne.do")
	public String selectOne(Model model, int notice_no) {
		
		model.addAttribute("dto", biz.selectOne(notice_no));
		
		return "notice_detail";
	}
	
	@RequestMapping("/noticeUpdateForm.do")
	public String updateForm(Model model, int notice_no) {
		
		model.addAttribute("dto", biz.selectOne(notice_no));
		
		return "notice_update";
	}
	
	@RequestMapping("/noticeUpdateRes.do")
	public String updateRes(NoticeDto dto) {
		
		if(biz.update(dto) > 0) {
			return "redirect:noticeSelectOne.do?notice_no="+dto.getNotice_no();
		}
		
		return "redirect:noticeUpdateForm.do?notice_no="+dto.getNotice_no();
	}
	
	@RequestMapping("/noticeDelete.do")
	public String delete(int notice_no) {
		
		if(biz.delete(notice_no) > 0) {
			return "redirect:noticeList_category.do?nowPage=" + 1;
		}
		
		return "redirect:noticeSelectOne.do?notice_no=" + notice_no;
	}
	
	@ResponseBody
	@RequestMapping("/noticeSumImg.do")
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
			path = WebUtils.getRealPath(request.getSession().getServletContext(), "/resources/noticeImg");

			File noticeimg = new File(path);
			if (!noticeimg.exists()) {
				noticeimg.mkdirs();
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
			e.printStackTrace();
		} finally {
			try {
				inputStream.close();
				outputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		String return_path = "resources/noticeImg/" + full_na;
		System.out.println(return_path);

		Map<String, String> map = new HashMap<String, String>();

		map.put("path", return_path);

		return map;
	}
	
	@ResponseBody
	@RequestMapping("/notice_popup.do")
	public Map<String, Boolean> noticepopup(@RequestBody String notice_no){
		System.out.println(notice_no);
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		notice_no = notice_no.split(":\"")[1].split("\"")[0];
		int no  = Integer.parseInt(notice_no);
		NoticeDto dto = biz.selectOne(no);
		dto.setNotice_popup(dto.getNotice_popup()==null?"Y":null);
		if(biz.popUpdate(dto)>0) {
			map.put("popup", true);
		}else {
			map.put("popup", false);
			
		}
		return map;
	}
	
	@RequestMapping("/noticepopup_open.do")
	public String noticepopupopen(Model model, int notice_no) {
		model.addAttribute("dto", biz.selectOne(notice_no));

		return "notice_detail_popup";
	}

	@ResponseBody
	@RequestMapping("/notice_popup_close.do")
	public Map<String, Boolean> noticepopupclose(HttpSession session){
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		session.setAttribute("popupclose", true);
		map.put("popup",true);
		return map;
	}
	
	
}
