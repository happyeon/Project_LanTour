<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<link href='resources/css/bootstrap.min.css' rel='stylesheet' />
</head>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
<%if(request.getAttribute("fail")!=null){%>
window.onload=function(){
	swal("패스워드 찾기 오류","입력한 정보를 확인해주세요", "error")	
}
<%}%>


</script>
<body>
<jsp:include page="header.jsp" />

	<br><br>
	<div class="container">
	<h3 style="text-align: center; ">비밀번호 찾기</h3>
	
	
	<form action="./findpasswordres.do" method="post">
		<fieldset>
			<div class="form-group" style="margin:0 auto; width: 50%;">
		      <label class="form-label mt-4">아이디</label>
		      <input type="text" class="form-control" name="member_id" placeholder="회원가입 시 등록한 아이디를 입력해주세요." style="color: black;" required>
		    </div>
		    <div class="form-group" style="margin:0 auto; width: 50%;">
		      <label class="form-label mt-4">이름</label>
		      <input type="text" class="form-control" name="member_name" placeholder="회원가입 시 등록한 이름을 입력해주세요." style="color: black;" required>
		    </div>
			<div class="form-group" style="margin:0 auto; width: 50%;">
		      <label class="form-label mt-4">이메일</label>
		      <input type="email" class="form-control" name="member_email" placeholder="회원가입 시 등록한 이메일을 입력해주세요." style="color: black;" required>
		      <br><br>
		      <button type="submit" class="btn btn-primary" style="float: right;">비밀번호 찾기</button>
		    </div>
		</fieldset>
	</form>
	</div>
	
<jsp:include page="footer.jsp" />
</body>
</html>