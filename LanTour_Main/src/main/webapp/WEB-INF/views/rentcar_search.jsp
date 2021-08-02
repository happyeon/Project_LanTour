<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<link rel="stylesheet" href="./resources/assets/css/theme.min.css">
<link rel="stylesheet" href="./resources/assets/css/theme-rtl.min.css">
<script type="text/javascript" src="resources/js/airportWeather.js" ></script>
</head>
<body>
<jsp:include page="./header.jsp" />

<section id ="booking">
<div class="bg-holder" style="background-image:url(resources/assets/img/gallery/rentcar.png);background-position:center;background-size:cover;"></div>
<div class="container"> 
	<div class="row">
		<div class="d-flex flex-column flex-center">
			<h1 class="text-white fs-2 fs-md-3">언제 어디서든</h1>
			<h2 class="text-white fs-2 fs-sm-4 fs-lg-7 fw-bold">빠르고 쉽게 예약하세요</h2>
			<h2 class="text-white fs-2 fs-sm-4 fs-lg-7 fw-bold">BOOK RIGHT NOW!</h2>		
		</div>
		<div class="col-12 py-8 text-white">
			<form action="rentCarList.do" class="row gy-2 gx-md-2 gx-lg-4 flex-center my-6">
					<div class="col-6 col-md-3">
						<select class="form-select" id="dep" name = "searchtype" style="border-color: #ffffff9c;color: white;" required="required">	
							<option style="color: black;" value="">검색 타입</option>							
							<option style="color: black;" value="entrpsNm">업체명</option>
							<option style="color: black;" value="rdnmadr">소재지도로명주소</option>
							<option style="color: black;" value="garageRdnmadr">차고지 도로명 주소</option>
						</select>
					</div>
					<div class="col-6 col-md-3">				
						<select class="form-select"  name="cartype" style="border-color: #ffffff9c;color: white;" required="required">
							<option style="color: black;" value="">차종 검색</option>
							<option style="color: black;"value="carHoldCo">승용차</option>
							<option style="color: black;"  value="vansHoldCo">승합차</option>
							<option style="color: black;" value="eleCarHoldCo">전기 승용차</option>
							<option style="color: black;" value="eleVansCarHoldCo">전기 승합차</option>
						</select>		
					</div>
					<div class="col-6 col-md-3">
						<input type="text" class="form-control" name="content" placeholder="내용을 입력해 주세요" style="border-color: #ffffff9c;color: white;">
					</div>
					<div class="col-6 col-md-auto">
						<input class="btn btn-lg btn-primary"  type="submit" value="검색">
					</div>
			</form>
		</div>
	</div>
	
</div>
</section>
	<jsp:include page="./footer.jsp" />

</body>
</html>