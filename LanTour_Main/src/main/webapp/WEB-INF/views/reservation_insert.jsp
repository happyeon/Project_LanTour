<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.lan.tour.model.dto.ReservationDto"%>
<%@page import="com.lan.tour.model.dto.RoomDto"%>
<%@page import="com.lan.tour.model.dto.HotelDto"%>
<%@page import="com.lan.tour.model.dto.LantourDto"%>
<%@page import="com.lan.tour.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<%MemberDto Mdto =  (MemberDto)session.getAttribute("login");%>
<%LantourDto Ldto =  (LantourDto)request.getAttribute("lantourDto");%>
<%List<ReservationDto> Resdto =  (List<ReservationDto>)request.getAttribute("ResDto");%>
<%HotelDto Hdto =  (HotelDto)request.getAttribute("HotelDto");%>
<%RoomDto Roodto =  (RoomDto)request.getAttribute("RoomDto");%>
<%Map<String,Integer> map = (Map<String,Integer>)request.getAttribute("map");%>
<%String check_in = (String)request.getAttribute("check_in"); %>
<%String check_out = (String)request.getAttribute("check_out"); %>


<link rel="stylesheet" href="./resources/assets/css/theme.min.css">
<link rel="stylesheet" href="./resources/assets/css/theme-rtl.min.css">
<link rel="stylesheet" href="./resources/5/litera/bootstrap.css">
<link rel="stylesheet" href="./resources/_vendor/font-awesome/css/font-awesome.min.css">
<!-- jQuery UI CSS파일  -->  
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css" />
<!-- // jQuery 기본 js파일 -->
<script  src="https://code.jquery.com/jquery-3.6.0.min.js"  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="  crossorigin="anonymous"></script>
<!--// jQuery UI 라이브러리 js파일 -->
<script  src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"  integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU="  crossorigin="anonymous"></script>
<script type="text/javascript">
var enableDay = [
		<%if(Ldto!=null&&Ldto.getLantour_date().indexOf(',')>0){
			for(int i = 0; i < Ldto.getLantour_date().split(",").length ; i++){
				if(map.get(Ldto.getLantour_date().split(",")[i]) < Ldto.getLantour_maxcount())
				if(i==Ldto.getLantour_date().split(",").length-1){%>
					"<%=Ldto.getLantour_date().split(",")[i]%>"
					<%}else{%>
					"<%=Ldto.getLantour_date().split(",")[i]%>",
				<%}%>
		<%	}
		}%>
]
var disabledDays = [
	<%if(Hdto!=null&&Resdto!=null){
		for(int i = 0; i < Resdto.size(); i++){
			if(i==Resdto.size()-1){%>
				["<%=Resdto.get(i).getReservation_date()%>","<%=Resdto.get(i).getReservation_checkout_date()%>"]
			<%}else{%>
				["<%=Resdto.get(i).getReservation_date()%>","<%=Resdto.get(i).getReservation_checkout_date()%>"],
			<%}%>
	<%	}
	}%>
]


var countmb = [
	<%if(Ldto!=null){%>
		<%for(int i = 0; i < Ldto.getLantour_date().split(",").length ; i++){%>
			<%if(i==Ldto.getLantour_date().split(",").length-1){%>
				<%=map.get(Ldto.getLantour_date().split(",")[i])%>
			<%}else{%>
				<%=map.get(Ldto.getLantour_date().split(",")[i])%>,
			<%}%>
		<%}%>
	<%}%>
	
	
]

