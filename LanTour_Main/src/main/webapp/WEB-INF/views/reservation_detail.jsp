<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.lan.tour.model.dto.ReservationDto"%>
<%@page import="com.lan.tour.model.dto.RoomDto"%>
<%@page import="com.lan.tour.model.dto.HotelDto"%>
<%@page import="com.lan.tour.model.dto.LantourDto"%>
<%@page import="com.lan.tour.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%MemberDto Mdto =  (MemberDto)session.getAttribute("login");%>
<%LantourDto Ldto =  (LantourDto)request.getAttribute("Ldto");%>
<%HotelDto Hdto =  (HotelDto)request.getAttribute("Hdto");%>
<%RoomDto Roodto =  (RoomDto)request.getAttribute("Roodto");%>
<%ReservationDto Resdto = (ReservationDto)request.getAttribute("Resdto"); %>
<%Date time = new Date(); %>
<%SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd"); %>
<%Date time2 = SDF.parse(Resdto.getReservation_date()); %>
<!-- // jQuery 기본 js파일 -->
<script  src="https://code.jquery.com/jquery-3.6.0.min.js"  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="  crossorigin="anonymous"></script>
<script
  integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU="
  crossorigin="anonymous"></script>
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>	
  
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
//결제
window.onload = function(){

	IMP.init("imp73387015")
}


function payment(){
	var pgtype =  document.getElementById("paymethod")
	var pgvalue = pgtype.options[pgtype.selectedIndex].value
	var Merchant_uid = 'merchant_' + new Date().getTime()
	IMP.request_pay({
	    pg : pgvalue,
	    pay_method : 'card',
	    merchant_uid : Merchant_uid,
	    name : '주문명:결제테스트',
	    amount : <%=Resdto.getReservation_price()%>,
	    buyer_email : '<%=Mdto.getMember_email()%>',
	    buyer_name : '<%=Mdto.getMember_name()%>',
	    buyer_tel : '<%=Mdto.getMember_phone()%>'
	    }, function(rsp) {
	    if ( rsp.success ) {
	    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
	    	jQuery.ajax({
	    		url: "payments.do", //cross-domain error가 발생하지 않도록 주의해주세요
	    		type: 'POST',
	    		dataType: 'json',
	    		data: {imp_uid : rsp.imp_uid},
	    		success: function(data){
	    			if (data.status =="paid" ) {
						swal("결제 완료되었습니다").then(conf=>{
		    				location.href="reservation_pay.do?no=<%=Resdto.getReservation_no()%>&m_id="+Merchant_uid
	    			    				
	    				})
					}	
	    		}
	    	});
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	        
	        swal(msg);
	    }
	});
}


</script>
</head>
<body>

<jsp:include page="./header.jsp" />

