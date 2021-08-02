<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanToure</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="./resources/css/board_detail.css">
<link href='resources/css/bootstrap.min.css' rel='stylesheet' />
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>	
<script type="text/javascript">
	function popupclose(){

		$.ajax({
			type : 'POST',
			url : 'notice_popup_close.do',
			success : function(data) {
				if (data.popup == true) {
					window.close()
				} else {
					swal("실패했습니다.");
				}
			},
			error : function() {
				swal("통신 실패");
			}
		})
	}

</script>
</head>
<body>
	<input type="hidden" value="${dto.notice_no }" id="notice_no">
	<c:set var="member_grade" value="${login.member_grade }" />
	
	
	<br><br>
	<div class="finalproject_board">
		<div class="board_main">
			<div>
				<div class="board_category">
					<span class="board_category">
						<span class="board_category_input"> 공지사항 </span>
					</span>
				</div>
				<div class="board_info">
					<div>
						<span class="board_title">
							<span class="board_title_input"> ${dto.notice_title } </span>
						</span>
					</div>

				</div>
				<div class="board_date">
					<span class="board_date">
						<span class="board_info_date">
							<fmt:formatDate value="${dto.notice_date }" pattern="yyyy-MM-dd" />
						</span>
					</span>
				</div>
			</div>
			<hr>
			<div class="board_content">${dto.notice_content }</div>
			
				<div>
				<input type="button" class="btn btn-primary" onclick="popupclose()" value="오늘은 그만보기"/>
				
				</div>
		</div>
	</div>
</body>	
</html>