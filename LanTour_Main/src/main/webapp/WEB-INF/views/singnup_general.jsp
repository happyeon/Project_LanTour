
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%
response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<link href='resources/css/bootstrap.min.css' rel='stylesheet' />
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>	
<script type="text/javascript">
	var MailRandNum = "";
	// 아이디 중복 확인
	function idCheck() {
		var member_id = document.getElementsByName("member_id")[0].value;
		var idVal = {
			"member_id" : member_id
		}
		if (member_id.trim() == "" || member_id == null) {
			swal("아이디를 입력해 주세요");
		} else {
			$.ajax({
				type : 'POST',
				url : 'idCheck.do',
				data : JSON.stringify(idVal),
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					if (data.check == false) {
						$("#idChk").attr("title", "y");
						swal("사용가능한 아이디입니다.");
						document.getElementById("idChk").setAttribute(
								"readonly", "readonly")
					} else {
						swal("이미 존재하는 아이디입니다.");
					}
				},
				error : function() {
					swal("통신 실패");
				}
			})
		}
	}

	function idCheckConfirm() {
		var chk = document.getElementsByName("member_id")[0].title;
		if (chk == "n") {
			swal("아이디 중복체크를 먼저 해주세요.");
			document.getElementsByName("member_id")[0].focus();
		}
	};
	// 비밀번호 일치 확인
	function pwCheck() {
		if (document.getElementById('pw').value != ''
				&& document.getElementById('pw2').value != '') {
			if (document.getElementById('pw').value == document
					.getElementById('pw2').value) {
				document.getElementById('check').innerHTML = '비밀번호가 일치합니다.'
				document.getElementById('check').style.color = 'green';
				$("#pw2").attr("class", "form-control is-valid");
			} else {
				document.getElementById('check').innerHTML = '비밀번호가 일치하지 않습니다.';
				document.getElementById('check').style.color = 'red';
				$("#pw2").attr("class", "form-control is-invalid");
			}
		}
	}

	function Emailceck() {
		var email = document.getElementById("email")
		var emailVal = {
			"email" : email.value
		}
		if (email.value.trim() == "" || email.value == null) {
			swal("이메일을 입력해 주세요");
		} else {
			$.ajax({
				type : 'POST',
				url : 'emailcheck.do',
				data : JSON.stringify(emailVal),
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					if (data.success != null) {
						swal("메일이 발송되었습니다.");
						document.getElementById("EmailRandom").removeAttribute(
								"disabled")
						document.getElementById("mailRandceck")
								.removeAttribute("disabled")
						MailRandNum = data.success
					} else {
						swal(data.error);
					}
				},
				error : function() {
					swal("통신 실패");
				}
			})
		}
	}

	function EmailRandceck() {
		var rand = document.getElementById("EmailRandom").value
		var random = {
			"random" : rand
		}
		if (rand.trim() == "" || rand == null) {
			swal("인증번호를 입력해 주세요");
		} else {
			$.ajax({
				type : 'POST',
				url : 'emailrandomcheck.do',
				data : JSON.stringify(random),
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					if (data.result) {
						swal("인증되었습니다.")
						document.getElementById("mailceck").setAttribute(
								"readonly", "readonly")
						document.getElementById("email").setAttribute(
								"readonly", "readonly")
						document.getElementById("EmailRandom").setAttribute(
								"readonly", "readonly")
						document.getElementById("mailRandceck").setAttribute(
								"readonly", "readonly")
						document.getElementById("submit").removeAttribute(
								"disabled")
					} else {
						swal("부정확한 값입니다.")
					}
				},
				error : function() {
					swal("통신 실패");
				}
			})
		}
	}
</script>

