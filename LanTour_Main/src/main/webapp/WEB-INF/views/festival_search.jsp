<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<link href='resources/css/bootstrap.min.css' rel='stylesheet' />
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="resources/js/festivalSearch.js" ></script>
<script type="text/javascript" src="resources/js/koreaWeather.js" ></script>
<style type="text/css">

#js-weather {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
	justify-content: center;
}

.wea{
	background-color: gray;
	opacity: 0.7;
	float: left; 
	text-align: center;
	color: white;
	margin: 0.8%;
}

select option {
	background-color: gray;
}

#festivalSearchList{
	display: flex;
 	flex-wrap: wrap;
}

.fes {
	height: auto;
	text-align: center;
	width: 50%;
	padding-right: 20px;
}

.fes img {
	width: 90%;
    height: 55%;
}

#paging {
	text-align: center;
}

#paging button {
	background-color: #3984F3;
	border: 0;
	outline: 0;
	width: 30px;
	height: 30px;
	border-radius: 4px;
	color: white;
}

</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<section id="booking">
        <div class="bg-holder" style="background-image:url(resources/assets/img/gallery/festivalPic.jpg);background-position:center;background-size:cover;">
        </div>
        <!--/.bg-holder-->

        <div class="container">
          <div class="row">
            <div class="col-12 py-8 text-white">
              <div class="d-flex flex-column flex-center">
                <h2 class="text-white fs-2 fs-md-3">대한민국 구석구석</h2>
                <h1 class="text-white fs-2 fs-sm-4 fs-lg-7 fw-bold">Explore Korea Festival</h1>
              </div>
              <form class="row gy-2 gx-md-2 gx-lg-4 flex-center my-6">
              	<div class="col-6 col-md-3">
                  <label for="date">Start Date</label>
                  <div class="input-group">
                    <input class="form-control" id="eventStartDate" type="date" style="color: white;" />
                  </div>
                </div>
              
                <div class="col-6 col-md-3">
                  <label for="date">End date</label>
                  <div class="input-group">
                    <input class="form-control" id="eventEndDate" type="date" style="color: white;" />
                  </div>
                </div>
                
              
                <div class="col-6 col-md-3">
                  <label for="areaCode">Destinations</label>
	              <select class="form-select" id="areaCode" style="color: white;">
                    <option value="" >전국</option>
					<option value="1" >서울</option>
					<option value="2" >인천</option>
					<option value="3" >대전</option>
					<option value="4" >대구</option>
					<option value="5" >광주</option>
					<option value="6" >부산</option>
					<option value="7" >울산</option>
					<option value="8" >세종특별자치시</option>
					<option value="31" >경기도</option>
					<option value="32" >강원도</option>
					<option value="33" >충청북도</option>
					<option value="34" >충청남도</option>
					<option value="35" >경상북도</option>
					<option value="36" >경상남도</option>
					<option value="37" >전라북도</option>
					<option value="38" >전라남도</option>
					<option value="39" >제주도</option>
                  </select>
                </div>
                
                
                
                <div class="col-6 col-md-3">
                  <label for="arrange">Filter</label>
                  <select class="form-select" id="arrange" style="color: white;">
                    <option value="A">제목순</option>
					<option value="B">인기순</option>
					<option value="C">수정일순</option>
					<option value="D">생성일순</option>
                  </select>
                </div>

				
                <div class="col-6 col-md-auto">
                  <button class="btn btn-lg btn-primary" type="button" onclick="festivalSearch();">Search</button>
                </div>
                
                
              </form>
            </div>
            <div id="js-weather"></div>
          </div>
        </div>
      </section>


	
	<br><br><br><br><br>
	<div class="container">
		<div id="festivalSearchList"></div>
	</div>
	<br><br>
	<div id="paging"></div>




	<jsp:include page="footer.jsp" />
</body>
</html>