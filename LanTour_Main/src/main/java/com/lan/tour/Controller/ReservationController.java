package com.lan.tour.Controller;


import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lan.tour.model.biz.HotelBiz;
import com.lan.tour.model.biz.LantourBiz;
import com.lan.tour.model.biz.MemberBiz;
import com.lan.tour.model.biz.ReservationBiz;
import com.lan.tour.model.biz.RoomBiz;
import com.lan.tour.model.dto.HotelDto;
import com.lan.tour.model.dto.LantourDto;
import com.lan.tour.model.dto.MemberDto;
import com.lan.tour.model.dto.ReservationDto;
import com.lan.tour.model.dto.RoomDto;

import oracle.net.aso.p;

@Controller
public class ReservationController {

	@Autowired
	MemberBiz Mbiz;
	
	@Autowired
	HotelBiz Hbiz;

	@Autowired
	RoomBiz Roobiz;
	
	@Autowired
	LantourBiz Lbiz;
	
	@Autowired
	ReservationBiz Resbiz;
	
	@Autowired
	private JavaMailSender mailSender;
	
	
	@RequestMapping("reservation.do")
	public String reservation(Model model, String type, int no, int rno, String check_in, String check_out) {
		
		
		if(type.equals("lantour")) {
			Map<String, Integer> map = new HashMap<String, Integer>();
			LantourDto Ldto = Lbiz.selectOne(no);
			if(Ldto.getLantour_date().indexOf(',')>0){
				for(int i = 0; i < Ldto.getLantour_date().split(",").length ; i++){
					map.put(Ldto.getLantour_date().split(",")[i], Resbiz.countDate(Ldto.getLantour_date().split(",")[i], no).size());
				}
			}
			model.addAttribute("map", map);
			model.addAttribute("lantourDto", Ldto);
			model.addAttribute("ResDto", Resbiz.selectList(type, no, 0));
			model.addAttribute("check_in", check_in);
		}else {
			model.addAttribute("ResDto", Resbiz.selectList(type, no, rno));
			model.addAttribute("HotelDto", Hbiz.selectOne(no));
			model.addAttribute("RoomDto", Roobiz.selectOne(rno));
			model.addAttribute("check_in", check_in);
			model.addAttribute("check_out", check_out);
		}
		return "reservation_insert";
	}
	@RequestMapping("insertReservation.do")
	public String InertReservation(int no, int rno, int member_no, String reservation_date, String reservation_checkout_date,int reservation_price ) {
		
		ReservationDto dto = new ReservationDto(0, no, rno, no, member_no, reservation_date,reservation_checkout_date ,reservation_price, "N", null , 0 , null); 
		Resbiz.insert(dto);
		return "redirect:reservationdetail.do";
	}
	
	@RequestMapping("reservationdetail.do")
	public String reservationDetail(Model model, HttpSession session) {
		MemberDto Mdto =(MemberDto)session.getAttribute("login");
		int m_no = Mdto.getMember_no();
		ReservationDto resdto = Resbiz.selectList(m_no).get(0);
		if(resdto.getRoom_no()==0) {
			model.addAttribute("date", Resbiz.countDate(resdto.getReservation_date(),resdto.getLantour_no()).size());
			model.addAttribute("Ldto", Lbiz.selectOne(resdto.getLantour_no()));
		}else {
			model.addAttribute("Hdto", Hbiz.selectOne(resdto.getHotel_no()));
			model.addAttribute("Roodto", Roobiz.selectOne(resdto.getRoom_no()));
		}
		model.addAttribute("Resdto", resdto);
		return "reservation_detail";
	}
	@RequestMapping("reservation_detail_one.do")
	public String reservationDetailOne(Model model, HttpSession session, int no) {
		ReservationDto dto = Resbiz.selectOne(no);
		if(dto.getRoom_no()==0) {
			model.addAttribute("date", Resbiz.countDate(dto.getReservation_date(),dto.getLantour_no()).size());
			model.addAttribute("Ldto", Lbiz.selectOne(dto.getLantour_no()));
		}else {
			model.addAttribute("Hdto", Hbiz.selectOne(dto.getHotel_no()));
			model.addAttribute("Roodto", Roobiz.selectOne(dto.getRoom_no()));
			
		}
		model.addAttribute("Resdto", dto);
		return "reservation_detail";
	}
	
