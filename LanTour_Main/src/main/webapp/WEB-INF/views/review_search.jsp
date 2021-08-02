<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.lan.tour.model.dto.MemberDto"%>
<%@page import="java.util.Map"%>
<%@page import="com.lan.tour.model.dto.ReviewDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<!-- summernote js,css 링크 -->
<script type="text/javascript" src="./resources/summernote/summernote-lite.js"></script>
<script type="text/javascript" src="./resources/summernote/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="./resources/summernote/summernote-lite.css">
<script type="text/javascript">
<%List<ReviewDto> list = (List<ReviewDto>)request.getAttribute("list"); %>
<%Map<String,String> map = (Map<String,String>)request.getAttribute("map"); %>
<%Map<String,Integer> Smap = (Map<String,Integer>)request.getAttribute("Smap"); %>
<%MemberDto login = (MemberDto)session.getAttribute("login"); %>
<%String type= (String)request.getAttribute("type"); %>
<%String sort= (String)request.getAttribute("sort"); %>
<%String filter= (String)request.getAttribute("filter"); %>
<%DateFormat format = new SimpleDateFormat("yyyy/MM/dd");%>

	$(function() {
		paging(0)
		$('.summernote').summernote({
			placeholder : '후기를 작성해주세요',
			minHeight : 250,
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
			url : "reviewupload.do",
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
		const StarScore = document.getElementById("starScore")
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
		writeReview()

	}

	function paging(i){
		$('html').scrollTop(0);
		var reviews = document.getElementsByClassName("reviews")
		var page_item = document.querySelectorAll(".page-item")
		for(var j = 0; j<page_item.length;j++){
			if(j==i){
				page_item[j].setAttribute("class", "page-item active" )
				page_item[j].removeAttribute("onclick")
			}else{
				page_item[j].setAttribute("class", "page-item" )
				page_item[j].setAttribute("onclick", "paging("+j+")" )

				
			}
		}
		for(var j = 0; j<reviews.length;j++){
			if(j>=i*10&&j<(i+1)*10){
				document.getElementById("review"+j).style.display = "block"
			}else{
				document.getElementById("review"+j).style.display = "none"
				
				
			}
		}
	}

	function writeReview(){
		var write = document.getElementById("writeReview")		
		write.style.display = "block"
		var list = document.getElementById("reviewList")		
		list.style.display = "none"
		var Search = document.getElementById("reviewSearch")
		Search.style.display = "none"
		var writeButton = document.getElementById("writeButton")		
		writeButton.style.display = "none"
		var writebox= document.getElementById("writebox")		
		writebox.style.width = "100%"
	}

	function backReview(){
		var write = document.getElementById("writeReview")		
		write.style.display = "none"
		var list = document.getElementById("reviewList")		
		list.style.display = "block"
		var writeButton = document.getElementById("writeButton")		
		writeButton.style.display = "block"
		var Search = document.getElementById("reviewSearch")
		Search.style.display = "block"
		var writebox= document.getElementById("writebox")		
		writebox.style.width = "30%"
	}
	

</script>
<body style="padding: 0;">
<div class="bs-docs-section" style="display: flex;">
		<%if(login!=null&&login.getMember_no()!=(int)request.getAttribute("host_no")){ %>	
	<div id="writebox" class="bs-component card border-secondary mb-3" style="width: 475px;">
		<form action="ReviewInsert.do" method="post">
			<input type="hidden" name="no" value="<%=(int)request.getAttribute("no")%>">
			<input type="hidden" name="type" value="<%=type %>"/>			
			<div class="card-header" style="background-color: #ecf3fd;">
				<h3>평가하기</h3>
			</div>
			<div class="card-body">
				<div style="margin-bottom:20px ">
					<h6>다른 사용자에게 의견을 들려주세요</h6>
				</div>
				<div style="margin-bottom:20px ">
					<h3>
						<input type="hidden" value="0" name="review_score" id="starScore">			
						<span id="star1" onclick="starPick(1)"> ☆ </span>
						<span id="star2" onclick="starPick(2)"> ☆ </span>
						<span id="star3" onclick="starPick(3)"> ☆ </span>
						<span id="star4" onclick="starPick(4)"> ☆ </span>
						<span id="star5" onclick="starPick(5)"> ☆ </span>
					</h3>
				</div>
				<div style="margin-bottom:20px ">
					<input type="button" class="btn btn-outline-primary" id="writeButton" value="리뷰 작성하기" onclick="writeReview()">
				</div>
				<div id="writeReview" style="display: none;">
					<div>
						<span><textarea rows="10" cols="30" name="review_title" class="summernote"></textarea> </span>
					</div>
					<div>
						<input type="submit" class="btn btn-outline-primary" value="작성">
						<input type="button" class="btn btn-outline-primary" value="취소" id="writeButton" onclick="backReview()">
					</div>
				</div>
			</div>
		</form>
	</div>
			<%} %>	
	
	<div class="bs-component card border-secondary mb-3" id="reviewSearch"  style="width: 475px; margin-top: 0;<%if(login!=null){%>margin-left: 50px<%} %>">	
		<div class="card-header" style="background-color: #ecf3fd;">
			<h3>리뷰 검색</h3>
		</div>

		<form action="reviewsearch.do" method="post">
			<div class="card-body">
				<input type="hidden" name="no" value="<%=(int)request.getAttribute("no")%>">
				<input type="hidden" name="type" value="<%=type %>"/>		
				<div >
					<div style="margin-bottom:20px ">
						<h6 style="display: inline">별점 </h6>
						<span>
							<input type="checkbox" <%if(Smap.get("zero")==0){ %> checked="checked" <%} %> class="form-check-input"  name = "star" value="0"><label class="form-check-label"  >★0</label>
							<input type="checkbox" <%if(Smap.get("one")==1){ %> checked="checked" <%} %> class="form-check-input" name = "star" value="1"><label class="form-check-label"  >★1</label>
							<input type="checkbox" <%if(Smap.get("two")==2){ %> checked="checked" <%} %> class="form-check-input" name = "star" value="2"><label class="form-check-label"  >★2</label>
							<input type="checkbox" <%if(Smap.get("three")==3){ %> checked="checked" <%} %> class="form-check-input" name = "star" value="3"><label class="form-check-label"  >★3</label>
							<input type="checkbox" <%if(Smap.get("four")==4){ %> checked="checked" <%} %> class="form-check-input" name = "star" value="4"><label class="form-check-label"  >★4</label>
							<input type="checkbox" <%if(Smap.get("five")==5){ %> checked="checked" <%} %> class="form-check-input" name = "star" value="5"><label class="form-check-label"  >★5</label>
						</span></div >
					<div style="margin-bottom:20px ">
						<h6 style="display: inline">정렬 기준</h6>
						<select  class="form-select" name="filter" style="width: 60%; display: inline;">
							<option <%if(filter.equals("date")){ %> selected="selected" <%} %>  value="date">날짜</option>
							<option <%if(filter.equals("star")){ %> selected="selected" <%} %>  value="star">별점</option>
						</select>
					</div>
					<div style="margin-bottom:20px ">
						<h6 style="display: inline">정렬 방법</h6>
						<select class="form-select" name="sort" style="width: 60%; display: inline;">
							<option <%if(sort.equals("ASC")){ %> selected="selected" <%} %>  value="ASC">오름차순</option>
							<option <%if(sort.equals("DESC")){ %> selected="selected" <%} %>  value="DESC">내림차순</option>
						</select>
					</div>
					<input type="submit" class="btn btn-outline-primary" value="검색"/>
				</div>
			</div>
		</form>
	</div>
</div>

<div id="reviewList">

<div class="bs-docs-section">
<%if(list.size()==0){ %>
<div class="bs-component card border-secondary mb-3">
	<div class="card-header" style="background-color: #ecf3fd">리뷰가 존재하지 않습니다</div>
</div>
<%}else{ 
	int i = 0;%>
	<%for(ReviewDto dto : list){ %>
		<div class="reviews" id="review<%=i++%>">
			<div class="bs-component card border-secondary mb-3">
				<div class="card-header" style="background-color: #ecf3fd">
					<span><b><%=map.get(""+dto.getMember_no()) %></b></span>
					<span style="position: absolute; right: 0; margin-right: 20px">
					<%if(login!=null&& login.getMember_no()==dto.getMember_no()){ %>
					<input type="button" class="btn btn-outline-primary" value="수정" onclick="location.href='ReviewUpdate.do?type=<%=type %>&review_no=<%=dto.getReview_no()%>'"/>
					<input type="button" class="btn btn-outline-primary" value="삭제" onclick="location.href='ReviewDelete.do?type=<%=type %>&review_no=<%=dto.getReview_no()%>'"/>	
					<%} %>
					</span>
					<br/>
					<span><%for(int k=0; k < dto.getReview_score();k++){%>★<%} %><%for(double k= (5-dto.getReview_score()) ; k > 0;k--){%>☆<%} %></span>
					<span><%=format.format(dto.getReview_date()) %></span>	
				</div>
				<div class="card-body">
					<span class="card-text"><%=dto.getReview_title() %></span>
				</div>
			</div>
			<%if(login!=null&&login.getMember_no()==dto.getMember_no()){%>
			<%} %>
		</div>	
	<%} %>
		<div id="defaultSearch" style="margin-left:50% ">
			<ul class="pagination pagination-sm">
			<%for(int j = 0;j<=list.size()/10;j++){%>
				<li class="page-item" onclick="paging(<%=j%>)"><a class="page-link" href="#"><%=j+1 %></a></li>						
			<% }%>
			</ul>
		</div>
<%} %>
</div>
</div>
</body>
</html>