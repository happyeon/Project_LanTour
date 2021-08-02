<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#second").css("display", "none");
		$("#third").css("display", "none");
		$(".nav-p:eq(0)").css("background-color", "#3984F3");
		$("input:radio[name='hotel_type']:radio[value='${dto.hotel_type}']")
				.prop('checked', true);
	});
	function upload() {
		var form = new FormData();
		form.append("mpfile", $("#file1")[0].files[0])
		$.ajax({
			type : "post",
			enctype : 'multipart/form-data',
			url : "hotelupload.do",
			processData : false,
			contentType : false,
			data : form,
			dataType : "json",
			success : function(msg) {
				$("#hotel_img").prop("src", msg.path);
				$("#hotel_image").val(msg.path);
			},
			error : function() {
				swla("통신 실패");
			}
		})
	}

	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample6_postcode').value = data.zonecode;
						document.getElementById("sample6_address").value = addr;
					}
				}).open();
	}
	function before_first() {
		$("#first").css("display", "");
		$("#second").css("display", "none");
		$(".list-group-item").eq(0).attr("class",
				"list-group-item list-group-item-action active");
		$(".list-group-item").eq(1).attr("class",
				"list-group-item list-group-item-action");
	}
	function next_second() {
		$("#first").css("display", "none");
		$("#second").css("display", "");
		$(".list-group-item").eq(0).attr("class",
				"list-group-item list-group-item-action");
		$(".list-group-item").eq(1).attr("class",
				"list-group-item list-group-item-action active");
	}
	function before_second() {
		$("#third").css("display", "none");
		$("#second").css("display", "");
		$(".list-group-item").eq(1).attr("class",
				"list-group-item list-group-item-action active");
		$(".list-group-item").eq(2).attr("class",
				"list-group-item list-group-item-action");
	}
	function next_third() {
		$("#third").css("display", "");
		$("#second").css("display", "none");
		$(".list-group-item").eq(1).attr("class",
				"list-group-item list-group-item-action");
		$(".list-group-item").eq(2).attr("class",
				"list-group-item list-group-item-action active");
	}
</script>
<style type="text/css">
.hotel-type {
	float: left;
}

.hotel-type-span {
	text-align: center;
	margin-top: 30px;
}

.hotel-update {
	display: flex;
	width: 1000px;
	margin: auto;
}

.div-update {
	width: 65%;
	float: left;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<div class="container" style="display: flex; min-height: 550px;">
		<div class="list-group" style="width: 20%; float: left; margin-right: 10%; margin-top: 20px;">
			<span class="list-group-item list-group-item-action active">타입,이름,인원,위치</span>
			<span class="list-group-item list-group-item-action">설명, 가격</span>
			<span class="list-group-item list-group-item-action">시설, 사진 등록</span>
		</div>
		<div class="div-update">
			<form action="./hotelupdateres.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="hotel_no" value="${dto.hotel_no }" />
				<input type="hidden" id="hotel_image" name="hotel_image" value="${dto.hotel_image }" />
				<div id="first">
					<div>
						<label class="col-sm-2 col-form-label">숙소 타입</label>
						<label class="form-check-label" style="margin-right: 10px;">
							<input type="radio" class="form-check-input" name="hotel_type" value="호텔" checked="checked">
							호텔
						</label>
						<label class="form-check-label" style="margin-right: 10px;">
							<input type="radio" class="form-check-input" name="hotel_type" value="모텔">
							모텔
						</label>
						<label class="form-check-label" style="margin-right: 10px;">
							<input type="radio" class="form-check-input" name="hotel_type" value="게스트 하우스">
							게스트 하우스
						</label>
					</div>
					<div>
						<div class="form-group">
							<label for="exampleInputEmail1" class="form-label mt-4">숙소 이름</label>
							<input type="text" name="hotel_title" style="width: 70%; color: black;" class="form-control" placeholder="숙소 이름을 입력하세요" value="${dto.hotel_title }">
						</div>
					</div>
					<div>
						<div class="form-group">
							<label for="exampleInputEmail1" class="form-label mt-4">숙소 인원</label>
							<input type="text" name="hotel_maxcount" style="width: 70%; color: black;" class="form-control" placeholder="숫자를 입력하세요" value="${dto.hotel_maxcount }">
						</div>
					</div>
					<div>
						<div class="form-group">
							<label for="exampleInputEmail1" style="display: block;" class="form-label mt-4">숙소 위치</label>
							<input type="text" id="sample6_postcode" style="width: 50%; display: inline; color: black;" class="form-control" placeholder="우편번호">
							<input type="button" class="btn btn-primary" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
							<br>
							<input type="text" id="sample6_address" style="width: 70%; color: black;" class="form-control" name="hotel_addr" placeholder="주소" value="${dto.hotel_addr }">
							<br>
						</div>
					</div>
					<div>
						<div class="form-group">
							<button type="button" class="btn btn-primary" onclick="next_second()">계속</button>
						</div>
					</div>
				</div>
				<div id="second">
					<div>
						<div class="form-group">
							<label for="exampleTextarea" class="form-label mt-4">숙소 설명</label>
							<textarea class="form-control" style="color: black; width: 70%;" name="hotel_content" rows="10">${dto.hotel_content }</textarea>
						</div>
					</div>
					<div>
						<div class="form-group">
							<label for="exampleInputEmail1" class="form-label mt-4">대여 가격</label>
							<input type="text" name="hotel_price" style="width: 70%; color: black;" class="form-control" placeholder="숫자를 입력하세요" value="${dto.hotel_price }">
							<br>
						</div>
					</div>
					<div>
						<div class="form-group">
							<button type="button" class="btn btn-primary" onclick="before_first()">이전</button>
							<button type="button" class="btn btn-primary" onclick="next_third()">계속</button>
						</div>
					</div>
				</div>
				<div id="third">
					<div>
						<div class="form-group">
							<label for="exampleInputEmail1" class="form-label mt-4">편의 시설</label>
							<input type="text" name="hotel_convinence" style="width: 70%; color: black;" class="form-control" placeholder="숫자를 입력하세요" value="${dto.hotel_convinence }">
						</div>
					</div>
					<div>
						<div class="form-group">
							<label for="exampleInputEmail1" class="form-label mt-4">사진 등록</label>
							<input class="form-control" style="width: 50%; color: black;" type="file" id="file1" name="file1">
							<br>
							<button type="button" style="display: block;" class="btn btn-primary" id="img_button" onclick="upload()">사진 업로드</button>
							<img id="hotel_img" src="${dto.hotel_image }" /> <br>
						</div>
					</div>
					<div>
						<div class="form-group">
							<button type="button" class="btn btn-primary" onclick="before_second()">이전</button>
							<button type="submit" class="btn btn-primary">등록하기</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>