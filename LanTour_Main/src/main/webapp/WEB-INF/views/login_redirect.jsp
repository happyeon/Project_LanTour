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
<meta name="google-signin-client_id" content="869891537807-u606s04umnomhs5tg7sufpd9c5g7fv6a.apps.googleusercontent.com">

<title>LanTour</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<script type="text/javascript">
	window.onload=function(){
		swal("로그인해주세요")
	}
	function onSignIn(googleUser) {
		var profile = googleUser.getBasicProfile();
		console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
		console.log('Name: ' + profile.getName());
		console.log('Image URL: ' + profile.getImageUrl());
		console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
		var id_token = googleUser.getAuthResponse().id_token;
		var xhr = new XMLHttpRequest();
		xhr.open('POST', 'googleTokensignin.do');
		xhr.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded');
		xhr.onload = function() {
			console.log('Signed in as: ' + xhr.responseText);
			switch (xhr.responseText) {
			case "InvalidEmain":
				swal("구글 이메일 인증이 되어있지 않습니다.")
				break;
			case "signup":
				document.getElementById("id_token").value = id_token
				
				swal({
					title:"구글로그인",
					text:"회원가입으로 넘어가시겠습니까?",
					buttons: ["돌아가기",true]
				}).then((check)=>{
					if(check){
						var f = document.google
						f.idtoken.value = id_token; //POST방식으로 넘기고 싶은 값
						f.action = "googlesignup.do";//이동할 페이지
						f.method = "post";//POST방식
						f.submit();						
					}else{
						var auth2 = gapi.auth2.getAuthInstance();
						auth2.signOut().then(function () {
						  console.log('User signed out.');
						});
						auth2.disconnect();
					}
				})
				break;
			case "login":
				swal("로그인되었습니다.")
				location.href = "main.do"
				break;
			case "hasemail":
				swal("이미 가입되어있는 이메일입니다")
				break;
			default:
				swal("부적합한 접근입니다(이메일과 토큰이 일치하지 않습니다.)")
				break;
			}
		};
		xhr.send('idtoken=' + id_token);
	}
	$(function() {
		$("#loginChk").hide();
	});
	function login() {
		var member_id = $('#member_id').val().trim();
		var member_password = $('#member_password').val().trim();
		var sendByIdPw = {
			"member_id" : member_id,
			"member_password" : member_password
		}
		if (member_id == null || member_id == "" || member_password == null
				|| member_password == "") {
			swal("로그인 실패","Id와 Password를 다시 확인해주세요","error");
		} else {
			$.ajax({
				url : 'loginCheck.do',
				type : 'post',
				data : JSON.stringify(sendByIdPw),
				contentType : "application/json",
				dataType : 'json',
				success : function(data) {
					if (data.check == true) {
						swal("로그인 성공","성공적으로 로그인되었습니다.", "success")
						.then(confirm=>{
							location.href = "main.do";
							
						})
					} else {
						$("#loginChk").show();
						swal("로그인 실패","Id 혹은 Password를 다시 확인해주세요.", "error")
						$("#loginChk").html("Id 혹은 Password를 다시 확인해주세요.");
					}
				},
				error : function() {
					swal("통신 실패");
				}
			});
		}
	}
	function kakologinpage() {
		//sdk를 초기화, 사용할 앱의 javascript키
		Kakao.init('b0ad0b9e43ffa36c9151c79f86f2db3d');
		//sdk 초기화 여부를 판단
		Kakao.isInitialized();
		
		location.href = "https://kauth.kakao.com/oauth/authorize?client_id=0051e1df68b8e3c9d056c9adaf343151&redirect_uri=localhost:8443/tour/kakaologin.do&response_type=code";
	}
</script>

</head>
<body>
	<form name="google">
		<input type="hidden" name="idtoken" id="id_token" value="">
	</form>

	<jsp:include page="header.jsp" />
	<section class="py-0">
		<div class="bg-holder d-none d-md-block" style="background-image: url(./resources/assets/img/illustrations/hero.png); background-position: right bottom; background-size: contain;"></div>
		<!--/.bg-holder-->
		<div class="container position-relative">
			<div class="row align-items-center min-vh-75 my-lg-8">
				<div class="col-md-7 col-lg-6 text-center text-md-start py-8">
					<h1 class="mb-4 display-1 lh-sm">
						한국의 대표 장소를 <br class="d-block d-lg-none d-xl-block" />체험해보세요
					</h1>
					<p class="mt-4 mb-5 fs-1 lh-base">
						한국 여행을 계획하시고 있으신가요 <br class="d-none d-lg-block" />여행에 도움이 되는 각종 예약 및 온라인 체험이 가능합니다. <br class="d-none d-lg-block" />로그인을 통해 다양하게 누려보세요.
					</p>
					<div style="padding-bottom: 50px;">
						<input type="text" style="width: 40%; float: right; color: black; border-color: black;" class="form-control" id="member_id" placeholder="Id" />
					</div>
					<div style="padding-bottom: 50px;">
						<input type="password" style="width: 40%; float: right; color: black; border-color: black;" class="form-control" id="member_password" placeholder="Password" />
					</div>
					<div style="padding-bottom: 10px;">
						<button type="button" class="btn btn-primary" onclick="login();">로그인</button>
					</div>
					<div style="padding-bottom: 50px;">
						<div id="naver_id_login" style="float: right;"></div>
						<script type="text/javascript">
							var naver_id_login = new naver_id_login("NiPSHx6Om9O_VYFPHn9A", "https://ec2-3-144-4-252.us-east-2.compute.amazonaws.com:8443/tour/naverlogin.do");
							var state = naver_id_login.getUniqState();
							naver_id_login.setButton("green", 2, 40);
							naver_id_login.setDomain("https://ec2-3-144-4-252.us-east-2.compute.amazonaws.com:8443/tour/loginform.do");
							naver_id_login.setState(state);
							naver_id_login.init_naver_id_login();
						</script>
						<div class="g-signin2" style="float: right; margin-right: 10px;" data-onsuccess="onSignIn"></div>
						<div class="kakaologin" style="float: right; margin-right: 10px;">
							<img src="resources/kakaologin/kakao_login_medium.png" onclick="kakologinpage()">
						</div>
					
					</div>
					<div style="padding-bottom: 50px;"></div>
					<div>
						<a href="findid.do">아이디 찾기</a>
						&nbsp;&nbsp;&nbsp;
						<a href="findpassword.do">비밀번호 찾기</a>
						&nbsp;&nbsp;&nbsp;
						<a href="registselect.do">회원가입</a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<jsp:include page="footer.jsp" />

</body>
</html>