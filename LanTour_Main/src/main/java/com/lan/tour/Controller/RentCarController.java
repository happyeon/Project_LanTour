package com.lan.tour.Controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;


@Controller
public class RentCarController {

	private String[] content;
	private String cartype;
	private String searchtype;
	private String rentcar = "rentcar_";
	

	@RequestMapping("/rentCarSearch.do")
	public String rentCarSearch() {

		return rentcar+"search";
	}
	

	@RequestMapping("/rentCarList.do")
	public String rentCarList(Model model, String searchtype,String content, String cartype) {
		if(!content.equals("")) {
			this.content = content.split(" ");
			model.addAttribute("content", content);
		}else {
			this.content=null;
		}
		if(!cartype.equals("")) {
			this.cartype = cartype;
			model.addAttribute("cartype", cartype);
		}else {
			this.cartype=null;
		}
		if(!searchtype.equals("")) {
			this.searchtype = searchtype;
			model.addAttribute("searchtype", searchtype);
		}else {
			this.searchtype=null;
		}
		
		
		
		try {
			model.addAttribute("list", getXMLElement(getCarRental()));
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		return rentcar+"list";
	}
	
	

    public List<Map<String, String>> getXMLElement(String xml) {
    	List<Map<String, String>> list = new ArrayList<Map<String, String>>();
    	 DocumentBuilderFactory factory  =  DocumentBuilderFactory.newInstance();
		try {
			DocumentBuilder builder = factory.newDocumentBuilder();
	    	 Document document = builder.parse(new InputSource(new StringReader(xml)));
	    	 NodeList nodelist = document.getElementsByTagName("item");
	    	 for(int i = 0; i<nodelist.getLength();i++) {
		    	 Map<String, String > map  = new HashMap<String, String>();
		    	 NodeList nodec = nodelist.item(i).getChildNodes();
		    	 for(int j = 0; j<nodec.getLength();j++) {
		    		 if(nodec.item(j).getChildNodes().item(0)!=null) {
		    			 String value = nodec.item(j).getChildNodes().item(0).getNodeValue();
			    		 map.put(nodec.item(j).getNodeName(), value);		    			 
		    		 }
		    	 }
		    	 if(content!=null) {
			    	 if(map.get(searchtype) != null) {
			    		 int k = 0;
			    		 for(int j = 0; j<content.length;j++) {
				    		 if(map.get(searchtype).indexOf(content[j])>=0) {
				    			 k++;
					    	 } 
			    		 }
			    		 if(k==content.length) {
			    			 if(cartype !=null){
				    			 if(map.get(cartype)!=null) {
					    			 if(Integer.parseInt(map.get(cartype))>0) {
					    				 list.add(map);	 
					    			 }   		 
				    			 }			    				 
			    			 }else {
			    				 list.add(map);	 
			    			 }
			    		 }
			    	 }
		    	 }else {
	    			 if(cartype !=null){
		    			 if(map.get(cartype)!=null) {
			    			 if(Integer.parseInt(map.get(cartype))>0) {
			    				 list.add(map);	 
			    			 }   		 
		    			 }			    				 
	    			 }else {
	    				 list.add(map);	 
	    			 }
		    	 }
	    	 }
	    	 
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return list;
    }

	 public String getCarRental() throws IOException {
	        StringBuilder urlBuilder = new StringBuilder("http://api.data.go.kr/openapi/tn_pubr_public_car_rental_api"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=ycEFiYcdm4Rmzb0Ghr%2FvOIQEhPbcHO5HhztZMrksr1GP%2FRuf4uus9ogb4SJairtnLSYmxMuWn65moOzT%2FN4EuQ%3D%3D"); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("0", "UTF-8")); /*페이지 번호*/
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("5400", "UTF-8")); /*한 페이지 결과 수*/
	        urlBuilder.append("&" + URLEncoder.encode("type","UTF-8") + "=" + URLEncoder.encode("xml", "UTF-8")); /*XML/JSON 여부*/
        
//	        urlBuilder.append("&" + URLEncoder.encode("entrpsNm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*업체명*/
//	        urlBuilder.append("&" + URLEncoder.encode("bplcType","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*사업장구분*/
//	        urlBuilder.append("&" + URLEncoder.encode("rdnmadr","UTF-8") + "=" + URLEncoder.encode("18*", "UTF-8")); /*소재지도로명주소*/
//	        urlBuilder.append("&" + URLEncoder.encode("lnmadr","UTF-8") + "=" + URLEncoder.encode("서울", "UTF-8")); /*소재지지번주소*/
//	        urlBuilder.append("&" + URLEncoder.encode("latitude","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*위도*/
//	        urlBuilder.append("&" + URLEncoder.encode("longitude","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*경도*/
//	        urlBuilder.append("&" + URLEncoder.encode("garageRdnmadr","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*차고지도로명주소*/
//	        urlBuilder.append("&" + URLEncoder.encode("garageLnmadr","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*차고지지번주소*/
//	        urlBuilder.append("&" + URLEncoder.encode("garageAceptncCo","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*보유차고지수용능력*/
//	        urlBuilder.append("&" + URLEncoder.encode("vhcleHoldCo","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*자동차총보유대수*/
//	        urlBuilder.append("&" + URLEncoder.encode("carHoldCo","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*승용차보유대수*/
//	        urlBuilder.append("&" + URLEncoder.encode("vansHoldCo","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*승합차보유대수*/
//	        urlBuilder.append("&" + URLEncoder.encode("eleCarHoldCo","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*전기승용자동차보유대수*/
//	        urlBuilder.append("&" + URLEncoder.encode("eleVansCarHoldCo","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*전기승합자동차보유대수*/
//	        urlBuilder.append("&" + URLEncoder.encode("lghvhclChrge","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*경차요금*/
//	        urlBuilder.append("&" + URLEncoder.encode("cmhvhclChrge","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*소형차요금*/
//	        urlBuilder.append("&" + URLEncoder.encode("mdhvhclChrge","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*중형차요금*/
//	        urlBuilder.append("&" + URLEncoder.encode("lgshvhclChrge","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*대형차요금*/
//	        urlBuilder.append("&" + URLEncoder.encode("vahvhclChrge","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*승합차요금*/
//	        urlBuilder.append("&" + URLEncoder.encode("lshvhclChrge","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*레저용차요금*/
//	        urlBuilder.append("&" + URLEncoder.encode("imhvhclChrge","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*수입차요금*/
//	        urlBuilder.append("&" + URLEncoder.encode("weekdayOperOpenHhmm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*평일운영시작시각*/
//	        urlBuilder.append("&" + URLEncoder.encode("weekdayOperColseHhmm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*평일운영종료시각*/
//	        urlBuilder.append("&" + URLEncoder.encode("wkendOperOpenHhmm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*주말운영시작시각*/
//	        urlBuilder.append("&" + URLEncoder.encode("wkendOperCloseHhmm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*주말운영종료시각*/
//	        urlBuilder.append("&" + URLEncoder.encode("holidayOperOpenHhmm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*공휴일운영시작시각*/
//	        urlBuilder.append("&" + URLEncoder.encode("holidayCloseOpenHhmm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*공휴일운영종료시각*/
//	        urlBuilder.append("&" + URLEncoder.encode("rstde","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*휴무일*/
//	        urlBuilder.append("&" + URLEncoder.encode("homepageUrl","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*홈페이지주소*/
//	        urlBuilder.append("&" + URLEncoder.encode("rprsntvNm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*대표자명*/
//	        urlBuilder.append("&" + URLEncoder.encode("phoneNumber","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*전화번호*/
//	        urlBuilder.append("&" + URLEncoder.encode("referenceDate","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*데이터기준일자*/
//	        urlBuilder.append("&" + URLEncoder.encode("instt_code","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*제공기관코드*/
//	        urlBuilder.append("&" + URLEncoder.encode("instt_nm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*제공기관기관명*/
//	        
	        
	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        System.out.println("Response code: " + conn.getResponseCode());
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        rd.close();
	        conn.disconnect();	        
	        return sb.toString();
	    }
	
}
