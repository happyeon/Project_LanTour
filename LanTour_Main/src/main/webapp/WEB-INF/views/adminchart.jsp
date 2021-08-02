<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.4.1/chart.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
	$(function() {
		reservation();
		member();
		community();
		hotel();
		lantour();
	});
	function community() {
		$.ajax({
			url : "admincommunitychart.do",
			type : "post",
			dataType : "json",
			success : function(msg) {
				var list = msg.list;
				var label = [];
				var data = [];
				for (var i = 0; i < list.length; i++) {
					label.push(list[i].regdate);
					data.push(list[i].count);
				}
				var communitychart = $("#communitychart");
				communitybar(communitychart, label, data)
			},
			error : function() {
				swal("통신 실패");
			}
		});
	}
	function reservation() {
		$.ajax({
			url : "adminreservationchart.do",
			type : "post",
			dataType : "json",
			success : function(msg) {
				var list = msg.r_list;
				var label = [];
				var mydata = [];
				for (var i = 0; i < list.length; i++) {
					label.push(list[i].pay_date);
					mydata.push(list[i].count);
				}
				var reservationchart = $("#reservationchart");
				charbar(reservationchart, label, mydata);
			},
			error : function() {
				swal("통신 실패");
			}
		});
	}
	function hotel() {
		$.ajax({
			url : "adminhotelchart.do",
			type : "post",
			dataType : "json",
			success : function(msg) {
				var list = msg.list;
				var label = [];
				var data = [];
				var text = '호텔 등록 수'
				for (var i = 0; i < list.length; i++) {
					label.push(list[i].regdate);
					data.push(list[i].count);
				}
				var hotelchart = $("#hotelchart");
				hotel_lan_chart(hotelchart, data, label, text);
			}
		});
	}
	function lantour() {
		$.ajax({
			url : "adminlantourchart.do",
			type : "post",
			dataType : "json",
			success : function(msg) {
				var list = msg.list;
				var label = [];
				var data = [];
				var text = '랜선투어 등록 수'
				for (var i = 0; i < list.length; i++) {
					label.push(list[i].regdate);
					data.push(list[i].count);
				}
				var lantourchart = $("#lantourchart");
				hotel_lan_chart(lantourchart, data, label, text);
			}
		});
	}
	function member() {
		$.ajax({
			url : "adminmemberchart.do",
			type : "post",
			dataType : "json",
			success : function(msg) {
				var list = msg.m_list;
				var label = [];
				var m_data = [];
				var f_data = [];
				var text = '남자 회원수';
				var color = 'rgba(54, 162, 235, 1)';
				for (var i = 0; i < list.length; i++) {
					label.push(list[i].regdate);
					m_data.push(list[i].count);
				}
				var menmemberchart = $("#menmemberchart");
				linechart(menmemberchart, m_data, label, text, color);

				list = msg.w_list;
				label = [];
				color = 'rgba(255, 99, 132, 1)';
				text = '여자 회원수'
				for (var i = 0; i < list.length; i++) {
					label.push(list[i].regdate);
					f_data.push(list[i].count);
				}
				var womenmemberchart = $("#womenmemberchart");
				linechart(womenmemberchart, f_data, label, text, color);
			},
			error : function() {
				swal("통신 실패");
			}
		});
	}
	function communitybar(communitychart, label, data) {
		var myChart = new Chart(communitychart,
				{
					type : 'bar',
					data : {
						labels : label,
						datasets : [ {
							label : '게시글 등록 숫자',
							fill : false,
							data : data,
							backgroundColor : [
							//색상
							'rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)',
									'rgba(255, 206, 86, 0.2)',
									'rgba(75, 192, 192, 0.2)',
									'rgba(153, 102, 255, 0.2)',
									'rgba(255, 159, 64, 0.2)' ],
							borderColor : [
							//경계선 색상
							'rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)',
									'rgba(255, 206, 86, 1)',
									'rgba(75, 192, 192, 1)',
									'rgba(153, 102, 255, 1)',
									'rgba(255, 159, 64, 1)' ],
							borderWidth : 1
						} ]
					},
					options : {
						title : {
							display : true,
							text : '날짜 별 게시글 등록'
						}
					}
				});
	}
	function charbar(reservationchart, label, mydata, text) {
		var myChart = new Chart(reservationchart,
				{
					type : 'bar',
					data : { // 차트에 들어갈 데이터
						labels : label,
						datasets : [ { //데이터
							label : '예약 횟수', //차트 제목
							fill : false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
							data : mydata,
							backgroundColor : [
							//색상
							'rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)',
									'rgba(255, 206, 86, 0.2)',
									'rgba(75, 192, 192, 0.2)',
									'rgba(153, 102, 255, 0.2)',
									'rgba(255, 159, 64, 0.2)' ],
							borderColor : [
							//경계선 색상
							'rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)',
									'rgba(255, 206, 86, 1)',
									'rgba(75, 192, 192, 1)',
									'rgba(153, 102, 255, 1)',
									'rgba(255, 159, 64, 1)' ],
							borderWidth : 1
						} ]
					},
					options : {
						title : {
							display : true,
							text : '날짜 별 예약 횟수'
						}
					}
				});
	}
	function linechart(memberchart, data, label, text, color) {
		var memberChart = new Chart(memberchart, {
			type : "line",
			data : {
				labels : label,
				datasets : [ {
					label : text,
					fill : false,
					data : data,
					backgroundColor : color,
					borderColor : color,
					borderWidth : 1
				} ]
			},
			options : {
				title : {
					display : true,
					text : '회원가입 횟수'
				}
			}
		});
	}
	function hotel_lan_chart(chart, data, label, text) {
		var myChart = new Chart(chart,
				{
					type : 'bar',
					data : { // 차트에 들어갈 데이터
						labels : label,
						datasets : [ { //데이터
							label : text, //차트 제목
							fill : false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
							data : data,
							backgroundColor : [
							//색상
							'rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)',
									'rgba(255, 206, 86, 0.2)',
									'rgba(75, 192, 192, 0.2)',
									'rgba(153, 102, 255, 0.2)',
									'rgba(255, 159, 64, 0.2)' ],
							borderColor : [
							//경계선 색상
							'rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)',
									'rgba(255, 206, 86, 1)',
									'rgba(75, 192, 192, 1)',
									'rgba(153, 102, 255, 1)',
									'rgba(255, 159, 64, 1)' ],
							borderWidth : 1
						} ]
					},
					options : {
						title : {
							display : true,
							text : '날짜 별 예약 횟수'
						}
					}
				});
	}
