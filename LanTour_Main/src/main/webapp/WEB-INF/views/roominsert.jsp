<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	function upload() {
		var form = new FormData();
		form.append("mpfile", $("#file1")[0].files[0])
		$.ajax({
			type : "post",
			enctype : 'multipart/form-data',
			url : "roomupload.do",
			processData : false,
			contentType : false,
			data : form,
			dataType : "json",
			success : function(msg) {
				$("#room_img").prop("src", msg.path);
				$("#room_img").css("width","100%");
				$("#room_img").css("height","500px");
				$("#room_image").val(msg.path);
			},
			error : function() {
				alert("통신 실패");
			}
		});
	}
</script>
<style type="text/css">
#room-insert {
	width: 1000px;
	margin: auto;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<div id="room-insert">
		<form action="./roominsertres.do" method="post">
			<input type="hidden" name="hotel_no" value=${hotel_no }>
			<input type="hidden" id="room_image" name="room_image" value="" />
			<div>
				<div class="form-group">
					<label for="exampleInputEmail1" class="form-label mt-4">방 이름</label>
					<input type="text" name="room_name" style="width: 70%; color: black;" class="form-control" placeholder="방 이름을 입력하세요">
				</div>
			</div>
			<div>
				<div class="form-group">
					<label for="exampleInputEmail1" class="form-label mt-4">방 인원</label>
					<input type="text" name="room_maxcount" style="width: 70%; color: black;" class="form-control" placeholder="숫자를 입력하세요">
				</div>
			</div>
			<div>
				<div class="form-group">
					<label for="exampleInputEmail1" class="form-label mt-4">방 소개</label>
					<input type="text" name="room_content" style="width: 70%; color: black;" class="form-control" placeholder="내용을 입력하세요">
				</div>
			</div>
			<div>
				<div class="form-group">
					<label for="exampleInputEmail1" class="form-label mt-4">방 가격</label>
					<input type="text" name="room_price" style="width: 70%; color: black;" class="form-control" placeholder="숫자를 입력하세요">
				</div>
			</div>
			<div>
				<div class="form-group">
					<label for="exampleInputEmail1" class="form-label mt-4">방 편의시설</label>
					<input type="text" name="room_convinence" style="width: 70%; color: black;" class="form-control" placeholder="내용을 입력하세요">
				</div>
			</div>
			<div>
				<div class="form-group">
					<label for="exampleInputEmail1" class="form-label mt-4">사진 등록</label>
					<input class="form-control" style="width: 50%; color: black;" type="file" id="file1" name="file1" onchange="upload();">
					<img id="room_img" src="" /> <br>
				</div>
			</div>
			<div>
				<div>
					<div class="form-group">
						<button type="submit" class="btn btn-primary">등록하기</button>
					</div>
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>