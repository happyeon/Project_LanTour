<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.lan.tour.model.dto.ReviewDto"%>
<%@page import="com.lan.tour.model.dto.MemberDto"%>
<%@page import="java.util.Map"%>
<%@page import="com.lan.tour.model.dto.LantourDto"%>
<%@page import="com.lan.tour.model.dto.RoomDto"%>
<%@page import="com.lan.tour.model.dto.HotelDto"%>
<%@page import="com.lan.tour.model.dto.ReservationDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
</head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<% List<HotelDto> Hlist = (List<HotelDto>)request.getAttribute("Hlist"); %>
<% Map<Integer,List<RoomDto>> RooMap = (Map<Integer,List<RoomDto>>)request.getAttribute("RooMap");%>
<% List<LantourDto> Llist = (List<LantourDto>)request.getAttribute("Llist");%>
<% MemberDto Mdto =  (MemberDto)session.getAttribute("login"); %>
<% Map<String, ReviewDto> RevMap = (Map<String, ReviewDto>)request.getAttribute("RevMap"); %>
<% Map<String, ReservationDto> ResMap = (Map<String, ReservationDto>)request.getAttribute("ResMap"); %>
<%DateFormat format = new SimpleDateFormat("yyyy/MM/dd mm:ss");%>
<script type="text/javascript">

window.onload= function(){
	paging(0)
}

function paging(i){
	$('html').scrollTop(0);
	var reviews = document.getElementsByClassName("reservations")
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
			document.getElementById("reservation"+j).style.display = "table-row"
		}else{
			document.getElementById("reservation"+j).style.display = "none"
			
			
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
<body>
<jsp:include page="header.jsp" />
<div class="container">
	<br><br>
	<ul class="nav nav-pills" >
		  <li class="nav-item">
		    <a class="nav-link" href="mypage.do">?????? ??????</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="mypageupdate.do">?????? ??????</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="mypost.do">????????? ??????</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="mypayment.do">???????????? ??????</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="mytrip.do?member_no=${login.member_no }">???????????? ??????</a>
		  </li>
		  <%if(Mdto.getMember_grade().equals("H")){ %>
		  <li class="nav-item ">
		    <a class="nav-link active" href="mypagehost.do">????????? ??????</a>
		  </li>
		  <%} %>
	</ul>
	<br><br>
	<table class="table table-hover text-center" >
		<thead>
			<tr style="background-color: #4582ec; color: #ffffff; vertical-align:middle;">
				<th rowspan="2" scope="col">??????</th>
				<th rowspan="2" scope="col">??????</th>
				<th rowspan="2"  scope="col">??????</th>
				<th rowspan="2" scope="col">??????</th>
				<th rowspan="2" scope="col">????????????</th>
				<th colspan="4" scope="col">????????????</th>
				<th rowspan="2" scope="col">??????</th>
				<th rowspan="2" scope="col">??????</th>
			</tr>
			<tr style="background-color: #4582ec; color: #ffffff;">
				<th scope="col">?????????</th>
				<th scope="col">????????????</th>
				<th scope="col">?????????</th>
				<th scope="col">????????????</th>
			</tr>
		</thead>
		<tbody>
		<%if(Llist.size()==0&& Hlist.size()==0){ %>
			<tr>	
				<th colspan="7">-----------------????????? ???????????? ????????????.------------------</th>
			</tr>
		<%}else{%>
			<%for(LantourDto dto : Llist){ %>
				<tr>
					<td>????????????</td>
					<td><%=dto.getLantour_no() %></td>
					<td><%=dto.getLantour_title()%></td>
					<td><%=dto.getLantour_price() %></td>
					<td><%=format.format(dto.getLantour_regdate())%></td>
					<%ReservationDto ResDto = ResMap.get("L"+dto.getLantour_no()); %>
					<td><%= ResDto.getReservation_no()%></td>
					<td><%=ResDto.getReservation_no()-ResDto.getLantour_no()-ResDto.getHotel_no() %></td>
					<td><%= ResDto.getLantour_no()%></td>
					<td><%=RevMap.get("L"+dto.getLantour_no()).getReview_score()+"/5.0("+RevMap.get("L"+dto.getLantour_no()).getReview_no()+")" %></td>						
					<td><input type="button" class="btn btn-primary" onclick="location.href='./lantourdetail.do?lantour_no=<%=dto.getLantour_no() %>'" value="????????? ??????"/><br/> <input type="button" class="btn btn-primary" style="margin-top: 5px;" onclick="location.href='mypage_hostreservation.do?no=<%=dto.getLantour_no() %>&rno=0'" value="????????????"/></td>
				</tr>
			<%}%>
			<%for(HotelDto dto : Hlist){ %>
				<tr>
					<td>??????</td>
					<td><%=dto.getHotel_no() %></td>
					<td><%=dto.getHotel_title()%></td>
					<td><%=dto.getHotel_price() %></td>
					<td><%=format.format(dto.getHotel_regdate())  %></td>
					<td colspan="4" >-</td>
					<td><%=RevMap.get("H"+dto.getHotel_no()).getReview_score()+"/5.0("+RevMap.get("H"+dto.getHotel_no()).getReview_no()+")" %></td>		
					<td><input type="button" class="btn btn-primary" onclick="location.href='./hoteldetail.do?hotel_no=<%=dto.getHotel_no() %>'" value="????????? ??????"/></td>		
				</tr>
				<%for(RoomDto Roodto : RooMap.get(dto.getHotel_no())){ %>
				<tr>
					<td>???</td>
					<td><%=Roodto.getRoom_no() %></td>
					<td><%=Roodto.getRoom_name()%></td>
					<td><%=Roodto.getRoom_price() %></td>
					<td>-</td>
					<%ReservationDto ResDto = ResMap.get("R"+Roodto.getRoom_no()); %>
					<td><%= ResDto.getReservation_no()%></td>
					<td><%=ResDto.getReservation_no()-ResDto.getLantour_no()-ResDto.getHotel_no() %></td>
					<td><%= ResDto.getLantour_no()%></td>
					<td><%= ResDto.getHotel_no()%></td>
					<td>-</td>			
					<td><input type="button" class="btn btn-primary" onclick="location.href='./roomdetail.do?room_no=<%=Roodto.getRoom_no() %>'" value="????????? ??????"/><br/> <input type="button" class="btn btn-primary" style="margin-top: 5px;" onclick="location.href='mypage_hostreservation.do?no=<%=dto.getHotel_no() %>&rno=<%=Roodto.getRoom_no() %>'" value="????????????"/></td>
				</tr>
				<%} %>
			<%}%>
			
		<%} %>
		</tbody>	
	</table>
		<div id="defaultSearch" style="margin-left:50% ">
			<ul class="pagination pagination-sm">
				<li onclick="pagingBefore()"> <a class="page-link" ><<</a>  </li>
			<%for(int j = 0;j<=(Llist.size()+Hlist.size()+RooMap.size())/10;j++){%>
				<li class="page-item" onclick="paging(<%=j%>)"><a class="page-link" ><%=j+1 %></a></li>						
			<% }%>
				<li onclick="pagingNext()"> <a class="page-link" >>></a>  </li>			
			</ul>
		</div>

</div>
<jsp:include page="footer.jsp" />
</body>
</html>