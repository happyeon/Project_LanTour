<%@page import="java.util.List"%>
<%@page import="com.lan.tour.model.dto.NoticeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<link rel="stylesheet" href="./resources/materialize/materialize.css">
<script type="text/javascript" src="resources/js/currentWeather.js" charset='utf-8'></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="./resources/js/materialize.min.js"></script>
<link rel="stylesheet" href="./resources/assets/css/theme.min.css">
<link rel="stylesheet" href="./resources/assets/css/theme-rtl.min.css">
<style type="text/css">
.table-class {
	float: left;
	width: 45%;
	margin-right: 30px;
}
.slider .indicators .indicator-item {
	background-color: #666666;
	border: 3px solid #ffffff;
	-webkit-box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.16), 0 2px 10px 0
		rgba(0, 0, 0, 0.12);
	-moz-box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.16), 0 2px 10px 0
		rgba(0, 0, 0, 0.12);
	box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.16), 0 2px 10px 0
		rgba(0, 0, 0, 0.12);
}
.slider .indicators .indicator-item.active {
	background-color: #ffffff;
}
.slider {
	width: 100%;
	margin: 0 auto;
}
.slider .indicators {
	bottom: 60px;
	z-index: 100;
	/* text-align: left; */
}
</style>
<script type="text/javascript">
<%List<NoticeDto> popuplist = (List<NoticeDto>)request.getAttribute("popup_list"); %>


	document.addEventListener('DOMContentLoaded', function() {
		<%if(session.getAttribute("popupclose")==null){%>
			<%if(popuplist.size()>0){%>
				<%for(NoticeDto dto : popuplist){%>
		window.open("https://ec2-3-144-4-252.us-east-2.compute.amazonaws.com:8443/tour/noticepopup_open.do?notice_no=<%=dto.getNotice_no()%>","popup<%=dto.getNotice_no()%>","width=800, height=700")
				<%}%>		
			<%}%>
		<%}%>
		var options = {
			'height' : 600
		}
		var elems = document.querySelectorAll('.slider');
		var instances = M.Slider.init(elems, options);
	});
