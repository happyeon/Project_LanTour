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
</head>
<link rel="stylesheet" href="./resources/assets/css/theme.min.css">
<link rel="stylesheet" href="./resources/assets/css/theme-rtl.min.css">
<link rel="stylesheet" href="./resources/5/litera/bootstrap.css">
<link rel="stylesheet" href="./resources/_vendor/font-awesome/css/font-awesome.min.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">


	window.onload = function(){
		var d = document.getElementById("dep")
		port(d.options[d.selectedIndex])
		let [today] = new Date().toISOString().split("T");
		document.getElementById("date").setAttribute("min", today);
		paging(0)
	}


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


	function paging(i){
		$('html').scrollTop(0);
		var reviews = document.getElementsByClassName("airplanedetail")
		var page_item = document.querySelectorAll(".page-item")
		for(var j = 0; j<page_item.length;j++){
			if(j==i){
				page_item[j].setAttribute("class", "page-item active" )
				page_item[j].removeAttribute("onclick")
			}else{
				page_item[j].setAttribute("class", "page-item" )
				page_item[j].setAttribute("onclick", "paging("+j+")" )
			}
		}
		for(var j = 0; j<reviews.length;j++){
			if(j>=i*10&&j<(i+1)*10){
				document.getElementById("ticket"+j).style.display = "block"
			}else{
				document.getElementById("ticket"+j).style.display = "none"
			}
		}
	}

	function pagingBefore() {
		var active = document.getElementsByClassName("page-item active")[0]
		var count = document.querySelectorAll(".page-item").length
		if(parseInt(active.innerText)>10){
			for(var i = 0; i <=parseInt(count/10);i++){
				if(parseInt((active.innerText-1)/10)>=i & parseInt((active.innerText-1)/10)<i+1){
					for(var j = 0; j <count;j++){
						if(parseInt(j/10)==i-1){
							document.getElementById("pageList"+j).style.display = "block"
						}else{
							document.getElementById("pageList"+j).style.display = "none"

						}

					}
					paging((i-1)*10)
				}
			}
		}
	}
	

	function pagingNext() {
		var active = document.getElementsByClassName("page-item active")[0]
		var count = document.querySelectorAll(".page-item").length
		if(parseInt((active.innerText-1)/10)<parseInt(count/10)){
			for(var i = 0; i <=parseInt(count/10);i++){
				if(parseInt((active.innerText-1)/10)>=i&parseInt((active.innerText-1)/10)<(i+1)){
					for(var j = 0; j <count;j++){
						if(parseInt(j/10)==i+1){
							document.getElementById("pageList"+j).style.display = "block"
						}else{
							document.getElementById("pageList"+j).style.display = "none"							
						}
					}
					paging((i+1)*10)
				}
			}
		}
		
	}
	
</script>
<style>
.form-group{
	width: 70%;
	margin: 0 auto;
}

</style>


