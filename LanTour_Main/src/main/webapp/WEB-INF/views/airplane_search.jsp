<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<style type="text/css">
#js-weather {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
	justify-content: center;
}

.wea{
	background-color: gray;
	opacity: 0.7;
	float: left; 
	text-align: center;
	color: white;
	margin: 0.8%;
}
</style>
</head>
<link rel="stylesheet" href="./resources/assets/css/theme.min.css">
<link rel="stylesheet" href="./resources/assets/css/theme-rtl.min.css">
<script type="text/javascript" src="resources/js/airportWeather.js" ></script>
<script type="text/javascript">
	

	var all=["NAARKJBa","NAARKJJa","NAARKJKa", "NAARKJYa","NAARKNWa","NAARKNYa","NAARKPCa","NAARKPKa","NAARKPSa","NAARKPSa","NAARKPUa","NAARKSSa","NAARKTNa","NAARKTUa"]
	var dp_kp = "NAARKSS" //김포
	var dp_KK = ["NAARKJJ","NAARKPK"] //광주 김해
	var dp_jj = "NAARKPC" // 제주
	var dp_YY = "NAARKNY" // 양양
	var dp_CKW=["NAARKJK","NAARKNW","NAARKTU"] //창원 청주 원주
	
	//광주, 대구, 무안, 김해, 양양, 여수, 울산, 제주, 사천, 포항
	var arr_kimpo=["NAARKJJa", "NAARKTNa","NAARKJBa","NAARKPKa","NAARKNYa","NAARKJYa","NAARKPUa","NAARKPKa","NAARKPSa","NAARKTHa"]
	
	//13개
	var arr_jeju=["NAARKJJa","NAARKJKa", "NAARKTNa","NAARKJBa","NAARKPKa","NAARKSSa","NAARKNYa","NAARKJYa","NAARKPUa","NAARKNWa","NAARKPSa","NAARKTUa","NAARKTHa"]
	
	var arr_KK=["NAARKSSa","NAARKPCa","NAARKNYa"]
	
	var arr_YY=["NAARKJJa","NAARKPCa","NAARKSSa","NAARKPKa"]
	
	var arr_one="NAARKPCa"
	
	var arr_else=["NAARKSSa","NAARKPCa"]
	
	function port(dep){
		var check = true
		for(arr in all){
			document.getElementById(all[arr]).setAttribute("hidden","hidden")
		}
		
		
		if(dep.value==dp_kp){
			for(var arr in arr_kimpo){
				var ar = document.getElementById(arr_kimpo[arr])
				ar.removeAttribute("hidden")
				check= false
			}
			
		}else if(dep.value==dp_jj){
			for(var arr in arr_jeju){
				var ar = document.getElementById(arr_jeju[arr])
				ar.removeAttribute("hidden")
				check= false
			}
		}else if(dep.value==dp_YY){
			for(var arr in arr_YY){
				var ar = document.getElementById(arr_YY[arr])
				ar.removeAttribute("hidden")
				check= false
			}
			
		}else{
			if(check){
				for(dp in dp_KK){
					if(dep.value== dp_KK[dp]){
						for(var arr in arr_KK){
							var ar = document.getElementById(arr_KK[arr])
							ar.removeAttribute("hidden")
						}
					
					}
				}
			}
			if(check){
				for(dp in dp_CKW){
					if(dep.value== dp_CKW[dp]){
						var ar = document.getElementById(arr_one)
						ar.removeAttribute("hidden")
						check= false
					}	
				}
			}
			if(check){
				for(var arr in arr_else){
					var ar = document.getElementById(arr_else[arr])
					ar.removeAttribute("hidden")
				}
				
			}
		}
	}
	
	window.onload = function(){
		let [today] = new Date().toISOString().split("T");
		document.getElementById("date").setAttribute("min", today);
	}
	


</script>
<body>
	<jsp:include page="./header.jsp" />
<% List<Map<String, String>> list = (List<Map<String, String>>)request.getAttribute("list");  %>


<section id ="booking">
<div class="bg-holder" style="background-image:url(resources/assets/img/gallery/iairport.png);background-position:center;background-size:cover;"></div>
<div class="container"> 
	<div class="row">
		<div class="d-flex flex-column flex-center">
			<h1 class="text-white fs-2 fs-md-3">Search Airport For Travel</h1>
			<h2 class="text-white fs-2 fs-sm-4 fs-lg-7 fw-bold">HERE IS ALL OF PLAN</h2>
			<h2 class="text-white fs-2 fs-sm-4 fs-lg-7 fw-bold">BOOK RIGHT NOW!</h2>		
		</div>
		<div class="col-12 py-8 text-white">
			<form action="airplaneList.do" class="row gy-2 gx-md-2 gx-lg-4 flex-center my-6">
					<div class="col-6 col-md-3">
						<select class="form-select" id="dep" onchange="port(this)" name = "depAirportId" required="required">
							<option>출발공항</option>
						<%for(Map<String, String> map : list){ %>
							<option id = "<%=map.get("airportId")%>" value="<%=map.get("airportId") %>"><%=map.get("airportNm") %></option>
						<%} %>
						</select>
					</div>
					<div class="col-6 col-md-3">
						<select class="form-select" required="required" name = "arrAirportId"  required="required">
							<option>도착공항</option>
						<%for(Map<String, String> map : list){ %>
							<option hidden="hidden" id ="<%=map.get("airportId")+"a"%>" value="<%=map.get("airportId") %>"><%=map.get("airportNm") %></option>
						<%} %>
						</select>
					</div>
					<div class="col-6 col-md-3">
						<input class="form-control" id = "date"type="date" name="date"  required="required">
					</div>
					<div class="col-6 col-md-3">				
						<select class="form-select"  name="time">
							<option value="">출발시간 조회</option>
							<option value="00000600">00:00 ~ 06:00</option>
							<option value="06000900">06:00 ~ 09:00</option>
							<option value="09001200">09:00 ~ 12:00</option>
							<option value="12001500">12:00 ~ 15:00</option>
							<option value="15001800">15:00 ~ 18:00</option>
							<option value="18002100">18:00 ~ 21:00</option>
							<option value="21002400">21:00 ~ 24:00</option>			
						</select>		
					</div>
					<div class="col-6 col-md-auto">
						<input class="btn btn-lg btn-primary"  type="submit" value="검색">
					</div>
			</form>
		</div>
		<div id="js-weather"></div>
	</div>
	
</div>
</section>
	<jsp:include page="./footer.jsp" />








</body>
</html>