$(function() {
	<%if(Ldto==null){%>
	  priceSet()
	<%}%>

	function available(date) {
		var thismonth = date.getMonth()+1;
		var thisday = date.getDate();
		if(thismonth<10){
			thismonth = "0"+thismonth;
		}
		if(thisday<10){
			thisday = "0"+thisday;
		}

	    ymd = date.getFullYear() + "-" + thismonth + "-" + thisday;
	    if ($.inArray(ymd, enableDay) >= 0) {
	        return [true,"",""];
	    } else {
	        return [false,"",""];
	    }
	}
	
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
	
    $( "#datepicker" ).datepicker({
    	dateFormat: 'yy-mm-dd',
        reginonal:"ko",
        minDate : 0,
		beforeShowDay: <%if(Ldto!=null){%>available<%}else{%>disable,
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
		      maxDate: Ldate,
		      onClose: priceSet
		    })
		}
		<%}%>
		
		
    });
  } );
  
  <%if(Ldto==null){%>
  function priceSet(){

	  first = new Date($("#datepicker").val())
	  second = new Date($("#datepicker2").val())
	  var time = parseInt(second-first)/60/60/24/1000
	  $("#reservation_price").val(time*<%=Roodto.getRoom_price()%>)
	  document.getElementById("bak").innerText = time
	  
  }
<%}%>
function count(date){
	<%if(Ldto!=null){%>
	if(enableDay.indexOf(date.value)>=0){
		document.getElementById("countMember").innerText = countmb[enableDay.indexOf(date.value)]+"/<%=Ldto.getLantour_maxcount()%>"
	}else{
		
	}
	<%}%>
	
}

</script>
<style type="text/css">
	.accordion-item{
	    display: flex;
	    margin: 3%;
	}
	.card-header{
		padding : 5%;
		width : 100%;
		margin-right:0;
		display: inline-block;
	}
</style>


</head>
<body>
<jsp:include page="./header.jsp" />