</script>
</head>
<body>
	<jsp:include page="header.jsp" />


	<div class="slider">
		<ul class="slides">
			<li>
				<section>
					<div class="bg-holder" style="background-image: url(./resources/assets/img//gallery/main.jpg); background-position: center; background-size: cover;"></div>
					<!--/.bg-holder-->
					<div class="container">
						<div class="row">
							<div class="col-12 py-8 text-white">
								<div class="d-flex flex-column flex-center">
									<h2 class="text-white fs-2 fs-md-3">LanTour</h2>
									<h1 class="text-white fs-2 fs-sm-4 fs-lg-7 fw-bold">??????????????? ???????????????</h1>
								</div>
							</div>
							<div id="js-weather" style="text-align: center;"></div>
						</div>
					</div>
				</section>
			</li>
			<li>
				<section>
					<div class="bg-holder" style="background-image: url(resources/assets/img/gallery/iairport.png); background-position: center; background-size: cover;"></div>
					<div class="container">
						<div class="row">
							<div class="col-12 py-8 text-white">
								<div class="d-flex flex-column flex-center">
									<h1 class="text-white fs-2 fs-md-3">?????? ????????? ??????</h1>
									<h2 class="text-white fs-2 fs-sm-4 fs-lg-7 fw-bold">??? ????????? ???????????????! ???????????? ?????????</h2>
									<h2 class="text-white fs-2 fs-sm-4 fs-lg-7 fw-bold">BOOK RIGHT NOW!</h2>
									<h2 class="text-white fs-2 fs-sm-4 fs-lg-7 fw-bold">
										<input type="button" class="source-button btn btn-primary btn-xs" value="?????? ?????? ????????????" style="font-size: 13pt; font: bold;" onclick="location.href='airportSearch.do'">
									</h2>
								</div>
							</div>
						</div>
					</div>
				</section>
			</li>
			<li>
				<section>
					<div class="bg-holder" style="background-image: url(resources/assets/img/gallery/rentcar.png); background-position: center; background-size: cover;"></div>
					<div class="container">
						<div class="row">
							<div class="col-12 py-8 text-white">
								<h1 class="text-white fs-2 fs-md-3">?????? ????????????</h1>
								<h2 class="text-white fs-2 fs-sm-4 fs-lg-7 fw-bold">????????? ?????? ???????????????</h2>
								<h2 class="text-white fs-2 fs-sm-4 fs-lg-7 fw-bold">BOOK RIGHT NOW!</h2>
								<h2 class="text-white fs-2 fs-sm-4 fs-lg-7 fw-bold">
									<input type="button" class="source-button btn btn-primary btn-xs" value="?????? ?????? ????????????" style="font-size: 13pt; font: bold;" onclick="location.href='rentCarSearch.do'">
								</h2>
							</div>
						</div>
					</div>
				</section>
			</li>
			<li>

				<section id="booking">
					<div class="bg-holder" style="background-image: url(resources/assets/img/gallery/festivalPic.jpg); background-position: center; background-size: cover;"></div>
					<!--/.bg-holder-->
					<div class="container">
						<div class="row">
							<div class="col-12 py-8 text-white">
								<div class="d-flex flex-column flex-center">
									<h2 class="text-white fs-2 fs-md-3">???????????? ????????????</h2>
									<h1 class="text-white fs-2 fs-sm-4 fs-lg-7 fw-bold">Explore Korea Festival</h1>
									<h2 class="text-white fs-2 fs-sm-4 fs-lg-7 fw-bold">
										<input type="button" class="source-button btn btn-primary btn-xs" value="?????? ?????? ????????????" style="font-size: 13pt; font: bold;" onclick="location.href='festival.do'">
									</h2>
								</div>
							</div>
						</div>
					</div>
				</section>


			</li>
		</ul>
	</div>
	<section class="pt-5">
		<div class="container">
			<div class="row flex-center mb-5">
				<div class="col-lg-8 text-center">
					<h1 class="fw-bold fs-md-3 fs-lg-4 fs-xl-5">??????</h1>
					<hr class="mx-auto text-primary my-4" style="height: 3px; width: 70px;" />
					<p class="mx-auto">?????? ??????????????? ?????? ??? ??? ?????? ?????? ??????????????????</p>
					<a href="lantourlist.do" style="float: right;">??? ??????</a>
				</div>
			</div>
			<c:if test="${not empty l_list }">
				<div style="display: flex;">
					<c:forEach var="i" begin="0" end="${fn:length(l_list) - 1}">
						<c:if test="${i lt '5' }">
							<div class="hover-top" style="width: 17%; float: left; margin-right: 20px;">
								<div class="card text-white">
									<a class="stretched-link" href="./lantourdetail.do?lantour_no=${l_list.get(i).lantour_no }">
										<img class="img-fluid" style="height: 200px;" src="${l_list.get(i).lantour_image }" alt="" />
									</a>
									<div class="card-img-overlay d-flex align-items-end bg-dark-gradient">
										<h5 class="text-white fs--1">${l_list.get(i).lantour_title }</h5>
									</div>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>
			</c:if>
		</div>
	</section>


	<section class="pt-5">
		<div class="container">
			<div class="row flex-center mb-5">
				<div class="col-lg-8 text-center">
					<h1 class="fw-bold fs-md-3 fs-lg-4 fs-xl-5">??????</h1>
					<hr class="mx-auto text-primary my-4" style="height: 3px; width: 70px;" />
					<p class="mx-auto">?????? ??????????????? ?????? ??? ??? ?????? ?????? ??????????????????</p>
					<a href="./hotellist.do" style="float: right;">??? ??????</a>
				</div>
			</div>
			<c:if test="${not empty h_list }">
				<div style="display: flex;">
					<c:forEach var="i" begin="0" end="${fn:length(h_list) - 1}">
						<c:if test="${i lt '5' }">
							<div class="hover-top" style="width: 17%; float: left; margin-right: 20px;">
								<div class="card text-white">
									<a class="stretched-link" href="./hoteldetail.do?hotel_no=${h_list.get(i).hotel_no } ">
										<img class="img-fluid" style="height: 200px;" src="${h_list.get(i).hotel_image }" alt="" />
									</a>
									<div class="card-img-overlay d-flex align-items-end bg-dark-gradient">
										<h5 class="text-white fs--1">${h_list.get(i).hotel_title }</h5>
									</div>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>
			</c:if>
		</div>
	</section>
	<section class="pt-5">
		<div class="container" style="display: flex;">
			<div class="table-class">
				<h4 style="padding-bottom: 15px; border-bottom: 1px solid #adadad">???????????????</h4>
				<c:if test="${not empty c_list }">
					<c:forEach var="i" begin="0" end="${fn:length(c_list) - 1}">
						<c:if test="${i lt '4' }">
							<c:choose>
								<c:when test="${c_list.get(i).community_delflag eq 'N'}">
									<div class="hover-top" onclick="location.href='./communitydetail.do?community_no=${c_list.get(i).community_no }'">
										<h5>${c_list.get(i).community_title }</h5>
										<p style="font-size: 10px;">${c_list.get(i).member_name }</p>
									</div>
								</c:when>
								<c:otherwise>
									<div>
										<h5>?????? ??? ????????? ?????????.</h5>
										<p style="font-size: 10px;">????????? ????????? ?????????</p>
									</div>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:forEach>
				</c:if>
			</div>
			<div class="table-class">
				<h4 style="padding-bottom: 15px; border-bottom: 1px solid #adadad">????????????</h4>
				<c:if test="${not empty n_list }">
					<c:forEach var="i" begin="0" end="${fn:length(n_list) - 1}">
						<c:if test="${i lt '4' }">
							<div class="hover-top" onclick="location.href='./noticeSelectOne.do?notice_no=${n_list.get(i).notice_no }'">
								<h5>[??????]${n_list.get(i).notice_title }</h5>
								<p style="font-size: 10px;">?????????</p>
							</div>
						</c:if>
					</c:forEach>
				</c:if>
			</div>

		</div>
	</section>

	<jsp:include page="footer.jsp" />

</body>
</html>