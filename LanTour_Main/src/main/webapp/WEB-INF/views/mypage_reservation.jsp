<%@page import="com.lan.tour.model.dto.MemberDto"%>
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
<%List<ReservationDto> list = (List<ReservationDto>)request.getAttribute("list");%>
<% MemberDto Mdto =  (MemberDto)session.getAttribute("login"); %>

<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
		    <a class="nav-link active" href="mypayment.do">???????????? ??????</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="mytrip.do?member_no=${login.member_no }">???????????? ??????</a>
		  </li>
		  <%if(Mdto.getMember_grade().equals("H")){ %>
		  <li class="nav-item">
		    <a class="nav-link" href="mypagehost.do">????????? ??????</a>
		  </li>
		  <%} %>
	</ul>
	<br><br>
	
	<table class="table table-hover text-center" >
		<thead>
			<tr style="background-color: #4582ec; color: #ffffff;">
				<th scope="col">????????????</th>
				<th scope="col">?????? ??????/?????? ??????</th>
				<th scope="col">????????????</th>
				<th scope="col">??????</th>
				<th scope="col">?????? ??????</th>
			</tr>
		</thead>
		<tbody>
		<%if(list.size()==0){ %>
			<tr>	
				<th colspan="7">-----------------?????? ????????? ????????????.------------------</th>
			</tr>
		<%}else{
			int i = 0;
			for(ReservationDto rdto :list){%>
			<%if(rdto.getHotel_title()==null){rdto.setHotel_title("????????? ???????????????.");}if(rdto.getRoom_name()==null){rdto.setRoom_name("????????? ????????????.");}if(rdto.getLantour_title()==null){rdto.setLantour_title("????????? ???????????????.");} %>
			<tr class = "reservations" id="reservation<%=i++%>" <%if(rdto.getRoom_no()==0){ if(!rdto.getRoom_name().equals("????????? ????????????.")){ %>onclick="location.href='reservation_detail_one.do?no=<%=rdto.getReservation_no() %>'"<%}}else{if(!rdto.getLantour_title().equals("????????? ???????????????.")){ %>onclick="location.href='reservation_detail_one.do?no=<%=rdto.getReservation_no() %>'"<%}} %> >
				<td scope="row"><%=rdto.getReservation_no() %></td>
				<td><%=rdto.getRoom_no()==0? rdto.getLantour_title():rdto.getHotel_title()+"-"+rdto.getRoom_name() %></td>
				<td><%=rdto.getRoom_no()==0? rdto.getReservation_date():rdto.getReservation_date()+"~"+rdto.getReservation_checkout_date() %></td>
				<td><%=rdto.getReservation_price() %></td>
				<td><%if(rdto.getReservation_pay().equals("cancelled")){%>????????????<%}else if(rdto.getReservation_pay().equals("N")){%>?????????<%}else{%>?????? ??????<%} %></td>
			</tr>
<%}} %>
		</tbody>	
	</table>
		<div id="defaultSearch" style="margin-left:50% ">
			<ul class="pagination pagination-sm">
				<li onclick="pagingBefore()"> <a class="page-link" ><<</a>  </li>
			<%for(int j = 0;j<=list.size()/10;j++){%>
				<li class="page-item" onclick="paging(<%=j%>)"><a class="page-link" ><%=j+1 %></a></li>						
			<% }%>
				<li onclick="pagingNext()"> <a class="page-link" >>></a>  </li>			
			</ul>
		</div>

</div>
<jsp:include page="footer.jsp" />
</body>
</html>