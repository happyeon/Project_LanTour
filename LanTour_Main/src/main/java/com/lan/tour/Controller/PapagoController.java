package com.lan.tour.Controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PapagoController {

	private String clientId = "NiPSHx6Om9O_VYFPHn9A";
	private String clientSecret = "F85TDravFu";

	@ResponseBody
	@RequestMapping("/papagolang.do")
	public Map<String, String> papagolang(String papagolang, String target) {

		if (!papagolang.isEmpty()) {
			String query;
			try {
				query = URLEncoder.encode(papagolang, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO: handle exception
				throw new RuntimeException("인코딩 실패", e);
			}

			String url = "https://openapi.naver.com/v1/papago/detectLangs";
			Map<String, String> request = new HashMap<String, String>();
			request.put("X-Naver-Client-Id", clientId);
			request.put("X-Naver-Client-Secret", clientSecret);

			String response = "";
			HttpURLConnection con = null;
			try {
				URL apiUrl = new URL(url);
				con = (HttpURLConnection) apiUrl.openConnection();
			} catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				throw new RuntimeException("API URL이 잘못되었습니다. : " + url, e);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				throw new RuntimeException("연결이 실패했습니다. : " + url, e);
			}

			String postParams = "query = " + query;

			try {
				con.setRequestMethod("POST");
				for (Map.Entry<String, String> header : request.entrySet()) {
					con.setRequestProperty(header.getKey(), header.getValue());
				}
				con.setDoOutput(true);

				try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {
					wr.write(postParams.getBytes());
					wr.flush();
				}

				int reponseCode = con.getResponseCode();
				if (reponseCode == HttpURLConnection.HTTP_OK) {
					InputStreamReader streamReader = new InputStreamReader(con.getInputStream());
					try (BufferedReader lineReader = new BufferedReader(streamReader)) {
						StringBuilder responseBody = new StringBuilder();

						String line;
						while ((line = lineReader.readLine()) != null) {
							responseBody.append(line);
						}

						response = responseBody.toString();
					} catch (IOException e) {
						throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
					}
				} else {

				}
			} catch (Exception e) {
				// TODO: handle exception
			}

			String source = response.substring(13, response.length() - 2);
			Map<String, String> map = new HashMap<String, String>();
			if(!source.equals(target)) {
				map.put("lang", transpapago(papagolang, source, target));
			}
			return map;
		}
		return null;
	}

	public String transpapago(String papagolang, String source, String target) {
		String apiURL = "https://openapi.naver.com/v1/papago/n2mt";
		String response = "";
		String text;
		try {
			text = URLEncoder.encode(papagolang, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException("인코딩 실패", e);
		}

		Map<String, String> requestHeaders = new HashMap<>();
		requestHeaders.put("X-Naver-Client-Id", clientId);
		requestHeaders.put("X-Naver-Client-Secret", clientSecret);

		HttpURLConnection con = null;
		try {
			URL url = new URL(apiURL);
			con = (HttpURLConnection) url.openConnection();
		} catch (MalformedURLException e) {
			throw new RuntimeException("API URL이 잘못되었습니다. : " + apiURL, e);
		} catch (IOException e) {
			throw new RuntimeException("연결이 실패했습니다. : " + apiURL, e);
		}

		String postParams = "source=" + source + "&target=" + target + "&text=" + text;

		try {
			con.setRequestMethod("POST");
			for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
				con.setRequestProperty(header.getKey(), header.getValue());
			}

			con.setDoOutput(true);
			try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {
				wr.write(postParams.getBytes());
				wr.flush();
			}

			int responseCode = con.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 응답
				InputStreamReader streamReader = new InputStreamReader(con.getInputStream());

				try (BufferedReader lineReader = new BufferedReader(streamReader)) {
					StringBuilder responseBody = new StringBuilder();

					String line;
					while ((line = lineReader.readLine()) != null) {
						responseBody.append(line);
					}

					response = responseBody.toString();
				} catch (IOException e) {
					throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		int start = response.indexOf("translatedText") + 17;
		int end = response.indexOf("engineType") - 3;

		return response.substring(start, end);
	}
}
