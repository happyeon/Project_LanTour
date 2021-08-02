<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- summernote js,css 링크 -->
<script type="text/javascript" src="./resources/summernote/summernote-lite.js"></script>
<script type="text/javascript" src="./resources/summernote/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<link rel="stylesheet" href="./resources/summernote/summernote-lite.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript">
	$(function() {
		$('.summernote').summernote({
			placeholder : 'content',
			minHeight : 370,
			maxHeight : null,
			focus : true,
			lang : 'ko-KR',
			callbacks : {
				onImageUpload : function(files, editor, welEditable) {
					for (var i = files.length - 1; i >= 0; i--) {
						fileupload(files[i], this);
					}
				}
			}
		});
	})
	function fileupload(file, el) {
		data = new FormData();
		data.append("file", file);
		$.ajax({
			type : "post",
			enctype : 'multipart/form-data',
			url : "communityupload.do",
			processData : false,
			contentType : false,
			data : data,
			dataType : "json",
			success : function(msg) {
				$(el).summernote('editor.insertImage', msg.path);
			},
			error : function() {
				swal("통신 실패");
			}
		});
	}
</script>
<style type="text/css">
.community-update {
	width: 1000px;
	margin: auto;
}

.btn-which {
	float: right;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<div class="community-update" style="padding-bottom: 80px;">
		<form action="communityupdateres.do" method="post">
			<input type="hidden" name="community_no" value="${dto.community_no }" />
			<div class="form-group row">
				<input type="text" style="color:black;" class="form-control" id="community_title" value="${dto.community_title }" placeholder="제목을 입력하세요">
			</div>
			<br>
			<div class="form-group row">
				<input type="text" style="color:black;" class="form-control" name="community_title" value="${login.member_name }" readonly="readonly">
			</div>
			<br>
			<div class="form-group row">
				<textarea class="summernote" rows="10" cols="60" name="community_content">${dto.community_content }</textarea>
			</div>
			<br>
			<div class="btn-which">
				<button class="btn btn-primary" type="submit">게시글 수정</button>
			</div>
		</form>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>