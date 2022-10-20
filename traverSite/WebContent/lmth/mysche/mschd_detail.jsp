<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 일정 상세보기</title>
<style>
.container-default_box { padding: 0px 100px 0px 100px; }
#title { color: #000; }
#subtitle { font-size: 25px; font-weight: bold; margin: 0px 70px 50px 10px;}
#map { border: 1px solid #888; }

#myschd { width: 100%; height: 100%; border: 1px solid #BDD7EE; margin-bottom: 70px; }
#schd_name, #daybox { font-size: 20px; font-weight: bold; }

#schd_name { float: left; margin-top: 4px;}
.btn { cursor: pointer; }
#rec { float: right; font-size: 15px; color: #888; margin: 7px 5px 0 0; }
#recbtn { float: right; background: none;  font-size: 14px; height: 30px; }

#daybox { background-color: #EDEDED; padding: 10px; }
#placebox { padding: 10px; }
#myschd .daytd { padding: 0px; border: 1px solid #BDD7EE; cursor: pointer; }

#placebox { padding: 15px; }
.place { padding-bottom: 10px; }
.tableBox { overflow:auto; width:100%; }
.mouseEventBox:hover { background: #efefef;  width:100%; height:180px; }
#title_td { padding-top: 6px; }
</style>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ScheduleInfo si = (ScheduleInfo)request.getAttribute("si");
ArrayList<ScheduleDay> schdDayList = si.getSchdDayList();

for (int i = 0; i < schdDayList.size(); i ++) {	
	ScheduleDay sd = schdDayList.get(i);
	//out.println(sd.getSd_id());
}
// out.println(si.getSi_dnum()); //출력확인용

%>
<div class="container">
   <div class="container-default_box" style="height:1200px;">
   		<br><br><br><br>
   		<a href="mschdDetail?siid=<%=si.getSi_id() %>" id="title"><span id="subtitle">내 일정 상세보기</span></a><br><br><br><br>
   		<select name="dayselect" id="">
   			<option value="">일차 선택</option>
<%
if ( si != null ) {
	for ( int i = 1; i <= si.getSi_dnum(); i++ ) {	
%>
			<option value="<%=i %>"><%=i %>일차 </option>
<%  
	}
} 
%>
		</select><br><br>
		<div id="map" style="width:100%; height:350px;"></div>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2b05cef42f58551f118588eb3f26ff67&libraries=services"></script>
		<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div ID 넣기
		    mapOption = { 
		        center: new kakao.maps.LatLng(33.3880, 126.60000), // 지도의 중심좌표 : 제주도로 설정해놨어
		        level: 10 // 지도의 확대 레벨 : 줄이거나 늘리면댐
		    };
		
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		</script>
		<br>
		<div class="tableBox">
			<table id="myschd" cellspacing="0" width="100%" >
				<tr bgColor="#BDD7EE" height="50" width="100%">
					<td colspan="5" id="title_td">
						<span id="schd_name">제목 : <%=si.getSi_name() %></span>
						<a href="/traverSite/postFormIn?siid=<%=si.getSi_id() %>"><button type="button" class="btn" id="recbtn">MBTI 일정 추천</button></a>
						<span id="rec">회원님과 같은 MBTI에게 일정을 추천해보세요</span>
					</td>
				</tr>

<%
if (si.getSi_dnum() != 0) { 	// DAY가 있으면
	int i = 1;
	for (i = 1; i < si.getSi_dnum() + 1 ; i ++) {	
		if (i % 6 == 0) 	out.println("<tr width='100%'>");
%>			
				<td class="daytd" width="20%">
					<div class="mouseEventBox">
						<a href="#" width="180" height="180"> <!-- 일차정보를 가지고 여행떠나기 메인으로 이동 -->
							<div id="daybox">
								<span class="day"> <%=i %>일차 </span>
							</div>
		<%
		for (int j = 0; j < schdDayList.size(); j ++) {
			ScheduleDay sd = schdDayList.get(j);
			if (sd.getSd_dnum() == i) { // 일차번호(1일차, 2일차,,)가 일차수와 같다면
		%>
							<div id="placebox">
								<p class="place"><%= sd.getPi_name() %> </p>
							</div>
		<% 
			}
		}
%>
						</a>
					</div>
				</td>
				
<%		
		if (i % 6 == 5) 	out.println("</tr>");
	}
		
		if (i % 6 > 0) {	// 일정이 5개 단위로 맞아 떨어지지 않았을 경우
			for (int k = 0; k < (6 - 1) ; k++) out.println("<td width='20%'></td>");
			out.println("</tr>");
		} // 빈 칸으로 5개를 채워준 후 </tr>을 닫아줌
		
} else {	// 일차 목록이 없으면
		out.println("등록된 일차가 없습니다.");
	}
out.println("</table>");
%>
		
		</div> <!-- tableBox -->
		
   </div>
</div>
<%@ include file="../../cni/footer.jsp" %>
</body>
</html>