	@RequestMapping("reservation_pay.do")
	public String reservationPay(int no, String m_id,HttpSession session) {
		ReservationDto dto = new ReservationDto();
		dto.setReservation_no(no);
		dto.setReservation_pay(m_id);
		MemberDto mdto = (MemberDto)session.getAttribute("login");
		if(Resbiz.updatepay(dto)>0) {
			sendEmail(mdto.getMember_email(), Resbiz.selectOne(no));
			return "redirect:reservation_detail_one.do?no="+no;
		}
		return "test";
	}	
	
	@RequestMapping("canclepay.do")
	public String canclepay(int no, String id) {
		String cancleurl = "https://api.iamport.kr/payments/cancel?_token="+getToken();
		
		String res = null;
		try {
			URL url = new URL(cancleurl);
			HttpsURLConnection httpsConn = (HttpsURLConnection) url.openConnection();
			String param = "merchant_uid="+id+"&reason="+"고객요청";
			httpsConn.setRequestMethod("POST");			
			httpsConn.setDoOutput(true);              //항상 갱신된내용을 가져옴.
	        DataOutputStream wr = new DataOutputStream(httpsConn.getOutputStream());
	        wr.writeBytes(param);
	        wr.flush();
	        wr.close();
	        Charset charset = Charset.forName("UTF-8");
	        BufferedReader in = new BufferedReader(new InputStreamReader(httpsConn.getInputStream(),charset));
	        String inputLine;
	        StringBuffer response = new StringBuffer();

	        while ((inputLine = in.readLine()) != null) {
	            response.append(inputLine);
	        }
	        in.close();
	        System.out.println(response.toString());
	        res = response.toString().split("\"status\":\"")[1].split("\",\"user_agent\":")[0];
		}catch (Exception e) {
			e.printStackTrace();
		}
		if(res.equals("cancelled")) {
			ReservationDto dto = new ReservationDto();
			dto.setReservation_no(no);
			dto.setReservation_pay(res);	
			Resbiz.updatepay(dto);
		}
		
		return "redirect:reservation_detail_one.do?no="+no;
	}
	public static String getToken() {
		String tokenurl = "https://api.iamport.kr/users/getToken";
		String imp_key = "4930579507136379";
		String imp_secret = "74K6QUViRgnmYkRY41kGk2B5nZW727Dacog2jckasIwr2oq7qKNLNoRaoNhqVVA7kR9D3uOvckXfJnma";
		
		String res = null;
		try {
			URL url = new URL(tokenurl);
			HttpsURLConnection httpsConn = (HttpsURLConnection) url.openConnection();
			String param = "imp_key="+imp_key+"&imp_secret="+imp_secret;
			httpsConn.setRequestMethod("POST");			
			httpsConn.setDoOutput(true);              //항상 갱신된내용을 가져옴.
	        DataOutputStream wr = new DataOutputStream(httpsConn.getOutputStream());
	        wr.writeBytes(param);
	        wr.flush();
	        wr.close();
	        Charset charset = Charset.forName("UTF-8");
	        BufferedReader in = new BufferedReader(new InputStreamReader(httpsConn.getInputStream(),charset));
	        String inputLine;
	        StringBuffer response = new StringBuffer();

	        while ((inputLine = in.readLine()) != null) {
	            response.append(inputLine);
	        }
	        in.close();
	        res = response.toString().split("\"access_token\":\"")[1].split("\",\"now\":")[0];
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping("payments.do")
	public Map<String, String> payment(String imp_uid) {
		String status = "";
		try {
			String access_token = getToken();
	        String payurl = "https://api.iamport.kr/payments/"+imp_uid+"?_token="+access_token;
	        URL url = new URL(payurl);
			String param = "token="+access_token;
			HttpsURLConnection httpsConn = (HttpsURLConnection) url.openConnection();
			httpsConn.setRequestMethod("GET");
	        
	        int responseCode = httpsConn.getResponseCode();
	        Charset charset = Charset.forName("UTF-8");
	        BufferedReader in = new BufferedReader(new InputStreamReader(httpsConn.getInputStream(),charset));
	        StringBuffer response = new StringBuffer();
	        String inputLine;
	        
	        while ((inputLine = in.readLine()) != null) {
	            response.append(inputLine);
	        }
	        in.close();
	        status = response.toString().split("\"status\":\"")[1].split("\",\"user_agent\"")[0];// status (string): 결제상태. ready:미결제, paid:결제완료, cancelled:결제취소, failed:결제실패 = ['ready', 'paid', 'cancelled', 'failed']
		}catch (Exception e) {
			e.printStackTrace();
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("status", status);
		return map;
	}
	
	
	public void sendEmail(String email, ReservationDto dto) {
		String title = null;
		String img = null;
		String date =null;
		if(dto.getRoom_no()==0) {
			LantourDto Ldto = Lbiz.selectOne(dto.getLantour_no());
			title = Ldto.getLantour_title();
			img = Ldto.getLantour_image();
			date = dto.getReservation_date();
		}else {
			HotelDto Hdto = Hbiz.selectOne(dto.getHotel_no());
			RoomDto Rdto = Roobiz.selectOne(dto.getRoom_no());
			title = Hdto.getHotel_title()+"-"+Rdto.getRoom_name();
			img = Rdto.getRoom_image();
			date = dto.getReservation_date()+"~"+dto.getReservation_checkout_date();
		}
		
		String text = null;
			text="			<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"*width:740px; max-width:740px; min-width:230px;\" bgcolor=\"ebedef\">\r\n"
					+ "				<tbody><!-- header --><tr><td style=\"max-width:740px; min-width:230px; margin:0 auto;\" colspan=\"2\" bgcolor=\"aliceblue\">\r\n"
					+ "							<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\r\n"
					+ "								<tbody><tr><td width=\"5%\">&nbsp;</td><td>\r\n"
					+ "											<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\r\n"
					+ "												<tbody><tr><td align=\"left\" height=\"23\"><img src=\"https://ec2-3-144-4-252.us-east-2.compute.amazonaws.com:8443/tour/resources/assets/img/gallery/logo-icon.png\" width=\"25\" height=\"25\" border=\"0\" alt=\"LanTour\" loading=\"lazy\"><h1 style=\"color:#3984F3; display: contents;\">Lantour</h1></td></tr></tbody>\r\n"
					+ "											</table>\r\n"
					+ "										</td><td width=\"5%\">&nbsp;</td></tr></tbody>\r\n"
					+ "							</table>\r\n"
					+ "						</td></tr><!-- header --><!-- container --><tr><td style=\"max-width:740px; min-width:230px; margin:0 auto;\">\r\n"
					+ "							<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\r\n"
					+ "								<tbody><tr><td>\r\n"
					+ "										<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\r\n"
					+ "											<tbody><tr><td height=\"28\" colspan=\"3\">&nbsp;</td></tr>\r\n"
					+ "											<tr><td width=\"5%\"></td><td align=\"left\" valign=\"top\" style=\"text-align:left; letter-spacing:-3px; line-height:38px; font-family:'맑은 고딕', SDNeoGothic, SDGothicNeo, '돋움', sans-serif;  font-size:30px; font-weight:bold;color:#1d1d1d;\">LanTour 컨텐츠 결제 안내</td><td width=\"5%\"></td></tr>\r\n"
					+ "											<tr><td colspan=\"3\" height=\"4\"></td></tr>\r\n"
					+ "											<tr><td width=\"5%\"></td><td align=\"left\" valign=\"top\" style=\"text-align:left; line-height:20px;  letter-spacing:-0.1px;font-size:14px; font-family:'맑은 고딕', SDNeoGothic, SDGothicNeo, '돋움', sans-serif; color:#999;\">결제일자 : "+dto.getReservation_paydate()+" </td><td width=\"5%\"></td></tr>\r\n"
					+ "											<tr><td height=\"30\" colspan=\"3\">&nbsp;</td></tr>\r\n"
					+ "										</tbody></table>\r\n"
					+ "										<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" bgcolor=\"ffffff\">\r\n"
					+ "											<tbody><tr><td width=\"5%\" bgcolor=\"ebedef\"></td><td>\r\n"
					+ "														<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\r\n"
					+ "															<tbody><tr><td height=\"25\" colspan=\"3\"></td></tr><tr><td width=\"5%\"></td><td>\r\n"
					+ "																		<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\r\n"
					+ "																			<tbody><tr><td align=\"left\" valign=\"top\" style=\"text-align:left; letter-spacing:-0.8px; line-height:20px;text-align: center; font-size:14px;font-family:'맑은 고딕', SDNeoGothic, SDGothicNeo, '돋움', sans-serif;color:#333;\">																			랜투어 결제 내역 안내를 다음과 같이 알려드립니다.</td></tr><tr><td height=\"19\"></td></tr><tr><td align=\"left\" valign=\"top\" style=\"text-align:left; letter-spacing:-1px; line-height:30px; font-weight: bold;  font-size:16px; font-family:'맑은 고딕', SDNeoGothic, SDGothicNeo, '돋움', sans-serif; color:#1d1d1d;\">\r\n"
					+ "																			<img style=\"width: 100%; height: 300px\" alt=\"이미지\" src=\"https://ec2-3-144-4-252.us-east-2.compute.amazonaws.com:8443/tour/"+img+"\">																		\r\n"
					+ "																			"+title+"</td></tr><tr><td height=\"13\"></td></tr><tr><td valign=\"top\">\r\n"
					+ "																						<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"border-top:1px solid #d5d5d5; border-bottom:1px solid #d5d5d5;\">\r\n"
					+ "																							<thead><tr><td align=\"center\" valign=\"middle\" style=\"font-size:14px;font-weight: bold;color: #333;\" height=\"52\">가격</td><td width=\"20px\"></td><td align=\"center\" valign=\"middle\" width=\"37%\" style=\"font-size:14px;font-weight: bold;color: #333;\">예약일자</td><td width=\"20px\"></td><td align=\"center\" valign=\"middle\" width=\"37%\" style=\"font-size:14px;font-weight: bold;color: #333;\">진행상태</td></tr></thead>\r\n"
					+ "																							<tbody><!-- 1 --><tr><td align=\"left\" valign=\"top\" style=\" font-size:14px; padding:17px 0 17px; letter-spacing: -0.8px; border-top:1px dotted #d5d5d5; color:#666;line-height:20px;text-align: center;\">"+dto.getReservation_price()+"원</td><td rowspan=\"3\"></td><td align=\"left\" valign=\"top\" style=\" font-size:14px; padding:17px 0 17px; letter-spacing: -0.8px; border-top:1px dotted #d5d5d5; color:#666;line-height:20px;text-align: center;\">"+date+"\r\n"
					+ "</td><td rowspan=\"3\"></td><td align=\"left\" valign=\"top\" rowspan=\"2\" style=\" font-size:14px; padding:17px 0 17px; letter-spacing: -0.8px; border-top:1px dotted #d5d5d5; color:#666;line-height:20px;text-align: center;\">결제완료</td></tr></tbody>\r\n"
					+ "																						</table>\r\n"
					+ "																					</td></tr><tr><td height=\"16\"></td></tr><tr><td>\r\n"
					+ "																						<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\r\n"
					+ "																							<tbody><tr><td align=\"left\" style=\"letter-spacing:-0.4px;  font-size:14px;color:#666;word-break: keep-all;vertical-align:top;line-height:22px;\" width=\"10\">-</td><td align=\"left\" valign=\"top\" style=\"text-align:left; letter-spacing:-0.8px; line-height:19px; font-size:14px;font-family:'맑은 고딕', SDNeoGothic, SDGothicNeo, '돋움', sans-serif;color:#666;word-break: keep-all;\">예약일로부터 7일 전에는 상시 환불처리 가능하며 7일 이내에는 직접 호스트에 연락하여 환불조치해주셔야 합니다.\r\n"
					+ "																							<br/>자세한 내용은 랜투어 홈페이지(https://ec2-3-144-4-252.us-east-2.compute.amazonaws.com:8443/main.do) 참조</td></tr>\r\n"
					+ "																						</tbody></table>\r\n"
					+ "																					</td></tr><tr><td height=\"27\"></td></tr></tbody>\r\n"
					+ "																		</table>\r\n"
					+ "																	</td><td width=\"5%\"></td></tr></tbody>\r\n"
					+ "														</table>\r\n"
					+ "													</td><td width=\"5%\" bgcolor=\"ebedef\"></td></tr></tbody>\r\n"
					+ "										</table>\r\n"
					+ "									</td></tr>\r\n"
					+ "							</tbody></table>\r\n"
					+ "						</td></tr><!-- //container --><tr><td></td></tr><!-- footer --><tr><td style=\"max-width:740px; min-width:230px; margin:0 auto;\">\r\n"
					+ "							<!-- 하단 안내글 시작 -->\r\n"
					+ "							<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\r\n"
					+ "								<tbody><tr><td height=\"50\">&nbsp;</td></tr>\r\n"
					+ "							</tbody></table>\r\n"
					+ "							<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\r\n"
					+ "								<tbody><tr><td width=\"5%\" rowspan=\"5\">&nbsp;</td><td height=\"20\" style=\"border-top:1px solid #cfcfcf;\">&nbsp;</td><td width=\"5%\" rowspan=\"5\">&nbsp;</td></tr><tr><td align=\"left\" style=\"line-height:18px; font-family:'돋움', dotum;  font-size:11px; color:#9e9e9e;\">본 메일은 발신전용 메일이므로 회신이 되지 않습니다.<br>문의사항은 <a href=\"https://ec2-3-144-4-252.us-east-2.compute.amazonaws.com:8443/tour/main.do\" target=\"_blank\" style=\"line-:18px; font-family:'돋움', dotum;  font-size:11px; color:#696d70;\" rel=\"noreferrer noopener\">홈페이지 고객센터</a> 또는 <span style=\"line-height:18px; font-family:'돋움', dotum;  font-size:11px; color:#696d70;\">ARS 고객센터 010-7791-5161</span>을 이용하시기 바랍니다.</td></tr><tr><td height=\"18\">&nbsp;</td></tr><tr><td align=\"left\" style=\"line-height:18px; font-family:'돋움', dotum;  font-size:11px; color:#777;\">서울특별시 000구 000로 00빌딩 팀 놀러가조 </td></tr><tr><td height=\"40\">&nbsp;</td></tr></tbody>\r\n"
					+ "							</table>\r\n"
					+ "							<!-- //하단 안내글 끝 -->\r\n"
					+ "						</td></tr><!-- //footer --></tbody>\r\n"
					+ "			</table>";
		
		
		
		try {
	        MimeMessage msg = mailSender.createMimeMessage();
	        MimeMessageHelper messageHelper = new MimeMessageHelper(msg, true, "UTF-8");
	        messageHelper.setSubject("[Lantour] 랜투어 결제완료 메일입니다.");
	        messageHelper.setText(text,true);
	        messageHelper.setTo(email);
	        msg.setRecipients(MimeMessage.RecipientType.TO , InternetAddress.parse(email));
	        mailSender.send(msg);
	    }catch(MessagingException e) {
	        System.out.println("MessagingException");
	        e.printStackTrace();
	    }	
		
	}
}
