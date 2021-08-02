<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>	
<script type="text/javascript">
	function upload() {
		var form = new FormData();
		form.append("mpfile", $("#file1")[0].files[0])
		$.ajax({
			type : "post",
			enctype : 'multipart/form-data',
			url : "lantourupload.do",
			processData : false,
			contentType : false,
			data : form,
			dataType : "json",
			success : function(msg) {
				$("#lantour_image").val(msg.path)
			},
			error : function() {
				swal("통신 실패");
			}
		})
	}
	function insertDate(){
		var dateTd = document.getElementById("DateTd")
		dateTd.innerHTML = dateTd.innerHTML+"<input class='DateContent' style='display:block;'type='date' name='lantour_date'>"
		let [today] = new Date().toISOString().split("T");
		var date = document.getElementsByClassName("DateContent")
		date[date.length-1].setAttribute("min", today);
	}
	
	function deleteDate(){
		var DateContent = document.getElementsByClassName("DateContent")
		if(DateContent.length>1){
			DateContent[DateContent.length-1].remove()
		}
	}
	window.onload = function(){
		let [today] = new Date().toISOString().split("T");
		document.getElementsByClassName("DateContent")[0].setAttribute("min", today);
	}
	
</script>
<body>
	<jsp:include page="header.jsp" />
	
	<form action="./lantourinsertres.do" method="post" enctype ="multipart/form-data">
	<input type ="hidden" name = "member_no" value = "${login.member_no }">
	<input type ="hidden" name = "lantour_rtc" value = "aaa">
	<input type="hidden" id="lantour_image" name="lantour_image" value="aaaaaa" />
	
	<div class="container">

		<table class="table table-hover" >			
			<tr>
					<th scope="row" style="text-align: center;"><p>투어명</p></th>
					<td><input type="text" name="lantour_title">${dto.lantour_title }</td>
				</tr>
				<tr>
					<th scope="row" style="text-align: center;"><p>투어소개</p></th>
					<td><textarea rows="10" cols="60" name="lantour_content"></textarea>
					</td>
				</tr>

				<tr>
					<th scope="row" style="text-align: center;"><p>투어장소</p></th>
					<td><textarea rows="2" cols="60" name="lantour_addr"></textarea>${dto.lantour_addr }</td>
				</tr>
				<tr>
					<th scope="row" style="text-align: center;"><p>미리보기</p></th>
					<td>
					<input type="file" id="file1" name="file1">
					<button type="button" id="img_button" onclick="upload()">사진 업로드</button>
				
					</td>
				</tr>
			<tr>
				<th scope="row" style="text-align: center;"><p>최대인원</p></th>
				<td><select name="lantour_maxcount">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5" selected>5</option>
						<option value="6">6</option>
						<option value="7">7</option>
						<option value="8">8</option>
						<option value="9">9</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
						<option value="13">13</option>
						<option value="14">14</option>
						<option value="15">15</option>
						<option value="16">16</option>
						<option value="17">17</option>
						<option value="18">18</option>
						<option value="19">19</option>
						<option value="20">20</option>
						<option value="21">21</option>
						<option value="22">22</option>
						<option value="23">23</option>
						<option value="24">24</option>
						<option value="25">25</option>
						<option value="26">26</option>
						<option value="27">27</option>
						<option value="28">28</option>
						<option value="29">29</option>
						<option value="30">30</option>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row" style="text-align: center;"><p>가격</p></th>
				<td><input type="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" name="lantour_price">${dto.lantour_price }</td>
			</tr>
			<tr>
				<th scope="row" style="text-align: center;"><p>투어 일정</p></th>
				<td id="DateTd">
					<input class="DateContent" type="date" name="lantour_date">
					<input type="button" onclick="insertDate()" value="추가">
					<input type="button" onclick="deleteDate()" value="삭제">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" class="btn btn-primary" value="등록하기"/>
					<input type="button" class="btn btn-outline-danger" value="취소" onclick="location.href='lantourlist.do';">
				</td>
			</tr>
		</table>
		</div>
	</form>
	<jsp:include page="footer.jsp" />
</body>
</html>
