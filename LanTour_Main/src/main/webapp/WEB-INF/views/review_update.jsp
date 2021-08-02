<%@page import="com.lan.tour.model.dto.MemberDto"%>
<%@page import="java.util.Map"%>
<%@page import="com.lan.tour.model.dto.ReviewDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
</head>
<link rel="stylesheet" href="./resources/5/litera/bootstrap.css">
<link rel="stylesheet" href="./resources/_vendor/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="./resources/_vendor/prismjs/themes/prism-okaidia.css">
<link rel="stylesheet" href="./resources/_assets/css/custom.min.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- summernote js,css 링크 -->
<script type="text/javascript" src="./resources/summernote/summernote-lite.js"></script>
<script type="text/javascript" src="./resources/summernote/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="./resources/summernote/summernote-lite.css">
<script type="text/javascript">
<%ReviewDto Rdto = (ReviewDto)request.getAttribute("Rdto"); %>
<%MemberDto login = (MemberDto)session.getAttribute("login"); %>
<%String type = (String)request.getAttribute("type"); %>
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
				alert("통신 실패");
			}
		});
	}
	function starPick(star){
		const star1 = document.getElementById("star1")
	    const star2 = document.getElementById("star2")
		const star3 = document.getElementById("star3")
		const star4 = document.getElementById("star4")
		const star5 = document.getElementById("star5")
		var StarScore = document.getElementById("starScore")
		StarScore.value=star
	    switch(star){
	        case 5:
	            star5.innerText = "★"
	        case 4:
	            star4.innerText = "★"
	        case 3:
	            star3.innerText="★"
	        case 2:
	            star2.innerText="★"
	        case 1:
	            star1.innerText="★"
	    }
		switch(star){
	        case 1:
	            star2.innerText="☆"
	        case 2:
	            star3.innerText="☆"
	        case 3:
	            star4.innerText="☆"
	        case 4:
	            star5.innerText="☆"
	    }
	}
	window.onload = function(){
		starPick(<%=Rdto.getReview_score()%>)
	}

</script>
<body>
	<div id="writebox" class="bs-component card border-secondary mb-3" style="width: 100%">
		<form action="ReviewUpdateRes.do" method="post">
			<input type="hidden" name="review_no" value="<%=Rdto.getReview_no() %>"/>
			<input type="hidden" name="no" value="<%=Rdto.getHotel_no()==0?Rdto.getLantour_no():Rdto.getHotel_no()%>">
			<input type="hidden" name="type" value="<%=type %>"/>			
			<div class="card-header" style="background-color: #ecf3fd;">
				<h3>평가하기</h3>
			</div>
			<div class="card-body">
				<h6>다른 사용자에게 의견을 들려주세요</h6>
				<h3>
			<input type="hidden" value="<%=Rdto.getReview_score()%>" name="review_score" id="starScore" >	
					<span id="star1" onclick="starPick(1)"> ☆ </span>
					<span id="star2" onclick="starPick(2)"> ☆ </span>
					<span id="star3" onclick="starPick(3)"> ☆ </span>
					<span id="star4" onclick="starPick(4)"> ☆ </span>
					<span id="star5" onclick="starPick(5)"> ☆ </span>
				</h3>
				<div id="writeReview"">
					<div>
						<span><textarea rows="10" cols="30" name="review_title" class="summernote" required="required"><%=Rdto.getReview_title() %></textarea> </span>
					</div>
					<div>
						<input type="submit" class="btn btn-outline-primary" value="작성">
						<input type="button" class="btn btn-outline-primary" value="취소" id="writeButton" onclick="location.href='reviewlist.do?type=<%=type %>&no=<%=Rdto.getHotel_no()==0?Rdto.getLantour_no():Rdto.getHotel_no() %>'">
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>