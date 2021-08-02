<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
	function delete_hotel() {
		swal("호텔 삭제","'호텔 정보를 삭제 하겠습니까? 삭제를 하시면 복구가 불가능 하며 새롭게 등록하셔야 합니다 정말로 삭제하시겠습니까?'", {buttons:["취소",true]} )
		.then(conf=>{
			if(conf){
				location.href = "./hoteldelete.do?hotel_no=${dto.hotel_no }";
			}
		})
	}
	function update_hotel() {
		swal("호텔 수정","호텔 정보를 수정하시겠습니까?", {buttons:["취소",true]} )
		.then(conf=>{
			if(conf){
				location.href = "./hotelupdate.do?hotel_no=${dto.hotel_no }";
			}
		})
	}
	function before_first() {
		$("#first").css("display", "");
		$("#second").css("display", "none");
	}
	function next_second() {
		$("#first").css("display", "none");
		$("#second").css("display", "");
	}
</script>
<style type="text/css">
#hotel-detail {
	margin: auto;
	width: 1000px;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<div id="hotel-detail">
		<img src="${dto.hotel_image }" style="width: 100%; height: 500px;">
		<div id="map" style="width: 100%; height: 350px;"></div>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=229057490b6a5d6e3ee6c840c9390879&libraries=services,clusterer,drawing"></script>
		<script>
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			mapOption = {
				center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				level : 3
			// 지도의 확대 레벨
			};

			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption);

			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();

			// 주소로 좌표를 검색합니다
			geocoder
					.addressSearch(
							'${dto.hotel_addr }',
							function(result, status) {

								// 정상적으로 검색이 완료됐으면 
								if (status === kakao.maps.services.Status.OK) {

									var coords = new kakao.maps.LatLng(
											result[0].y, result[0].x);

									// 결과값으로 받은 위치를 마커로 표시합니다
									var marker = new kakao.maps.Marker({
										map : map,
										position : coords
									});

									// 인포윈도우로 장소에 대한 설명을 표시합니다
									var infowindow = new kakao.maps.InfoWindow(
											{
												content : '<div style="width:150px;text-align:center;padding:6px 0;">${dto.hotel_title}</div>'
											});
									infowindow.open(map, marker);

									// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
									map.setCenter(coords);
								}
							});
		</script>
<!--	
		<div style="width: 80%; margin-top: 20px; margin-bottom: 20px" class="col-6">
		
			<label class="visually-hidden" for="date">Date</label>	
			<div class="input-group">
				<h5 style="padding-top: 2%; margin-right: 15px;">체크인</h5>
				<input class="form-control" style="color:black; margin-right: 30px;" name="check_in" id="date" type="date" />
				<h5 style="padding-top: 2%; margin-right: 15px;">체크 아웃</h5>
				<input class="form-control" style="color:black;" name="check_out" id="date" type="date" />
			</div>
		</div>
 -->		
		
		<div>
			<p>이름 : ${dto.hotel_title } / 주소 : ${dto.hotel_addr }</p>
			<p>호텔 소개 : ${dto.hotel_content }</p>
			<p>편의 시설 : ${dto.hotel_convinence }</p>
		</div>
		<div style="display: flex;">
		<c:choose>
			<c:when test="${empty roomlist }">
				<h4>등록된 방이 없습니다</h4>
			</c:when>
			<c:otherwise>
				<c:forEach items="${roomlist }" var="dto">
					<div class="col-md-4 mb-3 mb-md-0" style="float: left; padding-bottom: 10px;"onclick="location.href='./roomdetail.do?room_no=${dto.room_no }'">
						<div class="hover-top">
							<img class="img-fluid" style="height: 200px;" src="${dto.room_image }" alt="" />
							<div class="card-img-overlay ps-0 d-flex flex-column justify-content-between bg-dark-gradient">
								<div class="pt-3">
									<span class="badge bg-primary">${dto.room_price }원</span>
								</div>
								<div class="ps-3 d-flex justify-content-between align-items-center">
									<h5 class="text-white">${dto.room_name }</h5>
									<h6 class="text-600">${dto.room_maxcount }인실</h6>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		</div>
		<c:if test="${dto.member_no eq login.member_no }">
			<div>
				<button type="button" class="btn btn-primary" onclick="location.href='./roominsert.do?hotel_no=${dto.hotel_no}'">방등록</button>
				<button type="button" class="btn btn-primary" onclick="update_hotel();">정보 수정</button>
				<button type="button" class="btn btn-primary" onclick="delete_hotel();">등록된 호텔 삭제</button>
			</div>
		</c:if>
	</div>
	<br />
	<embed width="1000px" style="display: block ;margin: 0 auto;height: 100vh" src="https://ec2-3-144-4-252.us-east-2.compute.amazonaws.com:8443/tour/reviewlist.do?type=hotel&no=${dto.hotel_no}"></embed>
	<jsp:include page="footer.jsp" />
</body>
</html>