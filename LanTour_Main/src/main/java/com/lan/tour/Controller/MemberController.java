package com.lan.tour.Controller;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;
import java.util.HashMap;

import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.lan.tour.model.biz.MemberBiz;
import com.lan.tour.model.dto.MemberDto;

@Controller
public class MemberController {

	@Autowired
	private MemberBiz biz;

	@Autowired
	private BCryptPasswordEncoder pwEncoder;

	@Autowired
	private JavaMailSender mailSender;

	// ---------------------------------------------
	// 로그인------------------------------------------
	@RequestMapping("/loginform.do")
	public String loginForm() {
		return "login";
	}

	@RequestMapping("/loginRedirect.do")
	public String loginRedirect() {
		return "login_redirect";
	}

	@ResponseBody
	@RequestMapping(value = "/loginCheck.do", method = RequestMethod.POST)
	public Map<String, Boolean> loginCheck(@RequestBody MemberDto dto, HttpSession session) {
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		MemberDto res = biz.idCheck(dto);
		boolean check = false;
		System.out.println(res);
		if (res != null) {
			if (pwEncoder.matches(dto.getMember_password(), res.getMember_password())) {
				session.setAttribute("login", res);
				check = true;
			}
		}
		map.put("check", check);
		return map;
	}

	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:main.do";
	}

	// ---------------------------------------------
	// 회원가입------------------------------------------
	// singup.do -> registerform.do 로 변경(회원가입 페이지로 가는것이 없음)
	@RequestMapping("/registselect.do")
	public String singup() {
		return "registselect";
	}

	@RequestMapping("/registerform.do")
	public String signupform() {
		// 회원 가입 페이지로 이동 (페이지 이름을 몰라서 register로 작성)
		return "singnup_general";
	}

	// 이메일 인증
	@ResponseBody
	@RequestMapping("/emailcheck.do")
	public Map<String, String> emailcheck(@RequestBody String email, HttpSession session) {
		email = email.split("\":\"")[1].split("\"")[0];
		Map<String, String> map = new HashMap<String, String>();
		if (biz.checkEmail(email) == null) {
			try {
				MimeMessage msg = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(msg, true, "UTF-8");
				int random = (int) (Math.random() * 10000);
				messageHelper.setSubject("[Lantour] 랜투어 회원가입 이메일 인증 메일입니다.");
				messageHelper.setText("인증번호는 " + random + " 입니다.");
				messageHelper.setTo(email);
				msg.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(email));
				mailSender.send(msg);
				map.put("success", "true");
				session.setMaxInactiveInterval(180);
				session.setAttribute("random", random);
			} catch (MessagingException e) {
				System.out.println("MessagingException");
				e.printStackTrace();
				map.put("error", "메일 발송에 실패했습니다.");
			} catch (Exception e) {
				e.printStackTrace();
				map.put("error", "메일 발송에 실패했습니다.");
			}
		} else {
			map.put("error", "이미 가입되어있는 메일입니다.");
		}
		return map;
	}

	@ResponseBody
	@RequestMapping("/emailrandomcheck.do")
	public Map<String, Boolean> emailrandomcheck(@RequestBody String random, HttpSession session) {
		random = random.split("\":\"")[1].split("\"")[0];
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		if (Integer.parseInt(random) == (int) session.getAttribute("random")) {
			map.put("result", true);
		}
		return map;
	}

	@RequestMapping("/registerhost.do")
	public String registerForm() {
		return "signup_host";

	}

	@ResponseBody
	@RequestMapping(value = "/idCheck.do", method = RequestMethod.POST)
	public Map<String, Boolean> idCheck(@RequestBody MemberDto dto) {
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		MemberDto res = biz.idCheck(dto);
		boolean check = false;

		System.out.println("----------------res 출력");
		System.out.println(res);

		if (res != null) {
			check = true;
		}

		map.put("check", check);

		System.out.println(map);
		return map;
	}

	@RequestMapping("/registerres.do")
	public String registerRes(MemberDto dto) {
		System.out.println(dto);

		System.out.println("암호화 전 : " + dto.getMember_password());
		dto.setMember_password(pwEncoder.encode(dto.getMember_password()));
		System.out.println("암호화 후 : " + dto.getMember_password());
		if (biz.insert(dto) > 0) {
			return "redirect:loginform.do";
		}
		return "redirect:registerform.do";
	}

	@RequestMapping("/memberlist.do")
	public String memberlist(Model model) {
		model.addAttribute("list", biz.memberList());
		return "member";

	}

	@RequestMapping("/memberupdate.do")
	public String update(int member_no, String member_grade) {
		MemberDto dto = new MemberDto();
		dto.setMember_no(member_no);
		dto.setMember_grade(member_grade);

		biz.memberupdate(dto);
		return "redirect:memberlist.do";
	}

	// 구글 로그인
	@ResponseBody
	@RequestMapping("/googleTokensignin.do")
	public String googleTokensign(String idtoken, HttpSession session) {
		MemberDto dto = googleTokenTest(idtoken);
		if (dto == null) {
			return "InvalidEmain";
		} else if (biz.idCheck(dto) == null) {
			if (biz.checkEmail(dto.getMember_email()) != null) {
				return "hasemail";
			} else {
				return "signup";

			}
		} else {
			MemberDto res = biz.idCheck(dto);
			if (pwEncoder.matches(dto.getMember_password(), res.getMember_password())) {
				session.setAttribute("login", res);
				return "login";
			}
		}
		return "invaild login";
	}

	@RequestMapping("/googlesignup.do")
	public String googlesignup(Model model, String idtoken) {
		model.addAttribute("idtoken", idtoken);
		return "singnup_google";
	}

	@RequestMapping("/googlesignupres.do")
	public String googlesignupres(Model model, HttpSession session, String idtoken, MemberDto dto) {
		MemberDto Tokendto = googleTokenTest(idtoken);
		dto.setMember_id(Tokendto.getMember_id());
		dto.setMember_password(pwEncoder.encode(Tokendto.getMember_password()));
		dto.setMember_email(Tokendto.getMember_email());
		dto.setMember_name(Tokendto.getMember_name());
		if (biz.insert(dto) > 0) {
			session.setAttribute("login", biz.idCheck(dto));

			return "redirect:main.do";
		}
		model.addAttribute(idtoken, idtoken);
		return "redirect:googleTokensignin.do";
	}

	public MemberDto googleTokenTest(String idtoken) {
		MemberDto dto = null;
		GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new GsonFactory())
				// Specify the CLIENT_ID of the app that accesses the backend:
				.setAudience(Collections
						.singletonList("869891537807-u606s04umnomhs5tg7sufpd9c5g7fv6a.apps.googleusercontent.com"))
				// Or, if multiple clients access the backend:
				// .setAudience(Arrays.asList(CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3))
				.build();

		// (Receive idTokenString by HTTPS POST)

		GoogleIdToken idToken = null;
		try {
			idToken = verifier.verify(idtoken);
		} catch (GeneralSecurityException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (idToken != null) {
			Payload payload = idToken.getPayload();

			// Print user identifier
			String userId = payload.getSubject();
			System.out.println("User ID: " + userId);

			// Get profile information from payload
			String email = payload.getEmail();
			boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
			String name = (String) payload.get("name");
			// Use or store profile information
			// ...
			if (emailVerified) {
				dto = new MemberDto(0, userId, name, "google", "U", 0, null, email, null, "N", 0, null);
			}

		} else {
			System.out.println("Invalid ID token.");
		}

		return dto;
	}

	@RequestMapping("/naverlogin.do")
	public String naverlogin() {
		return "naver_redirect";
	}

	@RequestMapping("/naverloginres.do")
	public String naverloginres(MemberDto dto, Model model, HttpSession session) {
		MemberDto login = biz.idCheck(dto);

		if (login != null) {
			session.setAttribute("login", login);
			return "redirect:main.do";
		}
		model.addAttribute("dto", dto);
		return "signup_naver";
	}
	
	@RequestMapping("/naversingupres.do")
	public String naversignupres(MemberDto dto ,Model model , HttpSession session) {
		if(biz.insert(dto) > 0) {
			session.setAttribute("login", biz.idCheck(dto));
			return "redirect:main.do";
		}
		return "redirect:loginform.do";
	}
}