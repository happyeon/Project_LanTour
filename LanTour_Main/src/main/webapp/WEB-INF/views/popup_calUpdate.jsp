<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<link href='resources/css/bootstrap.min.css' rel='stylesheet' />
<link rel="stylesheet" href="./resources/assets/css/theme.min.css">
<link rel="stylesheet" href="./resources/assets/css/theme-rtl.min.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>	

<script type="text/javascript">
	$(document).ready(function(){
		$("#cal_update").click(function(){
			var cal_no = $(".cal_no").val();
			var cal_title = $("#cal_title").val();
			var start_date = $("#start_date").val();
			var start_time = $("#start_time").val();
			var end_date = $("#end_date").val();
			var end_time = $("#end_time").val();
			var cal_content = $("#cal_content").val();
			
			if(start_time != '') {
				start_time = 'T' + start_time;
			}		
			if(end_time != '') {
				end_time = 'T' + end_time;
			}
			
			var start_dt = start_date + start_time
			var end_dt = end_date + end_time
			
			
			var startArray = start_date.split('-');
			var endArray = end_date.split('-');   
			var start_date = new Date(startArray[0], startArray[1], startArray[2]);
	        var end_date = new Date(endArray[0], endArray[1], endArray[2]);

	        if(start_date.getTime() > end_date.getTime()) {
	        	swal("종료날짜보다 시작날짜가 작아야합니다.");
	            return false;
	        }

	        if (cal_title.trim() == "") {
	        	swal("제목을 입력해주세요");
	            return false;
	        }

	        if (!Date.parse(start_date)) {
	        	swal("시작날짜를 입력해주세요");
	            return false;
	        }
	        
	        $.ajax({
	        	type:"post",
	        	url: "popupUpdateRes.do",
	        	data: {
	        		"cal_no" : cal_no,
	        		"cal_title" : cal_title,
	        		"cal_content" : cal_content,
	        		"cal_startdate" : start_dt,
	        		"cal_enddate" : end_dt
	        	},
	        	success: function(){
	        		swal("일정이 수정되었습니다.").then(conf=>{
	        		opener.location.reload();
	        		window.close();	        			
	        		});
	        	}
	        });
		});
	});
</script>
</head>

<body>

	<c:set var="startdate" value="${dto.cal_startdate }" />
	<c:set var="enddate" value="${dto.cal_enddate }" />
	<input type ="hidden" class="cal_no" name="cal_no" value="${dto.cal_no }">
	<br><br>
	<div class="container">
	<div class="row flex-center mb-5">
	<div class="col-lg-8 text-center">
	<h2 class="fw-bold fs-md-3 fs-lg-4 fs-xl-5">일정 수정</h2>
	<hr class="mx-auto text-primary my-4" style="height:2px; width:170px;" />
	<br>
			<div class="form-group row">
			<label for="staticEmail" class="col-sm-2 col-form-label">제목</label>
			<div class="col-sm-10">
				<input type="text" class="form-control-plaintext" id="cal_title" style="border:1px solid black;" name="title" value="${dto.cal_title }">
		    </div>
			</div>
			
			<br><br>
			<div class="form-group row">
			<label for="staticEmail" class="col-sm-2 col-form-label">시작 날짜</label>
			<div class="col-sm-10">
				<input type="date" id="start_date" class="form-control-plaintext" style="border:1px solid black; float: left; width: 48%;" value="${fn:substring(startdate,0,10)}">
		    	<input type="time" id="start_time" class="form-control-plaintext" style="border:1px solid black; float: right; width: 48%;" value="${fn:substring(startdate,11,19) }">
		    </div>
			</div>
			
			<br><br>
			<div class="form-group row">
			<label for="staticEmail" class="col-sm-2 col-form-label">종료 날짜</label>
			<div class="col-sm-10">
				<input type="date" id="end_date" class="form-control-plaintext" style="border:1px solid black; float: left; width: 48%;" value="${fn:substring(enddate,0,10) }">
				<input type="time" id="end_time" class="form-control-plaintext" style="border:1px solid black; float: right; width: 48%;" value="${fn:substring(enddate,11,19) }">
		    </div>
			</div>
			
			
			<br><br>
			<div class="form-group row">
			<label for="staticEmail" class="col-sm-2 col-form-label">내용</label>
			<div class="col-sm-10">
				<textarea rows="5"  class="form-control-plaintext" id="cal_content" cols="60" style="border:1px solid black;"  name="content">${dto.cal_content }</textarea>
				
		    </div>
			</div>
			
			
	<br><br>

	<button type="button" class="btn btn-primary btn-sm" id="cal_update">일정 수정</button>
	<button type="button" class="btn btn-primary btn-sm" onClick="window.close()">취소</button>
	</div>
	</div>
	</div>



</body>
</html>