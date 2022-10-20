<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관심 일정 상세보기</title>
<style>
.container-default_box { padding: 0px 100px 0px 100px; }
#title { color: #000; }
#subtitle { font-size: 25px; font-weight: bold; margin: 0px 70px 50px 10px;}
#map { border: 1px solid #888; }

#myschd { width: 100%; height: 100%; border: 1px solid #C5E0B4; margin-bottom: 70px; }
#schd_name, #daybox { font-size: 20px; font-weight: bold; }

#schd_name { float: left; margin-top: 4px;}
.btn { cursor: pointer; }
#recpost, #insert { float: right; background: none; font-size: 14px; height: 30px;  }
#insert { width: 130px; margin-right: 10px; }
#recpost { width: 100px; }


#daybox { background-color: #EDEDED; padding: 10px; }
#placebox { padding: 10px; }
#myschd .daytd { padding: 0px; border: 1px solid #c5e0b4; cursor: pointer; }


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
GoodInfo gi = (GoodInfo)request.getAttribute("gi");
ArrayList<GoodDay> goodDayList = gi.getGoodDayList();

for (int i = 0; i < goodDayList.size(); i ++) {	
	GoodDay gd = goodDayList.get(i);
	//out.println(gd.getGd_id());
}
//out.println(gi.getGi_name()); //출력확인용

%>
<div class="container">
   <div class="container-default_box" style="height:1200px;">
   		<br><br><br><br>
   		<a href="ischdDetail?giid=<%=gi.getGi_id() %>" id="title"><span id="subtitle">관심 일정 상세보기</span></a><br><br><br><br>
   		<select name="dayselect">
			<option value="">일차 선택</option>
<%
if ( gi != null ) {
	for ( int i = 1; i <= gi.getGi_dnum(); i++ ) {	
%>
			<option value="<%=i %>"><%=i %>일차 </option>
<%  
	}
} 
%>
		</select><br><br>
		<div id="map" style="width:100%;height:350px;"></div>
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
				<tr bgColor="#C5E0B4" height="50" width="100%">
					<td colspan="5" id="title_td">
						<span id="schd_name">제목 : <%=gi.getGi_name() %> | 작성자 : <%=gi.getGi_nickname() %></span>
						<a href="/traverSite/postView?giid=<%=gi.getGi_id()%>"><button type="button" class="btn" id="recpost">추천글 보기</button></a>
						<a href="#"><button type="button" class="btn" id="insert">내 일정으로 등록</button>
					</td>
				</tr>

<%
if (gi.getGi_dnum() != 0) { 	// DAY가 있으면
	int i = 1;
	for (i = 1; i < gi.getGi_dnum() + 1 ; i ++) {	
		if (i % 6 == 0) 	out.println("<tr width='100%'>");
%>			
				<td class="daytd" width="20%">
					<div class="mouseEventBox">
						<a href="#" width="180" height="180"> <!-- 일차정보를 가지고 여행떠나기 메인으로 이동 -->
							<div id="daybox">
								<span class="day"> <%=i %>일차 </span>
							</div>
		<%
		for (int j = 0; j < goodDayList.size(); j ++) {
			GoodDay gd = goodDayList.get(j);
			if (gd.getGd_dnum() == i) { // 일차번호(1일차, 2일차,,)가 일차수와 같다면
		%>
							<div id="placebox">
								<p class="place"><%= gd.getGd_name() %> </p>
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