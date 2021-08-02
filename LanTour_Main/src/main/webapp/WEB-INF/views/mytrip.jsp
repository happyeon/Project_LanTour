<%@page import="com.lan.tour.model.dto.MemberDto"%>
<%@page import="com.lan.tour.model.dto.CalendarDto"%>
<%@page import="com.lan.tour.model.dto.ReservationDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<link href='resources/css/bootstrap.min.css' rel='stylesheet' />
<link href='resources/fullcalendar/main.css' rel='stylesheet' />
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="resources/fullcalendar/main.js" ></script>
<script type="text/javascript" src="resources/fullcalendar/locale.js" ></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>	

<style type="text/css">

  body {
    margin: 0;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

  #top {
    background: #eee;
    border-bottom: 1px solid #ddd;
    padding: 0 10px;
    line-height: 40px;
    font-size: 12px;
  }

  #calendar {
    max-width: 1100px;
    margin: 40px auto;
    padding: 0 10px;
  }

</style>

<script type="text/javascript">
<% List<ReservationDto> listLan = (List<ReservationDto>)request.getAttribute("listLan"); %>
<% List<ReservationDto> listRoom = (List<ReservationDto>)request.getAttribute("listRoom"); %>
<% List<CalendarDto> listCal = (List<CalendarDto>)request.getAttribute("listCal"); %>
<% MemberDto Mdto =  (MemberDto)session.getAttribute("login"); %>

function dateFormat(date) {

	var yyyy = date.getFullYear()
	var mon = date.getMonth() + 1;
	mon = mon >= 10? mon : '0' + mon
	var dd = date.getDate();
	dd = dd >= 10? dd : '0' + dd
	var hh = date.getHours();
	var mm = date.getMinutes();
	hh = hh >= 10? hh : '0' + hh;
	mm = mm >= 10? mm : '0' + mm;
	var todate;
	
	if (hh == 0 && mm == 0) {
		todate = yyyy + "-" + mon + "-" + dd
	} else {		
		todate = yyyy + "-" + mon + "-" + dd + "T" + hh + ":" + mm
	}
	
	return todate;
}

function dragUpdate(info) {
	
	var cal_no = info.event.url.split('=')[1];
	var start = info.event.start;
	start = dateFormat(start);

	var end = info.event.end;
	if (end != null) {
		end = dateFormat(end);
	} else {
		end = '';
	}
	
	
	var msg;
	
	$.ajax({
		type:"post",
		url: "dragUpdate.do",
		async: false,
		data: {
			"cal_no" : cal_no,
			"cal_startdate" : start,
			"cal_enddate" : end
		},
		success: function(res){
			if(res == "y") {
				msg = "수정되었습니다.";
			} else {
				msg = "수정에 실패하였습니다.";
			}
		},
		error: function() {
			swal("통신오류")
		}
	});
	return msg;
}

document.addEventListener('DOMContentLoaded', function() {
	var initialLocaleCode = 'ko';
	var localeSelectorEl = document.getElementById('locale-selector');
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
      },   
      locale: initialLocaleCode,
      navLinks: true, // can click day/week names to navigate views
      businessHours: true, // display business hours
      editable: true,
      selectable: true,
      dayMaxEvents: true,
      eventClick: function(arg) {
    	  arg.jsEvent.preventDefault();
    	  if (arg.event.url) {
    		  var url = arg.event.url;
    		  var option = 'width= 800, height=600, left=500, top=100';
    		  var pop = window.open(url, "_blank", option);
    		  return false;
    	  }
      },
      eventDrop : function(info) {
    	  swal("일정", "일정을 변경하시겠습니까?", {buttons:["취소",true]} )
		 .then(conf=>{
			 if(conf){
	    		  var msg = dragUpdate(info);
	    		  swal(msg);
	    	  } else {
	    		  info.revert();
	    	  }
  		 })
      },
      eventResize : function(info) {

    	  swal("일정", "일정을 변경하시겠습니까?", {buttons:["취소",true]} )
		 .then(conf=>{			 
	    	  if(conf) {
	    		  var msg = dragUpdate(info);
	    		  swal(msg);
	    	  } else {
	    		  info.revert();
	    	  }
  		 })
      },
      eventSources : [
    	  {	  // 랜선투어
    		  events : [

<% 
	for (int i = 0; i < listLan.size(); i++) {
	ReservationDto dto = listLan.get(i);
%>	

    			  {
    				  
    			  title: "랜선투어",
    			  start: "<%= dto.getReservation_date()  %>",
    			  constraint: 'lantour',
    			  url: "lantourdetail.do?lantour_no=" + "<%= dto.getLantour_no()  %>"
    			  },
<%} %>						
    			  {
    			  groupId: 'lantour',
    			  display: 'background'
    			  }
    		  ],
    	  	  color: "#2F7AFC",
    	  	  textColor: "#FFFFFF"
    	  },
		  {	  // 숙소예약
    		  events : [

<% 
	for (int i = 0; i < listRoom.size(); i++) {
	ReservationDto dto = listRoom.get(i);
%>	

    			  {
    			  title: "숙소예약",
    			  start: "<%= dto.getReservation_date()  %>",
    			  end: "<%= dto.getReservation_checkout_date()  %>" + "T23:59",
    			  constraint: 'roomReservation',
    			  url: "hoteldetail.do?hotel_no=" + "<%= dto.getHotel_no()  %>"
    			  },

<%} %>	

    			  {
        	      groupId: 'roomReservation',
        		  display: 'background'
        		  }
        	  ],
	  	  	  color: "#22C07E",
	  	 	  textColor: "#FFFFFF"
		  },
		  {	  // 개인일정
    		  events : [

<% for (int i = 0; i < listCal.size(); i++) {
CalendarDto dto = listCal.get(i);
%>	

    			  {
    			  title: "<%= dto.getCal_title()  %>",
    			  start: "<%= dto.getCal_startdate()  %>",
    			  end: "<%= dto.getCal_enddate()  %>",
    			  url: "popupDetail.do?cal_no=" + "<%= dto.getCal_no()  %>"
    			  },

<%} %>	

        	  ],
	  	      color: "#ffb463",
	  	      textColor: "#FFFFFF"
		  }
      ]
    });

    calendar.render();
    
    // build the locale selector's options
    calendar.getAvailableLocaleCodes().forEach(function(localeCode) {
      var optionEl = document.createElement('option');
      optionEl.value = localeCode;
      optionEl.selected = localeCode == initialLocaleCode;
      optionEl.innerText = localeCode;
      localeSelectorEl.appendChild(optionEl);
    });

    // when the selected option changes, dynamically change the calendar option
    localeSelectorEl.addEventListener('change', function() {
      if (this.value) {
        calendar.setOption('locale', this.value);
      }
    });

  });
  
  function calInsert() {
	  var url = 'popupInsert.do';
	  var name = 'popup';
	  var option = 'width= 800, height=600, left=500, top=100';
	  var pop = window.open(url, name, option);
  }
</script>
</head>
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
    <a class="nav-link active" href="mytrip.do?member_no=${login.member_no }">여행일정 확인</a>
  </li>
		  <%if(Mdto.getMember_grade().equals("H")){ %>
		  <li class="nav-item">
		    <a class="nav-link" href="mypagehost.do">호스트 관리</a>
		  </li>
		  <%} %>
</ul>
<br><br>
  <div id='top' style="background-color: white;">

    언어 :
    <select id='locale-selector'></select>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type = "button" class="btn btn-primary btn-sm" onclick="calInsert();">일정 등록</button>
  </div>

  <div id='calendar'></div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>