</head>
<body>
	<jsp:include page="header.jsp" />
	<br><br><br><br>
	<div class="container">
		<h3 style="text-align: center; ">일반 회원가입</h3>
		<hr class="mx-auto text-primary my-4" style="height:3px; width:60%;" />
		<br><br>
		<form action="./registerres.do" method="post">
			<input type="hidden" name="member_grade" value="U" />
			<fieldset>
			<div class="form-group row" style="margin:0 auto; width: 60%;">
		      <label class="col-sm-2 col-form-label">아이디</label>
		      <div class="col-sm-10">
		        <input type="text" class="form-control" id="idChk" name="member_id" title="n" style="color: black;" required>
		        <button type="button" class="btn btn-primary btn-sm" onclick="idCheck();" style="float: right;">중복체크</button>
		      </div>
		    </div>
		    <br>
		    
		    <div class="form-group row" style="margin:0 auto; width: 60%;">
		      <label class="col-sm-2 col-form-label">비밀번호</label>
		      <div class="col-sm-10">
		        <input type="password" class="form-control" id="pw" name="member_password" onclick="idCheckConfirm();" onchange="pwCheck()" style="color: black;" required>
		      </div>
		    </div>
		    <br>
		    
		    <div class="form-group row" style="margin:0 auto; width: 60%;">
		      <label class="col-sm-2 col-form-label">비밀번호 확인</label>
		      <div class="col-sm-10">
		        <input type="password" class="form-control" id="pw2" onclick="idCheckConfirm();" onchange="pwCheck()" style="color: black;" required>&nbsp;<span id="check"></span>
		      </div>
		    </div>
		    <br>
		    
		    <div class="form-group row" style="margin:0 auto; width: 60%;">
		      <label class="col-sm-2 col-form-label">이름</label>
		      <div class="col-sm-10">
		        <input type="text" class="form-control" name="member_name" style="color: black;" required>
		      </div>
		    </div>
		    <br>
		    
		    <div class="form-group row" style="margin:0 auto; width: 60%;">
		      <label class="col-sm-2 col-form-label">나이</label>
		      <div class="col-sm-10">
		        <input type="text" class="form-control" name="member_age" style="color: black;" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required>
		      </div>
		    </div>
		  	<br>
		  	
		    <div class="form-group row" style="margin:0 auto; width: 60%;">
		      <label class="col-sm-2 col-form-label">성별</label>
		      <div class="col-sm-10">
		        <input type="radio" name="member_gender" value="M" checked>남
				<input type="radio" name="member_gender" value="F">여
		      </div>
		    </div>
		    <br>
		    
		    <div class="form-group row" style="margin:0 auto; width: 60%;">
		      <label class="col-sm-2 col-form-label">이메일</label>
		      <div class="col-sm-10">
		        <input type="text" id="email" class="form-control" name="member_email" style="color: black;" required />
		        <button type="button" class="btn btn-primary btn-sm" id="mailceck" onclick="Emailceck();" style="float: right;">인증메일 발송</button>
		        <br><br>
				<input type="text" id="EmailRandom" class="form-control" style="color:black;"placeholder="인증번호를 입력해주세요." disabled>
				<button type="button" name="" class="btn btn-primary btn-sm" id="mailRandceck" style="color: black; float: right;" onclick="EmailRandceck();" disabled>확인</button>
		      </div>
		    </div>
		  	<br>

			<div class="form-group row" style="margin:0 auto; width: 60%;">
		      <label class="col-sm-2 col-form-label">전화번호</label>
		      <div class="col-sm-10">
		        <input type="text" class="form-control" name="member_phone" placeholder="-없이 입력하세요" style="color: black;" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"  required />
		      </div>
		    </div>
		  	<br><br><br>
		  	
			<div class="form-check" style="margin:0 auto; width: 60%;">
		        <label class="form-check-label">
		          회원 이용약관 동의 (필수)&nbsp;&nbsp;
		        </label>
		        <input type="checkbox" required>
		        <br>
		        <textarea rows="3" cols="85" readonly="readonly" style="width:100%; height:100;">제 1 조(목적)
본 약관은 LanTour 웹사이트(이하 "LanTour")가 제공하는 모든 서비스(이하 "서비스")의 이용조건 및 절차, 회원과 LanTour의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.

제 2 조(약관의 효력과 변경)
1. LanTour은 이용자가 본 약관 내용에 동의하는 경우, LanTour의 서비스 제공 행위 및 회원의 서비스 사용 행위에 본 약관이 우선적으로 적용됩니다.
2. LanTour은 약관을 개정할 경우, 적용일자 및 개정사유를 명시하여 현행약관과 함께 LanTour의 초기화면에 그 적용일 7일 이전부터 적용 전일까지 공지합니다. 단, 회원에 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 LanTour은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 회원이 알기 쉽도록 표시합니다.
3. 변경된 약관은 LanTour 홈페이지에 공지하거나 e-mail을 통해 회원에게 공지하며, 약관의 부칙에 명시된 날부터 그 효력이 발생됩니다. 회원이 변경된 약관에 동의하지 않는 경우, 회원은 본인의 회원등록을 취소(회원탈퇴)할 수 있으며, 변경된 약관의 효력 발생일로부터 7일 이내에 거부의사를 표시하지 아니하고 서비스를 계속 사용할 경우는 약관 변경에 대한 동의로 간주됩니다.
		        </textarea>
		     </div>
			<br><br><br>

			<div style="margin:0 auto; width: 60%; float: right;">
				<input id="submit" class="btn btn-outline-primary" type="submit" value="회원가입" disabled/>
				<input type="button" class="btn btn-outline-primary" value="취소" onclick="location.href='main.do'" />
			</div>
			</fieldset>
		</form>

	</div>
	<jsp:include page="footer.jsp" />
</body>

</html>