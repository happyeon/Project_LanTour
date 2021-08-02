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
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function () {
		paging(1);
		select_change()
	})
	function search() {
		var search = $("#select_option").val();
		var community_content = $("#community_content").val();
		var url = "";
		if (search == "title"){
			url = "community_titlesearch.do";
		} else if(search == "content"){
			url = "community_contentsearch.do";
		} else {
			url = "community_namesearch.do";
		}
		
		location.href = "./"+url+"?community_content="+community_content;
	}
	function paging(j) {
		var count = ${fn:length(list)} - ((j-1) * 10);
		var leng = document.querySelectorAll(".page-item")
		for (var i = 1; i < leng.length - 1; i++){
			if(i == j){
				leng[i].setAttribute("class","page-item active");
			} else{
				leng[i].setAttribute("class","page-item");
			}
		}
		for(var i = 0; i <= ${fn:length(list)}; i++){
			if(i>count-10&&i<=count){
				$("#"+i).css("display","");
			} else{
				$("#"+i).css("display","none");
			}
		}
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
.paging-div {
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
}

.community-div {
	min-height: 800px;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />

	<div class="community-div">
		<div class="container">
			<br>
			<h3>정보게시판</h3>
			<hr>
			<br>
			<input type="hidden" id="select_change" value="${filter }" />
			<div class="form-group">
				<select id="select_option" class="form-select" style="display: inline; width: 15%;">
					<option selected="selected" value="title">제목</option>
					<option value="content">내용</option>
					<option value="name">작성자</option>
				</select>
				<input type="text" id="community_content" class="form-label mt-4" value="${community_content }" />
				<button type="button" class="btn btn-primary" onclick="search()">검색</button>
			</div>
			<br>
			<table id="community_table" class="table table-hover">
				<thead>
					<tr style="background-color: #4582ec; color: #ffffff;">
						<th scope="col" width="100">번호</th>
						<th scope="col" width="100">작성자</th>
						<th scope="col" width="500" style="text-align: center;">제목</th>
						<th scope="col" width="100">날짜</th>
						<th scope="col" width="100">조회수</th>
					</tr>
				</thead>
				<c:set var="i" value="${fn:length(list) }" />
				<c:choose>
					<c:when test="${empty list}">
						<tr>
							<th colspan="5">------------등록된 게시글이 없습니다-----------</th>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${list }" var="dto">
							<c:choose>
								<c:when test="${'Y' eq dto.community_delflag}">
									<tr id="${i }" style="display: none">
										<th colspan="4">------------삭제된 게시글 입니다-----------</th>
									</tr>
								</c:when>
								<c:otherwise>
									<tr id="${i }" style="display: none">
										<td scope="row">${dto.community_no }</td>
										<td>${dto.member_name }</td>
										<td>
											<a href="./communitydetail.do?community_no=${dto.community_no } ">${dto.community_title } </a>
										</td>
										<td>
											<fmt:formatDate value="${dto.community_regdate }" pattern="yyyy-MM-dd" />
										</td>
										<td>${dto.community_readcount }</td>
									</tr>
								</c:otherwise>
							</c:choose>
							<c:set var="i" value="${i - 1 }" />
						</c:forEach>
					</c:otherwise>
				</c:choose>
				<c:if test="${not empty login }">
					<tr>
						<td colspan="5" align="right">
							<input type="button" class="btn btn-primary" value="게시글 등록" onclick="location.href='communityinsert.do'" />
						</td>
					</tr>
				</c:if>
			</table>
			<div class="paging-div">
				<ul class="pagination">
					<li class="page-item disabled"><span class="page-link">&laquo;</span></li>
					<c:forEach var="i" begin="0" end="${fn:length(list)/10 }">
						<li class="page-item" onclick="paging(${i+1});"><a class="page-link" href="#">${i+1 }</a></li>
					</c:forEach>
					<li class="page-item disabled"><span class="page-link">&raquo;</span></li>
				</ul>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>