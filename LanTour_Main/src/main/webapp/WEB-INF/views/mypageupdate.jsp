<%@page import="com.lan.tour.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
</head>
<style>
	
</style>
<link href='resources/css/bootstrap.min.css' rel='stylesheet' />
<body>
	<jsp:include page="header.jsp" />
	<% MemberDto Mdto =  (MemberDto)session.getAttribute("login"); %>
	
	<br><br>
	<div class="container">
      <ul class="nav nav-pills" >
		  <li class="nav-item">
		    <a class="nav-link" href="mypage.do">정보 확인</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link active" href="mypageupdate.do">정보 수정</a>
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
				    <a class="nav-link" href="mypagehost.do">호스트 관리</a>
				  </li>
				  <%} %>
		</ul>
		<br><br>

	
	
	<form action="./mypageupdateres.do" method="post">
		<fieldset>
		<input type="hidden" name="member_no" value="${login.member_no }">
		<!--  목록 -->
		<div>
			<div class="form-group row" style="margin:0 auto; width: 60%;">
			    <label class="col-sm-2 col-form-label">아이디</label>
			    <div class="col-sm-10">
			        <input type="text" class="form-control" name="member_id" value="${login.member_id }" readonly="readonly" style="background-color: white; color: black;">
			    </div>
			</div>
			<br>
			
			<div class="form-group row" style="margin:0 auto; width: 60%;">
			    <label class="col-sm-2 col-form-label">이름</label>
			    <div class="col-sm-10">
			        <input type="text" class="form-control" name="member_name" value="${login.member_name }" style="background-color: white; color: black;">
			    </div>
			</div>
			<br>
			
			
			
			<div class="form-group row" style="margin:0 auto; width: 60%;">
			    <label class="col-sm-2 col-form-label">이메일</label>
			    <div class="col-sm-10">
			        <input type="text" class="form-control" name="member_email" value="${login.member_email }" style="background-color: white; color: black;">
			    </div>
			</div>
			<br>
			
			<div class="form-group row" style="margin:0 auto; width: 60%;">
			    <label class="col-sm-2 col-form-label">전화번호</label>
			    <div class="col-sm-10">
			        <input type="text" class="form-control" name="member_phone" value="${login.member_phone }" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="background-color: white; color: black;">
			    </div>
			</div>
			<br>
			
			

		</div>
		<div style="margin:0 auto; width: 60%; float: right;">
		      <input class="btn btn-outline-primary" type="submit" value="수정완료"/>
		      <input class="btn btn-outline-primary" type="button" value="취소" onclick="location.href='mypage.do?mypage=${login.member_id}';"/>
		</div>
		</fieldset>
	</form>
	</div>
<jsp:include page="footer.jsp" />
</body>
</html>