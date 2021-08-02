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
<%List<ReservationDto> list = (List<ReservationDto>)request.getAttribute("list");%>
<% MemberDto Mdto =  (MemberDto)session.getAttribute("login"); %>
<%Map<Integer, MemberDto> map = (Map<Integer, MemberDto>)request.getAttribute("map"); %>
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
		    <a class="nav-link" href="mypage.do">정보 확인</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="mypageupdate.do">정보 수정</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="mypost.do">게시글 확인</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="mypayment.do">결제내역 확인</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="mytrip.do?member_no=${login.member_no }">여행일정 확인</a>
		  </li>
		  <%if(Mdto.getMember_grade().equals("H")){ %>
		  <li class="nav-item">
		    <a class="nav-link active" href="mypagehost.do">호스트 관리</a>
		  </li>
		  <%} %>
	</ul>
	<br><br>
	<table class="table table-hover text-center" >
		<thead>
			<tr style="background-color: #4582ec; color: #ffffff;">
				<th scope="col">구분</th>
				<th scope="col">번호</th>
				<th scope="col">이름</th>
				<th scope="col">연락처</th>
				<th scope="col">이메일</th>
				<th scope="col">금액</th>
				<th scope="col">예약일자</th>
				<th scope="col">진행상태</th>
			</tr>
		</thead>
		<tbody>
		<%if(list.size()==0){ %>
			<tr>	
				<th colspan="7">-----------------등록된 컨텐츠가 없습니다.------------------</th>
			</tr>
		<%}else{%>
			<%for(ReservationDto dto : list){%>
				<tr>
					<td><%=dto.getRoom_no()==0?"랜선투어" :"숙소예약" %></td>
					<td><%=dto.getReservation_no()%></td>
					<td><%=map.get(dto.getMember_no()).getMember_name() %></td>
					<td><%=map.get(dto.getMember_no()).getMember_phone() %></td>
					<td><%=map.get(dto.getMember_no()).getMember_email() %></td>
					<td><%=dto.getReservation_price() %></td>
					<td><%=dto.getRoom_no()==0?dto.getReservation_date() :dto.getReservation_date()+"~"+dto.getReservation_checkout_date()%></td>
					<td><%if(dto.getReservation_pay().equals("N")){ %>미결제<%}else if(dto.getReservation_pay().equals("cancelled")){ %>결제 취소됨<%}else{ %>결제 완료<%} %></td>
				</tr>		
			<%} %>
		<%} %>
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