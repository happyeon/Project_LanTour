package com.lan.tour.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import java.io.BufferedReader;
import java.io.IOException;

@Controller
public class AirplaneController {

	private String time1;
	private String time2;
	
	@RequestMapping("/airportSearch.do")
	public String airportSearch(Model model) {
		try {
			model.addAttribute("list", getXMLElement(getArprtList()) );
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "airplane_search";
	}
	

	@RequestMapping("/airplaneList.do")
	public String airplaneList(Model model, String depAirportId, String arrAirportId, String date, String time) {
		if(!time.equals("")) {
			this.time1 = time.substring(0,4);
			this.time2 = time.substring(4);
		}else {
			this.time1=null;
			this.time2=null;
		}
		
		try {
			model.addAttribute("portlist", getXMLElement(getArprtList()) );
			model.addAttribute("planelist", getXMLElement(getFlightOpratInfoList(300, 1, depAirportId, arrAirportId, date.replaceAll("-", ""))));
			model.addAttribute("date", date);
			model.addAttribute("depAirportId", depAirportId);
			model.addAttribute("arrAirportId", arrAirportId);
			model.addAttribute("time", time);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "airplane_list";
	}
	
	//공항 조회 메소드
	 public String getArprtList() throws IOException {
	        StringBuilder urlBuilder = new StringBuilder("http://openapi.tago.go.kr/openapi/service/DmstcFlightNvgInfoService/getArprtList"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=ycEFiYcdm4Rmzb0Ghr/vOIQEhPbcHO5HhztZMrksr1GP/Ruf4uus9ogb4SJairtnLSYmxMuWn65moOzT/N4EuQ=="); /*Service Key*/
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
	        /* response 
	         * airportId : 공항 아이디
	         * airportNm : 공항 이름
	         */
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        rd.close();
	        conn.disconnect();
	        
	        return sb.toString();
	        
	    }
	
	
	
	// 항공편 조회 메소드
    public String getFlightOpratInfoList(int numOfRows, int pageNo, String depAirportId, String arrAirportId, String depPlandTime) throws IOException {
        StringBuilder urlBuilder = new StringBuilder("http://openapi.tago.go.kr/openapi/service/DmstcFlightNvgInfoService/getFlightOpratInfoList"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=ycEFiYcdm4Rmzb0Ghr/vOIQEhPbcHO5HhztZMrksr1GP/Ruf4uus9ogb4SJairtnLSYmxMuWn65moOzT/N4EuQ=="); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(Integer.toString(numOfRows), "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode(Integer.toString(pageNo), "UTF-8")); /*페이지 번호*/
        urlBuilder.append("&" + URLEncoder.encode("depAirportId","UTF-8") + "=" + URLEncoder.encode(depAirportId, "UTF-8")); /*출발공항ID*/
        urlBuilder.append("&" + URLEncoder.encode("arrAirportId","UTF-8") + "=" + URLEncoder.encode(arrAirportId, "UTF-8")); /*도착공항ID*/
        urlBuilder.append("&" + URLEncoder.encode("depPlandTime","UTF-8") + "=" + URLEncoder.encode(depPlandTime, "UTF-8")); /*출발일*/
        urlBuilder.append("&" + URLEncoder.encode("_returnType","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*리턴타입*/
		/* response 구성
		 * vihicleId : 항공편명
		 * airlineNm : 항공사명
		 * depPlandTime : 출발시간
		 * arrPlandTime : 도착시간
		 * economyCharge : 일반석운임
		 * prestigeCharge : 비즈니스석운임
		 * depAirportNm : 출발공항
		 * arrAirportNm : 도착공항
		 */
        
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
        System.out.println(sb.toString());
        return sb.toString();
    }
    
    public List<Map<String, String>> getXMLElement(String xml) {
    	List<Map<String, String>> list = new ArrayList<Map<String, String>>();
    	 DocumentBuilderFactory factory  =  DocumentBuilderFactory.newInstance();
    	 DocumentBuilder builder;
		try {
			builder = factory.newDocumentBuilder();
	    	 Document document = builder.parse(new InputSource(new StringReader(xml)));
	    	 NodeList nodelist = document.getElementsByTagName("item");
	    	 for(int i = 0; i<nodelist.getLength();i++) {
	    		 
		    	 Map<String, String > map  = new HashMap<String, String>();
		    	 
		    	 NodeList nodec = nodelist.item(i).getChildNodes();
		    	 for(int j = 0; j<nodec.getLength();j++) {
	    			 String value = nodec.item(j).getChildNodes().item(0).getNodeValue();
	    			 System.out.println(value);
	    			 
		    		 map.put(nodec.item(j).getNodeName(), value);
		    		 if(nodec.item(j).getNodeName().equals("depAirportNm")) {
		    			 if(value.equals("무안")) {
		    				 map.put("dep", "MWX");
		    			 }else if(value.equals("광주")) {
		    				 map.put("dep", "KWJ");				 
		    			 }else if(value.equals("여수")) {
		    				 map.put("dep", "RSU");
		    			 }else if(value.equals("양양")) {
		    				 map.put("dep", "YNY");
		    			 }else if(value.equals("제주")) {
		    				 map.put("dep", "CJU");
		    			 }else if(value.equals("김해")) {
		    				 map.put("dep", "PUS");	 
		    			 }else if(value.equals("울산")) {
		    				 map.put("dep", "USN");
		    			 }else if(value.equals("인천")) {
		    				 map.put("dep", "ICN");
		    			 }else if(value.equals("김포")) {
		    				 map.put("dep", "GMP");	 
		    			 }else if(value.equals("대구")) {
		    				 map.put("dep", "TAE");
		    			 }else if(value.equals("청주")) {
		    				 map.put("dep", "CJJ");
		    			 }else if(value.equals("군산")) {
		    				 map.put("dep", "KUV");
		    			 }else if(value.equals("원주")){
		    				 map.put("dep", "WJU");
		    			 }else if(value.equals("사천")) {
		    				 map.put("dep", "HIN");
		    			 }else if(value.equals("포항")){
	    					 map.put("dep", "KPO");
		    			 }else{
		    				 map.put("dep", "X");
		    			 }
		    		 }
		    		 if(nodec.item(j).getNodeName().equals("arrAirportNm")) {
		    			 if(value.equals("무안")) {
		    				 map.put("arr", "MWX");
		    			 }else if(value.equals("광주")) {
		    				 map.put("arr", "KWJ");				 
		    			 }else if(value.equals("여수")) {
		    				 map.put("arr", "RSU");
		    			 }else if(value.equals("양양")) {
		    				 map.put("arr", "YNY");
		    			 }else if(value.equals("제주")) {
		    				 map.put("arr", "CJU");
		    			 }else if(value.equals("김해")) {
		    				 map.put("arr", "PUS");
		    			 }else if(value.equals("울산")) {
		    				 map.put("arr", "USN");
		    			 }else if(value.equals("인천")) {
		    				 map.put("arr", "ICN");
		    			 }else if(value.equals("김포")) {
		    				 map.put("arr", "GMP");
		    			 }else if(value.equals("대구")) {
		    				 map.put("arr", "TAE");
		    			 }else if(value.equals("청주")) {
		    				 map.put("arr", "CJJ");
		    			 }else if(value.equals("군산")) {
		    				 map.put("arr", "KUV");
		    			 }else if(value.equals("원주")){
		    				 map.put("arr", "WJU");
		    			 }else if(value.equals("사천")) {
		    				 map.put("arr", "HIN");
		    			 }else if(value.equals("포항")){
	    					 map.put("arr", "KPO");
		    			 } else {
		    				 map.put("arr", "X");
		    			 }
		    		 }
		    	 }
		    	 if(map.get("airportNm")!=null) {
			    	 if(!map.get("airportNm").equals("인천")) {
			    		 if(map.containsKey("airportId")||map.containsKey("airportNm")) {
				    		 list.add(map);
				    	 }else {
					    	 if(time1!=null&&time2!=null) {
						    	 if(Integer.parseInt(map.get("depPlandTime").substring(8))>=Integer.parseInt(time1)&&Integer.parseInt(map.get("depPlandTime").substring(8))<=Integer.parseInt(time2)) {
						    		 list.add(map);
						    	 }
					    	 }else{
					    		 list.add(map);
					    	 }
				    	 
				    	 }
	    			 }
		    		 
		    	 }else {
		    		 if(map.containsKey("airportId")||map.containsKey("airportNm")) {
			    		 list.add(map);
			    	 }else {
				    	 if(time1!=null&&time2!=null) {
					    	 if(Integer.parseInt(map.get("depPlandTime").substring(8))>=Integer.parseInt(time1)&&Integer.parseInt(map.get("depPlandTime").substring(8))<=Integer.parseInt(time2)) {
					    		 list.add(map);
					    	 }
				    	 }else{
				    		 list.add(map);
				    	 }
			    	 
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
    
}
