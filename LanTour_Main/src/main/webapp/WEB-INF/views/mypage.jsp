<%@page import="com.lan.tour.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>

</head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	function session(){
		var member_no = $('#member_no').val();
		
	}
function mypagesecession() {
		
		Kakao.init('b0ad0b9e43ffa36c9151c79f86f2db3d');
		Kakao.Auth.setAccessToken("<%=(String)session.getAttribute("token") %>");
		GoogleAuth.disconnect();
		//카카오 로그아웃
		if (!Kakao.Auth.getAccessToken()) {
		  console.log('Not logged in.');
		  
		}
		if("<%=(String)session.getAttribute("token") %>" != ""){
			Kakao.API.request({
				  url: '/v1/user/unlink',
				  success: function(response) {
				    console.log(response);
				  },
				  fail: function(error) {
				    console.log(error);
				  },
				});
		} 
		location.href="mypagesecession.do"
	}
	
	
</script>
<body>`
	<jsp:include page="header.jsp" />
	<% MemberDto Mdto =  (MemberDto)session.getAttribute("login"); %>
	
	<br><br>
	<div class="container">
      <ul class="nav nav-pills" >
		  <li class="nav-item">
		    <a class="nav-link active" href="mypage.do">정보 확인</a>
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
		    <a class="nav-link" href="mytrip.do?member_no=${login.member_no }">여행일정 확인</a>
		  </li>
				  <%if(Mdto.getMember_grade().equals("H")){ %>
				  <li class="nav-item">
				    <a class="nav-link" href="mypagehost.do">호스트 관리</a>
				  </li>
				  <%} %>
		</ul>
		<br><br><br>
    
    

	<input type ="hidden" name = "member_no" value = "${login.member_no }">
	<!--  목록 -->
	<div>
		
		<div class="form-group row" style="margin:0 auto; width: 60%;">
		    <label class="col-sm-2 col-form-label">아이디</label>
		    <div class="col-sm-10">
		        <input type="text" class="form-control" value="${login.member_id }" readonly="readonly" style="background-color: white; color: black;">
		    </div>
		</div>
		<br>
		
		<div class="form-group row" style="margin:0 auto; width: 60%;">
		    <label class="col-sm-2 col-form-label">이름</label>
		    <div class="col-sm-10">
		        <input type="text" class="form-control" value="${login.member_name }" readonly="readonly" style="background-color: white; color: black;">
		    </div>
		</div>
		<br>
		
		<div class="form-group row" style="margin:0 auto; width: 60%;">
		    <label class="col-sm-2 col-form-label">나이</label>
		    <div class="col-sm-10">
		        <input type="text" class="form-control" value="${login.member_age }" readonly="readonly" style="background-color: white; color: black;">
		    </div>
		</div>
		<br>
		
		<div class="form-group row" style="margin:0 auto; width: 60%;">
		    <label class="col-sm-2 col-form-label">성별</label>
		    <div class="col-sm-10">
		        <input type="text" class="form-control" value="${login.member_gender }" readonly="readonly" style="background-color: white; color: black;">
		    </div>
		</div>
		<br>
		
		<div class="form-group row" style="margin:0 auto; width: 60%;">
		    <label class="col-sm-2 col-form-label">이메일</label>
		    <div class="col-sm-10">
		        <input type="text" class="form-control" value="${login.member_email }" readonly="readonly" style="background-color: white; color: black;">
		    </div>
		</div>
		<br>
		
		<div class="form-group row" style="margin:0 auto; width: 60%;">
		    <label class="col-sm-2 col-form-label">전화번호</label>
		    <div class="col-sm-10">
		        <input type="text" class="form-control" value="${login.member_phone }" readonly="readonly" style="background-color: white; color: black;">
		    </div>
		</div>
		<br>
		<div style="margin:0 auto; width: 60%; float: right;">
	      <input class="btn btn-outline-primary" type="button" value="수정하기" onclick="location.href='mypageupdate.do'"/>
	      <input class="btn btn-outline-primary" type="button" value="회원탈퇴" onclick="location.href='mypagesecession.do'"/>
	    </div>
      </div>

   </div>
   <br><br>
<jsp:include page="footer.jsp" />
</body>
</html>