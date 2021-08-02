<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<jsp:include page="header.jsp" />


	<div class="container">

		<h3 style="text-align: center;">일반 회원가입</h3>
		<hr class="mx-auto text-primary my-4" style="height: 3px; width: 60%;" />
		<br> <br>
		<form action="./naversingupres.do" method="post">
			<input type="hidden" name="member_id" value="${dto.member_id }" />
			<input type="hidden" name="member_name" value="${dto.member_name }" />
			<input type="hidden" name="member_email" value="${dto.member_email }" />
			<input type="hidden" name="member_grade" value="U" />
			<input type="hidden" name="member_password" value="naver" />
			<input type="hidden" name="member_secession" value="N" />

			<fieldset>

				<div class="form-group row" style="margin: 0 auto; width: 60%;">
					<label class="col-sm-2 col-form-label">나이</label>
					<div class="col-sm-10">
						<input type="text" name="member_age" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required>
					</div>
				</div>

				<div class="form-group row" style="margin: 0 auto; width: 60%;">
					<label class="col-sm-2 col-form-label">성별</label>
					<div class="col-sm-10">
						<input type="radio" name="member_gender" value="M" checked>
						남
						<input type="radio" name="member_gender" value="F">
						여
					</div>
				</div>

				<div class="form-group row" style="margin: 0 auto; width: 60%;">
					<label class="col-sm-2 col-form-label">전화번호</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" name="member_phone" placeholder="-없이 입력하세요" style="color: black;" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required />
					</div>
				</div>
				<br> <br> <br>

				<div class="form-check" style="margin: 0 auto; width: 60%;">
					<label class="form-check-label"> 회원 이용약관 동의 (필수)&nbsp;&nbsp; </label>
					<input type="checkbox" required>
					<br>
					<textarea rows="3" cols="85" readonly="readonly" style="width: 100%; height: 100;">제 1 조(목적)
본 약관은 LanTour 웹사이트(이하 "LanTour")가 제공하는 모든 서비스(이하 "서비스")의 이용조건 및 절차, 회원과 LanTour의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.

제 2 조(약관의 효력과 변경)
1. LanTour은 이용자가 본 약관 내용에 동의하는 경우, LanTour의 서비스 제공 행위 및 회원의 서비스 사용 행위에 본 약관이 우선적으로 적용됩니다.
2. LanTour은 약관을 개정할 경우, 적용일자 및 개정사유를 명시하여 현행약관과 함께 LanTour의 초기화면에 그 적용일 7일 이전부터 적용 전일까지 공지합니다. 단, 회원에 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 LanTour은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 회원이 알기 쉽도록 표시합니다.
3. 변경된 약관은 LanTour 홈페이지에 공지하거나 e-mail을 통해 회원에게 공지하며, 약관의 부칙에 명시된 날부터 그 효력이 발생됩니다. 회원이 변경된 약관에 동의하지 않는 경우, 회원은 본인의 회원등록을 취소(회원탈퇴)할 수 있으며, 변경된 약관의 효력 발생일로부터 7일 이내에 거부의사를 표시하지 아니하고 서비스를 계속 사용할 경우는 약관 변경에 대한 동의로 간주됩니다.
		        </textarea>
				</div>
				<br> <br> <br>

				<div style="margin: 0 auto; width: 60%; float: right;">
					<input id="submit" class="btn btn-outline-primary" type="submit" value="회원가입" />
					<input type="button" class="btn btn-outline-primary" value="취소" onclick="location.href='main.do'" />
				</div>
			</fieldset>
		</form>

	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>