<div class="accordion-item" style="display: flex; border: 1px solid rgba(0, 0, 0, 0.125);">
	<div class="card-body" style="width: 70%; margin: auto">
		<div class="card-header" style="padding-top: 10%;padding-bottom: 30px ">
			<div class="card-title"><h4>예약자 정보</h4></div>
			<div class="card-text">
				<span class="lead">성명 : <%=Mdto.getMember_name() %></span>
			</div>
			<div class="card-text">
				<span class="lead">전화번호 :  <%=Mdto.getMember_phone() %></span>
			</div>
			<div class="card-text">
				<span class="lead">이메일 :  <%=Mdto.getMember_email() %></span>
				<input type="button"  class="btn btn-outline-primary" value="변경" onclick="#">
			</div>
			<div class="card-text">전화번호와 이메일을 확인해 주세요. 호스트로부터 전화와 이메일이 갑니다.</div>
		</div>
		<%if(Ldto ==null){ %>
		<div class="card-header" style="padding-bottom: 30px">
			<div class="card-title"><h4>여행 정보</h4></div>
			<div class="lead">소개 : <%=Roodto.getRoom_content() %></div>
			<div class="lead">최대 인원수 : <%=Roodto.getRoom_maxcount() %></div>
			<div class="lead">구비 물품 : <%=Roodto.getRoom_convinence() %></div>
			<div class="lead">여행지 정보를 한번 더 확인해 주세요</div>
		</div>
		<div class="card-header" style="padding-bottom: 10%;">
			<div class="card-title"><h4>Lantour 숙소 이용 규칙</h4></div>
			<div class="lead">
				<ul>
					<li>흡연 금지</li>
					<li>반려동물에 적합하지 않음</li>
					<li>파틴나 이벤트 금지</li>
					<li>유아(24개월 이하) 숙박에 안전하거나 적합하지 않을 수 있음</li>
					<li>체크인은 15:00 이후입니다.</li>
				</ul>
			</div>
		</div>
		<%}else{ %>
		<div class="card-header" style="padding-bottom: 30px">
			<div class="card-title"><h4>여행 정보</h4></div>
			<div class="lead">소개 : <%= Ldto.getLantour_content()%></div>
			<div class="lead">최대 인원수 : <%=Ldto.getLantour_maxcount() %></div>
			<div class="lead">Lantour 정보를 한번 더 확인해 주세요</div>
		</div>
		<div class="card-header" style="padding-bottom: 10%;">
			<div class="card-title"><h4>Lantour 이용 규칙</h4></div>
			<div class="lead">
				<ul>
					<li>반응 잘해주기</li>
					<li>궁금한거 질문하기</li>
					<li>녹화 금지</li>
					<li>리액션을 바라면 계좌이체</li>
					<li>출발 시간은 15:00입니다.</li>
				</ul>
			</div>
		</div>
		
		<%} %>
	</div>
	
	<div class="accordion-body" style="width: 30%; border: 1px solid rgba(0, 0, 0, 0.125);margin: 15px">
		
		<!-- if -->
	<%if(Ldto !=null){ %>
		
	<form action="insertReservation.do" method="post">
		<input type="hidden" name="no" value="<%=Ldto.getLantour_no()%>">
		<input type="hidden" name="rno" value="0">
		<input type="hidden" name="reservation_price" value="<%=Ldto.getLantour_price() %>">
		<input type="hidden" name="member_no" value="<%=Mdto.getMember_no() %>">
			<div class="form-group">
				<div style="width: 100%; margin-bottom: 20px;"><img style="width: 100%; height: 20%" alt="" src="<%=Ldto.getLantour_image()%>"></div>
				<div><h3><%=Ldto.getLantour_title() %> </h3></div>
			</div>
			<div class="form-group">
				<div>
					<div class="form-label mt-4">투어일자</div>
					<div><input class="form-control" style="color:black;" type="text" id="datepicker" name="reservation_date" value="<%=Resdto.getReservation_date() %>" readonly="readonly"></div>
				</div> 
			</div>
			<div class="form-group">
				<div class="form-label mt-4">총합계<input class="form-control" style="color:black;" type="text" name="reservation_price" value="<%=Ldto.getLantour_price() %>" id="reservation_price"readonly></div>
			</div>
			<div class="form-group">
				<%if(Resdto.getReservation_pay().equals("N")){ %>
				<div class="form-label mt-4">
					결제방식
				</div>
				<div id="pay">					
					<select class="form-select"  style="color: black;" id="paymethod">
						<option value="kakaopay" style="color: black;">카카오 페이</option>
						<option value="html5_inicis" style="color: black;">일반 웹결제</option>
					</select>
					<input type='button' class="btn btn-outline-primary"  value='결제' onclick='payment()'>
					<%}else if(!Resdto.getReservation_pay().equals("cancelled")){ %>
						<%if((time2.getTime()-time.getTime())/(24*60*60*1000)<=7){ %>
							<div>결제가 완료되었습니다. 이용일로부터 7일 이내이므로 이용 불가시에 호스트와 직접 연락하여 환불받으셔야 합니다.<br/>	
								Lantour에서는 회원님께 절대 송금을 요구하지 않습니다.<br/>
								언제나 금융 사기에 조심하세요<br/>
								<input type="button"  class="btn btn-outline-primary" value="숙소 페이지로 이동" onclick="location.href='roomdetail.do?room_no=<%=Roodto.getRoom_no()%>'">
								</div>					
						<%}else{ %>
							<input type="button" class="btn btn-outline-primary"  value="결제 취소" onclick="location.href='canclepay.do?no=<%=Resdto.getReservation_no()%>&id=<%=Resdto.getReservation_pay()%>'">
							<div>예약일 일주일 전까지는 100% 예약취소 가능합니다. 이후로는 호스트와 직접 연락하여 환불받으셔야 합니다.<br/>	
								Lantour에서는 회원님께 절대 송금을 요구하지 않습니다.<br/>
								언제나 금융 사기에 조심하세요<br/>
								<input type="button"  class="btn btn-outline-primary" value="숙소 페이지로 이동" onclick="location.href='roomdetail.do?room_no=<%=Roodto.getRoom_no()%>'">
								</div>					
						<%} %>
					<%}else{ %>
					<div>결제 취소된 예약입니다.</div>
					
					<%} %>
				</div>
			</div>
	</form>
		<%}else{ %>
		<input type="hidden" name="no" value="<%=Hdto.getHotel_no()%>">
		<input type="hidden" name="rno" value="<%=Roodto.getRoom_no()%>">
		<input type="hidden" name="member_no" value="<%=Mdto.getMember_no() %>">
			<div class="form-group">
				<div style="width: 100%; margin-bottom: 20px;"><img style="width: 100%; height: 20%" alt="" src="<%=Roodto.getRoom_image() %>"></div>
				<div><h3><%=Hdto.getHotel_title() %> <%=Hdto.getHotel_type() %></h3></div>
				<div><h5><%=Roodto.getRoom_name() %></h5></div>
				<div><h5><%=Hdto.getHotel_addr() %></h5></div>
			</div>
			<div class="form-group">
				<div>
					<div class="form-label mt-4">체크인</div>
					<div><input class="form-control" style="color:black;" type="text" id="datepicker" name="reservation_date" value="<%=Resdto.getReservation_date() %>" readonly="readonly"></div>
				</div> 
				<div>
					<div class="form-label mt-4">체크아웃</div>
					<div><input class="form-control" type="text" style="color:black;" id="datepicker2" name="reservation_checkout_date" value="<%=Resdto.getReservation_checkout_date() %>" readonly="readonly"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="form-label mt-4">₩<%=Roodto.getRoom_price() %> x <span id="bak"><%=Resdto.getReservation_price()/Roodto.getRoom_price() %></span>박</div>
				<div class="form-label mt-4">총합계<input class="form-control" style="color:black;" type="text" name="reservation_price" value="<%=Resdto.getReservation_price() %>" id="reservation_price"readonly></div>
			</div>
			<div class="form-group">
				<%if(Resdto.getReservation_pay().equals("N")){ %>
				<div class="form-label mt-4">
					결제방식
				</div>
				<div id="pay">
					
					<select class="form-select"  style="color: black;" id="paymethod">
						<option value="kakaopay" style="color: black;">카카오 페이</option>
						<option value="html5_inicis" style="color: black;">일반 웹결제</option>
					</select>
					<input type='button' class="btn btn-outline-primary"  value='결제' onclick='payment()'>
					<%}else if(!Resdto.getReservation_pay().equals("cancelled")){ %>
						<%if((time2.getTime()-time.getTime())/(24*60*60*1000)<=7){ %>
							<div>결제가 완료되었습니다. 이용일로부터 7일 이내이므로 이용 불가시에 호스트와 직접 연락하여 환불받으셔야 합니다.<br/>	
								Lantour에서는 회원님께 절대 송금을 요구하지 않습니다.<br/>
								언제나 금융 사기에 조심하세요<br/>
								<input type="button"  class="btn btn-outline-primary" value="투어 페이지로 이동" onclick="location.href='./lantourdetail.do?lantour_no=<%=Resdto.getLantour_no()%>'">
								</div>					
						<%}else{ %>
							<input type="button" class="btn btn-outline-primary"  value="결제 취소" onclick="location.href='canclepay.do?no=<%=Resdto.getReservation_no()%>&id=<%=Resdto.getReservation_pay()%>'">
							<div>예약일 일주일 전까지는 100% 예약취소 가능합니다. 이후로는 호스트와 직접 연락하여 환불받으셔야 합니다.<br/>	
								Lantour에서는 회원님께 절대 송금을 요구하지 않습니다.<br/>
								언제나 금융 사기에 조심하세요<br/>
								<input type="button"  class="btn btn-outline-primary" value="투어 페이지로 이동" onclick="location.href='./lantourdetail.do?lantour_no=<%=Resdto.getLantour_no()%>'">
							</div>					
						<%} %>
					<%}else{ %>
					<div>결제 취소된 예약입니다.</div>
					
					<%} %>
				</div>
			</div>
		
		<%} %>
		</div>
</div>

<jsp:include page="./footer.jsp" />





</body>
</html>