package com.lan.tour.Controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
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

import com.lan.tour.model.biz.HotelBiz;
import com.lan.tour.model.biz.ReservationBiz;
import com.lan.tour.model.biz.RoomBiz;
import com.lan.tour.model.dto.RoomDto;

@Controller
public class RoomController {

	@Autowired
	private HotelBiz Hbiz;
	
	@Autowired
	private RoomBiz biz;
	
	@Autowired
	private ReservationBiz biz2;

	@RequestMapping("/roominsert.do")
	public String roominsert(int hotel_no, Model model) {
		model.addAttribute("hotel_no", hotel_no);
		return "roominsert";
	}

	@RequestMapping("/roominsertres.do")
	public String roominsertres(RoomDto dto) {
		if (biz.insert(dto) > 0) {
			return "redirect:hoteldetail.do?hotel_no=" + dto.getHotel_no();
		}
		return "redirect:roominsert.do?hotel_no=" + dto.getHotel_no();
	}

	@ResponseBody
	@RequestMapping("/roomdelete.do")
	public Map<String, Boolean> roomdelete(int room_no) {
		Boolean check = false;
		if (biz.delete(room_no) > 0) {
			check = true;
		}
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("check", check);

		return map;
	}

	@ResponseBody
	@RequestMapping("/roomupload.do")
	public Map<String, String> roomupload(@RequestParam("mpfile") MultipartFile file, HttpServletRequest request) {
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

			path = WebUtils.getRealPath(request.getSession().getServletContext(), "/resources/roomimg");
			File roomimg = new File(path);
			if (!roomimg.exists()) {
				roomimg.mkdirs();
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
		String return_path = "resources/roomimg/" + full_na;
		System.out.println(return_path);

		Map<String, String> map = new HashMap<String, String>();

		map.put("path", return_path);

		return map;
	}

	@RequestMapping("/roomdetail.do")
	public String roomdetail(Model model, int room_no) {
		RoomDto dto = biz.selectOne(room_no);
		model.addAttribute("hotel", Hbiz.selectOne(dto.getHotel_no()));
		model.addAttribute("dto", dto);
		model.addAttribute("ResDto", biz2.selectList("hotel", dto.getHotel_no(), room_no));

		return "roomdetail";
	}
}