<jsp:include page="./header.jsp" />
<body>
<% List<Map<String, String>> portlist = (List<Map<String, String>>)request.getAttribute("portlist");  %>
<% List<Map<String, String>> planelist = (List<Map<String, String>>)request.getAttribute("planelist");  %>
<% String date = (String)request.getAttribute("date"); %>
<% String time = (String)request.getAttribute("time"); %>
<div style="display: flow-root;">
	<div>
		<div class="col-lg-6" style="border: 1px solid #8080805c; border: 1px solid #8080805c; margin-left: 2%; width: 20%; float: left;margin-top: 3%">
		<form action="airplaneList.do">
			<div>
				<div class="form-group" >
					<label for="dep" class="form-label mt-4">출발 공항</label>
					<select style="color: #585858;" class="form-select" onchange="port(this)" id="dep" name = "depAirportId">
					<%for(Map<String, String> map : portlist){ %>
						<option <%if(map.get("airportId").equals((String)request.getAttribute("depAirportId"))){ %>selected<%} %> value="<%=map.get("airportId") %>"><%=map.get("airportNm") %></option>
					<%} %>
					</select>
				</div>
				<div class="form-group">
					<label for="arr" class="form-label mt-4">도착공항 공항</label>
					<select id="arr" style="color: #585858" class="form-select" required="required" name = "arrAirportId">
					<%for(Map<String, String> map : portlist){ %>
					<option hidden="hidden" id ="<%=map.get("airportId")+"a"%>"  <%if(map.get("airportId").equals((String)request.getAttribute("arrAirportId"))){ %>selected<%} %> value="<%=map.get("airportId") %>"><%=map.get("airportNm") %></option>
					<%} %>
				</select>
				</div>
				<div  class="form-group">
					<label for="date" class="form-label mt-4">출발일자</label>
					<input class="form-select" style="color: #585858" type="date" id="date" name="date" value="<%= date%>" >	
				</div>
				<div  class="form-group"> 
					<label for="time" class="form-label mt-4">출발일자</label>
					<select class="form-select" style="color: #585858"name="time">
						<option value="">전체조회</option>
						<option <%if(time.equals("00000600")){ %>selected<%} %> value="00000600">00:00 ~ 06:00</option>
						<option <%if(time.equals("06000900")){ %>selected<%} %> value="06000900">06:00 ~ 09:00</option>
						<option <%if(time.equals("09001200")){ %>selected<%} %> value="09001200">09:00 ~ 12:00</option>
						<option <%if(time.equals("12001500")){ %>selected<%} %> value="12001500">12:00 ~ 15:00</option>
						<option <%if(time.equals("15001800")){ %>selected<%} %> value="15001800">15:00 ~ 18:00</option>
						<option <%if(time.equals("18002100")){ %>selected<%} %> value="18002100">18:00 ~ 21:00</option>
						<option <%if(time.equals("21002400")){ %>selected<%} %> value="21002400">21:00 ~ 24:00</option>
					</select>		
				</div>
				<div>
				<input type="submit" class="btn btn-outline-primary" value="검색" style="margin: 5% 5% 5% 45%">
				</div>
			</div>
		</form>
		</div>
	</div>
		
	
			<%if(planelist.size()==0){ %>
	<div style="margin-left: 55%; margin-top: 20%; margin-bottom: 17%;">
		<div >검색된 항공편이 없습니다.</div>
			<%}else{
				int j = 0;%>
				
	<div style="width: 70%;float:left; margin-bottom: 10%">
		<div style="display: flow-root;">
				<%for(Map<String, String> map : planelist){ %>
		<div id = "ticket<%=j%>"class="airplanedetail" <%if(j>=10){ %>style="display: none;"<%} %>>
			<div  style="margin: 4%; margin-bottom: 0; width: 45%; margin-right: 0;  display: flex; float: left;">	
				<div class="modal-content" style="border-right: dotted; ">
					<%j++; %>
					<div class="modal-header">
						<h4 class="modal-title"><%=map.get("airlineNm")==null?"제공되지 않음" :map.get("airlineNm") %> (<%=map.get("vihicleId")==null?"제공되지 않음" :map.get("vihicleId") %>편)</h4>
					</div>
					<div class="modal-body" style="display: flex; width: 360px;">
						<div>
							<h4 ><%=map.get("depAirportNm")==null?"제공되지 않음" :map.get("depAirportNm") %></h4>
							<h5><%=map.get("depPlandTime")==null?"제공되지 않음" :map.get("depPlandTime").substring(8,10) %>:<%=map.get("depPlandTime")==null?"제공되지 않음" :map.get("depPlandTime").substring(10) %></h5>
						</div>
						<div>
							<h4 align="center"><%=(Integer.parseInt(map.get("arrPlandTime")==null?"제공되지 않음" :map.get("arrPlandTime").substring(8,10))-Integer.parseInt(map.get("depPlandTime")==null?"제공되지 않음" :map.get("depPlandTime").substring(8,10)))*60+(Integer.parseInt(map.get("arrPlandTime")==null?"제공되지 않음" :map.get("arrPlandTime").substring(10))-Integer.parseInt(map.get("depPlandTime")==null?"제공되지 않음" :map.get("depPlandTime").substring(10))) %>분</h4>
							<h5>  ────────────────  </h5>
						</div>
						<div>
							<h4><%=map.get("arrAirportNm")==null?"제공되지 않음" :map.get("arrAirportNm") %></h4>
							<h5><%=(map.get("arrPlandTime")==null?"제공되지 않음" :map.get("arrPlandTime").substring(8,10))+":"+(map.get("arrPlandTime")==null?"제공되지 않음" :map.get("arrPlandTime").substring(10))%></h5>
						</div>
					</div>
				</div>
				<div class="modal-content" style="border-left: 0; width: 200px">
				<%if(map.get("dep").equals("X")||map.get("arr").equals("X")){ %>
								예약가능한 항공사와 협약되어있지 않습니다.<br/>
				<%}else{ %>
						<input type="button" style="margin: 5% auto; margin-top: 40%; width: 120px;" class="btn btn-outline-primary" onclick='location.href="https://flight.naver.com/flights/results/domestic?trip=OW&fareType=YC&scity1=<%=map.get("dep") %>&ecity1=<%=map.get("arr") %>&adult=1&child=0&infant=0&sdate1=<%=date.replaceAll("-",".")+"."%>"' value="예매">
							
				<%} %>
				
				</div>
			</div>
		</div>
			<%} %>
		</div >
		<div id="defaultSearch" style="display: block; left : 40%;margin-top: 5%; position: absolute;bottom: 300px;">
			<ul class="pagination">
				<li onclick="pagingBefore()"> <a class="page-link" ><<</a>  </li>
		<%for(int i = 0;i<=planelist.size()/10;i++){%>
					<li id="pageList<%=i%>" <%if(i>9){ %> style="display: none;" <%}else {%> style="display: block;"<%} %>class="page-item" onclick="paging(<%=i%>)"><a class="page-link" ><%=i+1 %></a></li>						
		<%} %>
				<li onclick="pagingNext()"> <a class="page-link" >>></a>  </li>
			</ul>
		</div>
	</div>
	</div>		
	
	<%} %>
</div>
	<jsp:include page="./footer.jsp" />
</body>
</html>