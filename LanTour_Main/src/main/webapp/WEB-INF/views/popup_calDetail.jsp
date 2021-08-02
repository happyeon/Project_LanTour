<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<link href='resources/css/bootstrap.min.css' rel='stylesheet' />
<link rel="stylesheet" href="./resources/assets/css/theme.min.css">
<link rel="stylesheet" href="./resources/assets/css/theme-rtl.min.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>	
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#cal_del").click(function(){
			var cal_no = $(this).attr("name");
			
			$.ajax({
				type:"post",
				url: "popupDelete.do",
				data: {
					"cal_no":cal_no
				},
				success: function(){
					swal("일정이 삭제되었습니다.").then(conf=>{
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
	<br><br>
	<form action="popupUpdate.do" method="post">
	<input type ="hidden" class="cal_no" name="cal_no" value="${dto.cal_no }">
		<div class="container">
	    <div class="row flex-center mb-5">
	    <div class="col-lg-8 text-center">
	    <h1 class="fw-bold fs-md-3 fs-lg-4 fs-xl-5">${dto.cal_title }</h1>
	    <hr class="mx-auto text-primary my-4" style="height:3px; width:570px;" />    
	    <p class="mx-auto" >시작 날짜 &nbsp;|&nbsp;&nbsp;  ${fn:substring(startdate,0,4)}년 ${fn:substring(startdate,5,7)}월 ${fn:substring(startdate,8,10)}일 ${fn:substring(startdate,11,16)}</p>
	    <p class="mx-auto" >종료 날짜 &nbsp;|&nbsp;&nbsp;
	    	<c:if test="${not empty dto.cal_enddate}">
				${fn:substring(enddate,0,4)}년
				${fn:substring(enddate,5,7)}월
				${fn:substring(enddate,8,10)}일
				${fn:substring(enddate,11,16)}
			</c:if>
						
			<c:if test="${empty dto.cal_enddate}">
				종료날짜를 등록하지 않았습니다.
			</c:if>
	    </p>
	    <br><br>
	    <p class="mx-auto" >${dto.cal_content }</p>
	    <br><br>
	    <button type="submit" class="btn btn-primary btn-sm">수정</button>
		<button type="button" class="btn btn-primary btn-sm" id="cal_del" name="${dto.cal_no }">삭제</button>
		<button type="button" class="btn btn-primary btn-sm" onClick="window.close()">취소</button>
	    </div>
	    </div>
	    </div>
	</form>
	

</body>
</html>