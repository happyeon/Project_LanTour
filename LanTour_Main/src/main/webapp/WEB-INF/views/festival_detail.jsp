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
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

	<%
	String contentid = (String) request.getAttribute("contentid");
	%>
	<input type="hidden" id="contentid" value="<%=contentid%>">
	<%
	String eventstartdate = (String) request.getAttribute("eventstartdate");
	eventstartdate = eventstartdate.substring(0, 4) + "-" + eventstartdate.substring(4, 6) + "-" + eventstartdate.substring(6, 8);
	%>
	<%
	String eventenddate = (String) request.getAttribute("eventenddate");
	eventenddate = eventenddate.substring(0, 4) + "-" + eventenddate.substring(4, 6) + "-" + eventenddate.substring(6, 8);
	%>

	
	<jsp:include page="header.jsp" />
	<div class="container">
	<br><br><br>
	
		<div class="row flex-center mb-5">
            <div class="col-lg-8 text-center">
              <h1 class="fw-bold fs-md-3 fs-lg-4 fs-xl-5" id="festivaltitle"></h1>
              <hr class="mx-auto text-primary my-4" style="height:3px; width:370px;" />
              <img id="festivalimg" alt="img" src="">
              <br><br>
              <p class="mx-auto" id="festivalsummary"></p>
            </div>
          </div>


	<br><br><br>
	<table class="table table-hover">
		<thead>
			<tr style="background-color:#4582ec; color:#ffffff; ">
				<th colspan="2" scope="col" class="text-center" style="text-align: center;">상세정보</th>
			</tr>
		</thead>
		<tbody>
				<tr>
					<th scope="row" style="text-align: center;"><p>시작일</p></th>
					<td>
						<p><%=eventstartdate%></p>
					</td>
				</tr>
				<tr>
					<th scope="row" style="text-align: center;"><p>종료일</p></th>
					<td>
						<p><%=eventenddate%></p>
					</td>
				</tr>
				<tr>
					<th scope="row" style="text-align: center;"><p>전화번호</p></th>
					<td>
						<p id="festivaltel"></p>
					</td>
				</tr>
				<tr>
					<th scope="row" style="text-align: center;"><p>홈페이지</p></th>
					<td>
						<p id="festivallink"></p>
					</td>
				</tr>
				<tr>
					<th scope="row" style="text-align: center;"><p>주소</p></th>
					<td>
						<p id="festivaladdr"></p>
					</td>
				</tr>
			</tbody>
	</table>
	<br><br><br>
	<div id="map" style="width: 100%; height: 350px; align-content: center;"></div>
</div>



		
		




	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e46f4369a17cbff96a1aa064dd171ad2"></script>
	<script type="text/javascript">
		window.onload = function() {

			var contentid = $('#contentid').val();

			$
					.ajax({
						url : './festivaldetaillist.do',
						type : 'GET',
						data : {
							'contentid' : contentid
						},
						dataType : 'json',
						success : function(data) {
							var myData = data.response.body.items.item;

							addr1 = myData.addr1;
							firstimage = myData.firstimage;
							homepage = myData.homepage;
							mapx = myData.mapx;
							mapy = myData.mapy;
							mlevel = myData.mlevel;
							overview = myData.overview;
							tel = myData.tel;
							telname = myData.telname;
							title = myData.title;

							document.getElementById("festivaltitle").innerHTML = title;
							var festivalimg = $('#festivalimg');
							festivalimg.attr('src', firstimage);
							document.getElementById("festivalsummary").innerHTML = overview;
							document.getElementById("festivaltel").innerHTML = telname
									+ "(" + tel + ")";
							document.getElementById("festivallink").innerHTML = homepage;
							document.getElementById("festivaladdr").innerHTML = addr1;

							var mapContainer = document.getElementById('map'), // 지도를 표시할 div 

							mapOption = {
								center : new kakao.maps.LatLng(mapy, mapx), // 지도의 중심좌표
								level : 3
							// 지도의 확대 레벨
							};

							var map = new kakao.maps.Map(mapContainer,
									mapOption); // 지도를 생성합니다

							//마커가 표시될 위치입니다 
							var markerPosition = new kakao.maps.LatLng(mapy,
									mapx);

							//마커를 생성합니다
							var marker = new kakao.maps.Marker({
								position : markerPosition
							});

							//마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);
						},
						error : function() {
							swal("통신 실패");
						}
					});
		}
	</script>



	<jsp:include page="footer.jsp" />

</body>
</html>