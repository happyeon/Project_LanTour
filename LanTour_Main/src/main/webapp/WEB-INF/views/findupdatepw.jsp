<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<link href='resources/css/bootstrap.min.css' rel='stylesheet' />
</head>
<body>
<jsp:include page="header.jsp" />

	<br><br>
	<div class="container">
	<form action="./findupdatepwres.do">
	<fieldset>
		<input type="hidden" name="member_id" value="${dto.member_id }"/>
		<br>
		<div class="form-group" style="margin:0 auto; width: 50%;">
	      <label class="form-label mt-4">새로운 비밀번호</label>
	      <input type="password" class="form-control" name="member_password" placeholder="새로운 비밀번호를 입력해주세요." style="color: black;" required>
	      <br><br>
	      <button type="submit" class="btn btn-primary" style="float: right;">비밀번호 변경</button>
	    </div>
	</fieldset>
		
	</form>
	</div>
	
<jsp:include page="footer.jsp" />
</body>
</html>