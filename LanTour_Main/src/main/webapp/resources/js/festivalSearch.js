	function festivalSearch(val) {
		window.scrollTo({top:0, left:0, behavior:'auto'});
		if (val == null) {
			val = 1;
		}
		var pageNo = val;

		var sdate = $('#eventStartDate').val();
		if (sdate == "") {
			alert("시작 날짜를 선택해주세요.");
			return;
		}
		var edate = $('#eventEndDate').val();
		var ssdate = sdate.split('-');
		var eedate = edate.split('-');
		
		var eventStartDate = ssdate[0] + ssdate[1] + ssdate[2];
		var eventEndDate = eedate[0] + eedate[1] + eedate[2];

		var areaCode = $('#areaCode option:selected').val();
		var arrange = $('#arrange option:selected').val();
		 $.ajax({
			 url: './festivallist.do',
			 type: 'GET',
			 data: {
				 'pageNo': pageNo,
				 'eventStartDate' : eventStartDate,
				 'eventEndDate' : eventEndDate,
				 'areaCode' : areaCode,
				 'arrange' : arrange
			 },
			 dataType: 'json',
			 success: function(data) {
				console.log(data);
				document.getElementById("paging").innerHTML = "";
				var myData = data.response.body.items.item;
				if (myData == null) {
					alert("해당하는 조건에 만족하는 결과가 없습니다. 조건을 다시 설정해주세요.");
					var output = "";
					document.getElementById("festivalSearchList").innerHTML = output;
				} else {
					var festivalSearchList = $("#festivalSearchList");
					festivalSearchList.html("");
					var output = "";
					var count = 0;
					for(var i = 0; i < myData.length; i++){
						count++;
						output = "";
						// 제목, 시작일, 종료일, 주소
						title = myData[i].title;
						firstimage = myData[i].firstimage;
						eventstartdate = myData[i].eventstartdate;
						eventenddate = myData[i].eventenddate;
						addr1 = myData[i].addr1;
						
						contentid = myData[i].contentid;
						contenttypeid = myData[i].contenttypeid;
	
						stSdate = String(eventstartdate);
						stEdate = String(eventenddate);
						
						
						
						startStr = stSdate.substr(0,4) + "-" + stSdate.substr(4,2) + "-" + stSdate.substr(6,2)
						endStr = stEdate.substr(0,4) + "-" + stEdate.substr(4,2) + "-" + stEdate.substr(6,2)
						
						output += "<div class=\"fes\" onclick=\"location.href='festivaldetail.do?contentid=" + contentid +"&eventstartdate="+eventstartdate+"&eventenddate="+eventenddate+"'\"><img src=\""+firstimage+"\" alt='image'><br>";
						output += "<br><h4 style=\"color: #3984F3;\">"+title+"</h4>";
						output += "<p>" + startStr + "&nbsp;&nbsp;~&nbsp;&nbsp;"+endStr+"</p>"; 

						output += "<p>" + addr1 + "</p></div>"
						

						document.getElementById("festivalSearchList").innerHTML += output;
					}
					// 한 페이지에 출력될 게시글 수
					var numOfRows = data.response.body.numOfRows;
					// 현재 페이지 넘버
					var pageNo = data.response.body.pageNo;
					// 전체 게시글
					var totalCount = data.response.body.totalCount;
					
					var pageCount = 5;
					var totalPage = Math.ceil(totalCount/numOfRows);
					var pageGroup = Math.ceil(pageNo/pageCount);
					
					
					var last = pageGroup * pageCount;
					if (last > totalPage) {
						last = totalPage;
					}
					var first = last - (pageCount-1);
					if (last%pageCount != 0 && pageGroup != 1) {
						first = (pageCount * (pageGroup - 1)) + 1
					}
					if (first < 1) {
						first = 1;
					}
					var next = last + 1;
					var prev = first - 1;


					var page = "";
					
					if(prev > 0) {
						page += "<button  name=\""+prev+"\" onclick=\"festivalSearch(this.name);\">&laquo;</button>&nbsp;"
					}

					for(var i=first; i <= last; i++){
						page += "<button  value=\""+i+"\" onclick=\"festivalSearch(this.value);\">"+i+"</button>&nbsp;"
					}

					if(last < totalPage) {
						page += "<button  name=\""+next+"\" onclick=\"festivalSearch(this.name);\">&raquo;</button>"
					}
					document.getElementById("paging").innerHTML += page;

					
				}
				
			 },
			 error: function() {
				 alert("통신 실패");
			 }
		 });
		 
		
	}