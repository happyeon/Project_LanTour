<%@page import="com.lan.tour.model.dto.MemberDto"%>
<%@page import="com.lan.tour.model.dto.RoomDto"%>
<%@page import="java.util.List"%>
<%@page import="com.lan.tour.model.dto.ReservationDto"%>
<%@page import="com.lan.tour.model.dto.HotelDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<!-- jQuery UI CSS파일  -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css" />
<!-- // jQuery 기본 js파일 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<!--// jQuery UI 라이브러리 js파일 -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<%List<ReservationDto> Resdto = (List<ReservationDto>)request.getAttribute("ResDto"); %>
<%RoomDto Roodto = (RoomDto)request.getAttribute("RoomDto"); %>
<script type="text/javascript">
	function delete_room() {
		swal('방 정보를 삭제 하겠습니까? 삭제를 하시면 복구가 불가능 하며 새롭게 등록하셔야 합니다 정말로 삭제하시겠습니까?',{buttons:["취소",true]})
		.then(conf=>{
			if(conf){
				$.ajax({
					type: "post",
					url : "./roomdelete.do",
					data:{"room_no":${dto.room_no}},
					dataType:"json",
					success : function (msg) {
						if(msg.check == true){
							swal("삭제 되었습니다");
							location.href = "./hoteldetail.do?hotel_no=${dto.hotel_no }";
						}
					},
					error : function () {
						swal("통신 실패");
					}
				});
				
			}
		})
	}
	function googleTranslateElementInit() {
		new google.translate.TranslateElement({
			pageLanguage : 'ko',
			layout : google.translate.TranslateElement.InlineLayout.SIMPLE, autoDisplay: false
		}, 'google_translate_element');
	}

	var disabledDays = [
		<%if (Resdto != null) {
	for (int i = 0; i < Resdto.size(); i++) {
		if (i == Resdto.size() - 1) {%>
					["<%=Resdto.get(i).getReservation_date()%>","<%=Resdto.get(i).getReservation_checkout_date()%>"]
				<%} else {%>
					["<%=Resdto.get(i).getReservation_date()%>","<%=Resdto.get(i).getReservation_checkout_date()%>"],
				<%}%>
		<%}
}%>
	]
	
	
	$(function() {
		function disable(date) {
			var m = date.getMonth()+1
			var d = date.getDate();
			if(m<10){
				m = "0"+m
			}
			if(d<10){
				d = "0"+d
			}
			ymd = new Date(date.getFullYear()+"-"+m+"-"+d)
			for(i in disabledDays){
				var date1 = new Date(disabledDays[i][0])
				var date2 = new Date(disabledDays[i][1])
				if(date1 <= ymd&&date2 >ymd)
					return [false];
			}
			return [true];
	
		}
		
	    $("#datepicker").datepicker({
	    	dateFormat: 'yy-mm-dd',
	        reginonal:"ko",
	        minDate : 0,
			beforeShowDay: disable,
			onClose: function() {
				var Dday = new Date($("#datepicker").val())
				var Ldate = new Date(Dday.getFullYear(),Dday.getMonth(), Dday.getDate())
				Ldate.setYear(Ldate.getFullYear()+5)
				for(i in disabledDays){
					var date1 = new Date(disabledDays[i][0])
					if(Dday<date1){
						if(date1<Ldate){
							Ldate = date1
						}
					}
				}
				Dday.setDate(Dday.getDate()+1)
				$("#datepicker2").val("")
				$("#datepicker2").removeClass('hasDatepicker').datepicker({
			      dateFormat: 'yy-mm-dd',
			      minDate: Dday,
			      maxDate: Ldate
			    })
		    }
		})
   });
</script>

<style type="text/css">
#room-detail {
	margin: auto;
	width: 1000px;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<form action="reservation.do">
		<input type="hidden" name="type" value="hotel">
		<input type="hidden" name="no" value="${dto.hotel_no}">
		<input type="hidden" name="rno" value="${dto.room_no}">
		<div id="room-detail">
			<img src="${dto.room_image }" style="width: 100%; height: 500px;">
			<div style="width: 80%; margin-top: 20px; margin-bottom: 20px" class="col-6">
				<label class="visually-hidden" for="datepicker">Date</label>
				<div class="input-group">
					<h5 style="padding-top: 2%; margin-right: 15px;">체크인</h5>
					<input class="form-control" style="color: black; margin-right: 30px;" name="check_in" id="datepicker" type="text" required="required" readonly="readonly" />
					<h5 style="padding-top: 2%; margin-right: 15px;">체크 아웃</h5>
					<input class="form-control" style="color: black;" name="check_out" id="datepicker2" type="text" required="required" readonly="readonly" />
				</div>
			</div>
			<div>
				<p>이름 : ${dto.room_name }</p>
				<p>방 소개 : ${dto.room_content } / 인원 : ${dto.room_maxcount }</p>
				<p>편의 시설 : ${dto.room_convinence }</p>
				<p>가격 : ${dto.room_price }</p>
			</div>
			<c:if test="${dto.member_no eq login.member_no }">
			<button type="button" class="btn btn-primary" onclick="delete_room()">방 삭제</button>
			</c:if>
			<input type="submit" class="btn btn-primary" value="예약">
		</div>
	</form>	
	<jsp:include page="footer.jsp" />
</body>
</html>