</script>
<body>
	<jsp:include page="header.jsp" />
	<div class="container">
		<ul class="nav nav-pills">
			<li class="nav-item"><a class="nav-link" href="adminmember.do">회원관리</a></li>
			<li class="nav-item"><a class="nav-link" href="admincommunity.do">커뮤니티 게시판 글 목록</a></li>
			<li class="nav-item"><a class="nav-link active" href="adminchart.do">차트 보기</a></li>
		</ul>

		<div style="display: flex; margin-top: 35px;">
			<div style="width: 450px; float: left; margin-right: 100px; margin-left: 200px;">
				<canvas id="reservationchart"></canvas>
			</div>
			<div style="width: 450px; float: left;">
				<canvas id="communitychart"></canvas>
			</div>
		</div>
		<div style="display: flex;">
			<div style="width: 450px; float: left; margin-right: 100px; margin-left: 200px;">
				<canvas id="menmemberchart"></canvas>
			</div>
			<div style="width: 450px; float: left;">
				<canvas id="womenmemberchart"></canvas>
			</div>
		</div>
		<div style="display: flex;">
			<div style="width: 450px; float: left; margin-right: 100px; margin-left: 200px;">
				<canvas id="hotelchart"></canvas>
			</div>
			<div style="width: 450px; float: left;">
				<canvas id="lantourchart"></canvas>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>