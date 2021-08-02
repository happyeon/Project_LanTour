<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<style type="text/css">
.regi {
	height: auto;
	text-align: center;
	width: 50%;
	padding-right: 20px;
}

.regibox {
	display: flex;
 	flex-wrap: wrap;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	
	<br><br><br><br>
	<div class="container">
	<div class="regibox">
		<div class="regi" onclick="location.href='registerform.do'">
			<img width="300" height="300" alt="" src="resources/assets/img/gallery/traveller.png">
			<br><br>
			<h5>일반 회원가입</h5>
		</div>
		
		<div class="regi" onclick="location.href='registerhost.do'">
			<img alt="" width="300" height="300" src="resources/assets/img/gallery/maps-and-flags.png">
			<br><br>
			<h5>호스트 회원가입</h5>
		</div>
	</div>
	</div>

	<jsp:include page="footer.jsp" />
</body>
</html>