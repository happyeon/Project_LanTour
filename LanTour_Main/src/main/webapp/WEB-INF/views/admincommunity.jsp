<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(function () {
		paging(1);
		select_change();
	});
	
	function paging(j) {
		var count = ${fn:length(c_list)} - ((j-1) * 10);
		var leng = document.querySelectorAll(".page-item")
		for (var i = 1; i < leng.length - 1; i++){
			if(i == j){
				leng[i].setAttribute("class","page-item active");
			} else{
				leng[i].setAttribute("class","page-item");
			}
		}
		for(var i = 0; i <= ${fn:length(c_list)}; i++){
			if(i>count-10&&i<=count){
				$("#"+i).css("display","");
			} else{
				$("#"+i).css("display","none");
			}
		}
	}
	function search() {
		var search = $("#select_option").val();
		var community_content = $("#community_content").val();
		var url = "";
		if (search == "title"){
			url = "admincommunity_titlesearch.do";
		} else if(search == "content"){
			url = "admincommunity_contentsearch.do";
		} else {
			url = "admincommunity_namesearch.do";
		}
		
		location.href = "./"+url+"?community_content="+community_content;
	}
	function select_change() {
		var change = $("#select_change").val();
		if(change == ""){
			$("#select_option").val("title").prop("selected",true);
		} else {
			$("#select_option").val(change).prop("selected",true);
		}
	}
</script>
<style type="text/css">
.admin {
	margin: auto;
	width: 1000px;
}

.paging-div {
	margin-left: 46%;
}
</style>

</head>
<body>
	<jsp:include page="header.jsp" />


	<div class="container">
		<ul class="nav nav-pills">
			<li class="nav-item"><a class="nav-link" href="adminmember.do">회원관리</a></li>
			<li class="nav-item"><a class="nav-link active" href="admincommunity.do">커뮤니티 게시판 글 목록</a></li>
			<li class="nav-item"><a class="nav-link" href="adminchart.do">차트 보기</a></li>
		</ul>
		<br>
		<div class="form-group">
			<input type="hidden" id="select_change" value="${filter }" />
			<select id="select_option" class="form-select" style="display: inline; width: 15%;">
				<option selected="selected" value="title">제목</option>
				<option value="content">내용</option>
				<option value="name">작성자</option>
			</select>
			<input type="text" id="community_content" class="form-label mt-4" value="${community_content }" />
			<button type="button" class="btn btn-primary" onclick="search()">검색</button>
		</div>
		<br>
		<table border="1" class="table table-hover text-center">
			<tr style="background-color: #4582ec; color: #ffffff;">
				<th scope="col">번호</th>
				<th scope="col">제목</th>
				<th scope="col">작성일</th>
				<th scope="col">관리</th>
			</tr>
			<c:choose>
				<c:when test="${empty c_list }">
					<tr>
						<th colspan="3">----작성된 게시글 없음------</th>
					</tr>
				</c:when>
				<c:otherwise>
					<c:set var="i" value="${fn:length(c_list) }" />
					<c:forEach items="${c_list }" var="dto">

						<tr id="${i }">
							<td>${dto.community_no }</td>
							<td>${dto.community_title }</td>
							<td>
								<fmt:formatDate value="${dto.community_regdate }" pattern="yyyy-MM-dd" />
							</td>
							<td>
								<c:if test="${dto.community_delflag eq 'Y' }">
									<input type="button" value="복구" class="btn btn-primary btn-sm" onclick="location.href='admincommunity_refaire.do?community_no=${dto.community_no}'" />
								</c:if>
								<input type="button" value="삭제" class="btn btn-primary btn-sm" onclick="location.href='admincommunityAlldelete.do?community_no=${dto.community_no }'" />
							</td>
						</tr>
						<c:set var="i" value="${i-1 }"></c:set>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		<div class="paging-div">
			<ul class="pagination">
				<li class="page-item disabled"><span class="page-link">&laquo;</span></li>
				<c:forEach var="i" begin="0" end="${fn:length(c_list)/10 }">
					<li class="page-item" onclick="paging(${i+1});"><a class="page-link" href="#">${i+1 }</a></li>
				</c:forEach>
				<li class="page-item disabled"><span class="page-link">&raquo;</span></li>
			</ul>
		</div>
	</div>
	<br />
	<br />

	<jsp:include page="footer.jsp" />
</body>
</html>