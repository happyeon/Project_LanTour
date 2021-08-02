<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LanTour</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>	
<script type="text/javascript">
function update_hotel() {
	var update = confirm("투어 정보를 수정하시겠습니까?")
	if(update){
		location.href="./lantourupdate.do?lantour_no=${dto.lantour_no }";
	}
}

function guestrtc() {
	
	var member_no = $('#member_no').val();
	var lantour_no = $('#lantour_no').val();
	var lantour_rtc = $('#lantour_rtc').val();
	var member_name = $('#member_name').val();

	var checkGuest = {
			"member_no" : member_no,
			"lantour_no" : lantour_no,
	}
	
	$.ajax({
		url: 'guestCheck.do',
		type: 'post',
		data: checkGuest,
		success: function(data) {
			// reservation_pay가 y인 경우
			if(data != 'N'&&data != 'cancelled') {
				swal("환영합니다.").then(ok=>{
					location.href = lantour_rtc + "?member_name=" + member_name;					
				});
			} else {
				swal("예약한 사용자만 입장이 가능합니다.");
			}
		},
		error: function() {
			swal("통신 실패");
		}
	});

}
</script>


<body>
	<jsp:include page="header.jsp" />
	
	
	<c:set var="login_member" value="${login.member_no }" />
	<c:set var="host_member" value="${dto.member_no }" />
	<c:set var="lantour_rtc" value="${dto.lantour_rtc }" />
	<c:set var="login_grade" value="${login.member_grade }" />
	
	
	
	<div class="container">



		<table class="table table-hover">
			<thead>
				<tr style="backgound-color: #adadad; color: #ffffff;">
					<th colspan="2" scope="col" class="text-center" style="text-align: center;">투어정보</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th scope="row" style="text-align: center;"><p>투어명</p></th>
					<td>${dto.lantour_title }</td>
				</tr>
				<tr>
					<th scope="row" style="text-align: center;"><p>투어소개</p></th>
					<td>${dto.lantour_content }<br> <br> <br> <br>
						<br> <br> <br> <br>
					</td>
				</tr>

				<tr>
					<th scope="row" style="text-align: center;"><p>투어장소</p></th>
					<td>${dto.lantour_addr }</td>
				</tr>
				<tr>
					<th scope="row" style="text-align: center;"><p>미리보기</p></th>
					<td><img src="${dto.lantour_image }"></td>
				</tr>
				<tr>
					<th scope="row" style="text-align: center;"><p>최대인원</p></th>
					<td>${dto.lantour_maxcount }</td>
				</tr>
				<tr>
					<th scope="row" style="text-align: center;"><p>가격</p></th>
					<td>${dto.lantour_price }</td>
				</tr>
				<tr>
					<th scope="row" style="text-align: center;"><p>투어 일정</p></th>
					<td>${dto.lantour_date }</td>
				</tr>
			</tbody>
			<tr>
				<td colspan="2" align="center">
					<c:choose>
						<c:when test="${login_grade == 'U' }">
							<input type="button" class="btn btn-primary" value="예약" onclick="location.href='reservation.do?type=lantour&no=${dto.lantour_no}&rno=0'" />
							<input type="button" class="btn btn-primary" value="목록" onclick="location.href='lantourlist.do'" /> 
								<c:if test="${lantour_rtc != 'aaa' && lantour_rtc != 'https://ec2-3-144-4-252.us-east-2.compute.amazonaws.com:3000/aaa' }">
									<input type="hidden" id="member_no" name="member_no" value="${login.member_no }" />
									<input type="hidden" id="lantour_no" name="lantour_no" value="${dto.lantour_no }" />
									<input type="hidden" id="lantour_rtc" name="lantour_rtc" value="${lantour_rtc}" />
									<input type="hidden" id="member_name" name="member_name" value="${login.member_name}" />
									<input type="button" class="btn btn-success" value="참여하기" onclick="guestrtc()"/>
								</c:if>
						</c:when>
						<c:otherwise>
							<span>일반 회원만 이용 가능한 서비스 입니다.</span>&nbsp;&nbsp;&nbsp;&nbsp; 
						</c:otherwise>	
					</c:choose>
				</td>
			</tr>


		</table>
		<c:if test="${login_member eq host_member }">
			<div>
				<div class="form-group" align="center">
					<input type="button" class="btn btn-primary" value="수정" onclick="location.href='lantourupdate.do?lantour_no=${dto.lantour_no}'" />
					<input type="button" class="btn btn-primary" value="삭제" onclick="location.href='lantourdelete.do?lantour_no=${dto.lantour_no}'" />
					<form action="https://ec2-3-144-4-252.us-east-2.compute.amazonaws.com:3000" method="post" style="display: inline;">
				  		<input type="hidden" value="${login.member_grade }" name="member_grade">
				  		<input type="hidden" value="${login.member_no }" name="member_no">
				  		<input type="hidden" value="${dto.lantour_no }" name="lantour_no">
				  		<input type="hidden" value="${login.member_name }" name="member_name">
				  		<input type="submit" class="btn btn-success" id="open" value="랜선투어 방 생성">
					</form>		
				</div>
			</div>
		</c:if>
	<br><br><br>
	<embed height="800px" width="100%" src="https://ec2-3-144-4-252.us-east-2.compute.amazonaws.com:8443/tour/reviewlist.do?type=lantour&no=${dto.lantour_no}" ></embed>	
	</div>

	<jsp:include page="footer.jsp" />
</body>
</html>