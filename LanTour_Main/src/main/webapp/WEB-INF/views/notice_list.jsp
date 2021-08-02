<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
<link href='resources/css/bootstrap.min.css' rel='stylesheet' />
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>	

<script type="text/javascript">
	function search() {
		var category = $(".search_category option:selected").val();
		var keyword = $(".search_keyword").val();
		if (keyword.trim() == '') {
			swal('검색어를 입력해주세요.');
			return false;
		}
		location.href = 'noticeList_category.do?category=' + category
				+ '&keyword=' + keyword + '&nowPage=1';
	}
	window.onload = function() {
		var cate = document.getElementById("selected_cate").value;
		if (cate == "") {
			$('.search_category').val('n_t').prop("selected", true);
		} else {
			$('.search_category').val(cate).prop("selected", true);
		}
	}
</script>
<style type="text/css">
.notice_frame {
	position: absolute;
	left: 10%;
	right: 10%;
}
.pagination {
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
}
#writeBtn {
	position: absolute;
	right: 5%;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<c:set var="member_grade" value="${login.member_grade }" />

	
	<div class="container">
	<br>
	<h3>공지사항</h3><hr>
	<br>
	<div class="row flex-center mb-5">
		<input type="hidden" id="selected_cate" value="${dto.category}">
		<div class="searchFrame">
			<select class="search_category">
				<option value="n_t">제목</option>
				<option value="n_c">내용</option>
				<option value="n_t_c">제목 + 내용</option>
			</select>
			<input type="text" class="search_keyword" value="${dto.keyword }">
			<button onclick="search();" class="btn btn-primary">검색</button>
		</div>
		<br><br><br>
		<table class="table table-hover">
			<thead>
				<tr style="background-color:#4582ec; color:#ffffff; ">
					<th scope="col" width="50" style="text-align: center;">번호</th>
					<th scope="col" width="500" style="text-align: center;">제목</th>
					<th scope="col" width="100" style="text-align: center;">날짜</th>
				</tr>
			</thead>
			<c:choose>
				<c:when test="${empty list }">
					<tr>
						<th colspan="3">----작성된 글이 없습니다---</th>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${list }" var="dto">
						<tr>
							<td style="text-align: center;">${dto.notice_no }</td>
							<td>
								<a href="noticeSelectOne.do?notice_no=${dto.notice_no }">${dto.notice_title }</a>
							</td>
							<td style="text-align: center;">
								<fmt:formatDate value="${dto.notice_date }" pattern="yyyy-MM-dd" />
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>

		</table>
		
		<div>
			<c:if test="${login.member_grade == 'A' }">
				<button type="button" id="writeBtn" class="btn btn-primary" onclick="location.href='noticeInsertForm.do'">글작성</button>
				
			</c:if>
		</div>
	
	<br><br>
	<div>
		<ul class="pagination">
			<li class="page-item">
				<c:if test="${dto.nowBlock > 1}">
					<a class="page-link" href="noticeList_category.do?nowPage=${dto.blockBegin-1}&category=${dto.category}&keyword=${dto.keyword}">&laquo;</a>
				</c:if>
			</li>
		
		
		
		
			<c:forEach begin="${dto.blockBegin}" end="${dto.blockEnd}" var="index">
				<c:choose>
					<c:when test="${dto.nowPage eq index}">
						<li class="page-item active">
							<a class="page-link" href="#">${index}</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="noticeList_category.do?nowPage=${index}&category=${dto.category}&keyword=${dto.keyword}">${index}</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		
		
			<c:if test="${dto.nowBlock < dto.totalBlock}">
				<li class="page-item">
					<a class="page-link" href="noticeList_category.do?nowPage=${dto.blockEnd+1}&category=${dto.category}&keyword=${dto.keyword}">&raquo;</a>
				</li>
			</c:if>
		</ul>
	</div>
</div>
</div>
	<jsp:include page="footer.jsp" />
	
</body>
</html>