<div class="accordion-item" style="display: flex; border: 1px solid rgba(0, 0, 0, 0.125);">
	<div class="card-body" style="width: 70%; margin: auto">
		<div class="card-header" style="padding-top: 10%;padding-bottom: 30px ">
			<div class="card-title"><h4>예약자 정보</h4></div>
			<div class="card-text">
				<span class="lead">성명 : <%=Mdto.getMember_name() %></span>
			</div>
			<div class="card-text">
				<span class="lead">전화번호 :  <%=Mdto.getMember_phone() %></span>
			</div>
			<div class="card-text">
				<span class="lead">이메일 :  <%=Mdto.getMember_email() %></span>
				<input type="button"  class="btn btn-outline-primary" value="변경" onclick="#">
			</div>
			<div class="card-text">전화번호와 이메일을 확인해 주세요. 호스트로부터 전화와 이메일이 갑니다.</div>
		</div>
		
		<%if(Ldto ==null){ %>
		<div class="card-header" style="padding-bottom: 30px">
			<div class="card-title"><h4>여행 정보</h4></div>
			<div class="lead">소개 : <%=Roodto.getRoom_content() %></div>
			<div class="lead">최대 인원수 : <%=Roodto.getRoom_maxcount() %></div>
			<div class="lead">구비 물품 : <%=Roodto.getRoom_convinence() %></div>
			<div class="lead">여행지 정보를 한번 더 확인해 주세요</div>
		</div>
		<div class="card-header" style="padding-bottom: 10%;">
			<div class="card-title"><h4>Lantour 숙소 이용 규칙</h4></div>
			<div class="lead">
				<ul>
					<li>흡연 금지</li>
					<li>반려동물에 적합하지 않음</li>
					<li>파틴나 이벤트 금지</li>
					<li>유아(24개월 이하) 숙박에 안전하거나 적합하지 않을 수 있음</li>
					<li>체크인은 15:00 이후입니다.</li>
				</ul>
			</div>
		</div>
		<%}else{ %>
		<div class="card-header" style="padding-bottom: 30px">
			<div class="card-title"><h4>여행 정보</h4></div>
			<div class="lead">소개 : <%= Ldto.getLantour_content()%></div>
			<div class="lead">최대 인원수 : <%=Ldto.getLantour_maxcount() %></div>
			<div class="lead">Lantour 정보를 한번 더 확인해 주세요</div>
		</div>
		<div class="card-header" style="padding-bottom: 10%;">
			<div class="card-title"><h4>Lantour 이용 규칙</h4></div>
			<div class="lead">
				<ul>
					<li>반응 잘해주기</li>
					<li>궁금한거 질문하기</li>
					<li>녹화 금지</li>
					<li>리액션을 바라면 계좌이체</li>
					<li>출발 시간은 15:00입니다.</li>
				</ul>
			</div>
		</div>
		
		<%} %>
	</div>
	
	<div class="accordion-body" style="width: 30%; border: 1px solid rgba(0, 0, 0, 0.125);margin: 15px">
		
		<!-- if -->
		<%if(Ldto !=null){ %>
		
	<form action="insertReservation.do" method="post">
		<input type="hidden" name="no" value="<%=Ldto.getLantour_no()%>">
		<input type="hidden" name="rno" value="0">
		<input type="hidden" name="member_no" value="<%=Mdto.getMember_no() %>">
			<div class="form-group">
				<div style="width: 100%; margin-bottom: 20px;"><img style="width: 100%; height: 20%" alt="" src="<%=Ldto.getLantour_image()%>"></div>
				<div><h3><%=Ldto.getLantour_title() %> </h3></div>
			</div>
			<div class="form-group">
				<div>
					<div class="form-label mt-4">투어일자</div>
					<div><input onchange="count(this)" class="form-control" style="color:black;" type="text" id="datepicker" name="reservation_date" required="required" readonly="readonly"></div>
					<div>잔여인원 : </div>	
					<div id="countMember">일자를 선택해 주세요</div>
				</div> 
			</div>
			<div class="form-group">
				<div class="form-label mt-4">총합계<input class="form-control" style="color:black;" type="text" name="reservation_price" value="<%=Ldto.getLantour_price() %>" id="reservation_price"readonly></div>
			</div>
			<div class="form-group">
				<input type="submit" class="btn btn-outline-primary" value="다음">
			</div>
			<div>
				Lantour에서는 회원님께 절대 송금을 요구하지 않습니다.<br/>
				언제나 금융 사기에 조심하세요
			</div>
	</form>
		
		<%}else{ %>
	<form action="insertReservation.do" method="post">
		<input type="hidden" name="no" value="<%=Hdto.getHotel_no()%>">
		<input type="hidden" name="rno" value="<%=Roodto.getRoom_no()%>">
		<input type="hidden" name="member_no" value="<%=Mdto.getMember_no() %>">
			<div class="form-group">
				<div style="width: 100%; margin-bottom: 20px;"><img style="width: 100%; height: 20%" alt="" src="<%=Roodto.getRoom_image() %>"></div>
				<div><h3><%=Hdto.getHotel_title() %> <%=Hdto.getHotel_type() %></h3></div>
				<div><h5><%=Roodto.getRoom_name() %></h5></div>
				<div><h5><%=Hdto.getHotel_addr() %></h5></div>
			</div>
			<div class="form-group">
				<div>
					<div class="form-label mt-4">체크인</div>
					<div><input class="form-control" style="color:black;" type="text" required="required" id="datepicker" value="<%=check_in %>"name="reservation_date" readonly="readonly"></div>
				</div> 
				<div>
					<div class="form-label mt-4">체크아웃</div>
					<div><input class="form-control" type="text" style="color:black;" required="required" id="datepicker2" value="<%=check_out %>"name="reservation_checkout_date" readonly="readonly"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="form-label mt-4">₩<%=Roodto.getRoom_price() %> x <span id="bak"></span>박</div>
				<div class="form-label mt-4">총합계<input class="form-control" style="color:black;" type="text" name="reservation_price" id="reservation_price"readonly></div>
			</div>
			<div>
				Lantour에서는 회원님께 절대 송금을 요구하지 않습니다.<br/>
				언제나 금융 사기에 조심하세요
			</div>
			<div class="form-group">
				<input type="submit" class="btn btn-outline-primary" value="다음">
			</div>
			</form>
		
		<%} %>
	</div>
</div>

<jsp:include page="./footer.jsp" />

</body>
</html>