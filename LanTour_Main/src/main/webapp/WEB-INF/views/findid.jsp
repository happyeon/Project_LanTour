<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<link href='resources/css/bootstrap.min.css' rel='stylesheet' />
</head>
<script type="text/javascript">

<%if(request.getAttribute("fail")!=null){%>
	swal("입력한 정보를 확인해주세요")
<%}%>
</script>
<body>
	<jsp:include page="header.jsp" />
	
	<br><br>
	<div class="container">
	<h3 style="text-align: center; ">아이디 찾기</h3>
	<fieldset>
	<form action="./findidres.do" method="post">
	<div class="form-group" style="margin:0 auto; width: 50%;">
      <label class="form-label mt-4">이름</label>
      <input type="text" class="form-control" name="member_name" placeholder="회원가입 시 등록한 이름을 입력해주세요." style="color: black;" required>
    </div>
    <div class="form-group" style="margin:0 auto; width: 50%;">
      <label class="form-label mt-4">이메일</label>
      <input type="email" class="form-control" name="member_email" placeholder="회원가입 시 등록한 이메일을 입력해주세요." style="color: black;" required>
      <br><br>
      <button type="submit" class="btn btn-primary" style="float: right;">id 찾기</button>
    </div>
    <br><br><br>
		
	</form>
	</fieldset>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>