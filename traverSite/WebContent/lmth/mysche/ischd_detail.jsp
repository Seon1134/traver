<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관심 일정 상세보기</title>
<script>
function postDel() {
	alert("추천 글이 삭제되었습니다.");
 } 
 
</script>
<style>
.container-default_box { padding: 0px 100px 0px 100px; }
#title { color: #000; }
#subtitle { font-size: 25px; font-weight: bold; margin: 0px 70px 50px 10px;}
#dayselect { height: 31px; width: 97px; }
#map { border: 1px solid #888; }

#myschd { width: 100%; height: 100%; border: 1px solid #C5E0B4; margin-bottom: 70px; }
#schd_name, #daybox { font-size: 20px; font-weight: bold; }

#schd_name { float: left; margin: 7px;}
.btn { cursor: pointer; }
#recpost, #insert {     
	border-radius: 12px;
    border: 2px solid #6e8d74;
    float: right;
    background: none;
    font-size: 14px;
    height: 33px;
    line-height: 0;
    margin: 2px 10px;
    background: rgb(200, 200, 200, 0.5);
}
#insert { width: 130px; margin-right: -5px; }
#recpost { width: 100px; }


#daybox { background-color: #EDEDED; padding: 10px; }
#placebox { padding: 10px; }
#myschd .daytd { padding: 0px; border: 1px solid #c5e0b4; cursor: pointer; }


.place { padding-bottom: 10px; }
.tableBox { overflow:auto; width:100%; }
.mouseEventBox:hover { background: #efefef;  width:100%;  } 

#title_td { padding-top: 6px; }
</style>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<%
request.setCharacterEncoding("utf-8");
GoodInfo gi = (GoodInfo)request.getAttribute("gi");
GoodInfo fullgi = (GoodInfo)request.getAttribute("fullgi");
ArrayList<GoodDay> goodDayList = gi.getGoodDayList();
ArrayList<GoodDay> fullGoodDayList = fullgi.getGoodDayList();
GoodPost goodPost = (GoodPost)request.getAttribute("goodPost");
// out.println(goodPost.getGp_id());
String day = "1";
if (request.getAttribute("day") != null ){
	day = (String)request.getAttribute("day");
}

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
   		<select name="day" id="dayselect" onchange="location.href='/traverSite/ischdDetail?giid=<%=gi.getGi_id() %>&day=' + this.value;">
<%
if ( gi != null ) {
	for ( int i = 1; i <= gi.getGi_dnum(); i++ ) {	
%>
			<option value="<%=i %>" <%if (day.equals(i+"")) {%> selected <%} %>><%=i %>일차 </option>
<%  
	}
} 
%>
		</select><br><br>
		<div id="map" style="width:100%; height:500px;"></div>
		<style>
			.label {margin-bottom: 50px; }
			.customoverlay {position:relative;bottom:50px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
			.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
			.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
			.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
			.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
		</style>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2b05cef42f58551f118588eb3f26ff67&libraries=services"></script>
		<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div ID 넣기
		    mapOption = { 
		        center: new kakao.maps.LatLng(33.4000, 126.55000), // 지도의 중심좌표 : 제주도로 설정해놨어
		        level: 10 // 지도의 확대 레벨 : 줄이거나 늘리면댐
		    };
		
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		<%
		if ( goodDayList != null ){
			for (int i = 0; i < goodDayList.size(); i++ ) {
				GoodDay gd = goodDayList.get(i);
				%> 
				var imageSrc = '/traverSite/file/img/icon_map.png', // 마커이미지의 주소
				imageSize = new kakao.maps.Size(29, 42), // 마커이미지의 크기
				imageOption = {offset: new kakao.maps.Point(14, 39)} // 마커이미지의 옵션. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정한다.  
				
				var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
				markerPosition = new kakao.maps.LatLng(<%=gd.getGd_coords()%>);
				
				var position<%=gd.getPi_id()%> = ({   // 마커의 윈도우인포에 장소 이름과 위치를 저장
                    content: '<span><%=gd.getGd_name()%></span>', 
                    latlng: new kakao.maps.LatLng<%=gd.getGd_coords()%>
               });
				
				var marker = new kakao.maps.Marker({ // 마커를 생성
			        map: map, // 마커를 표시할 지도
			        position: position<%=gd.getPi_id()%>.latlng, 
			        image: markerImage, // 마커이미지 설정 
			        zIndex: 5
			    });
                
			    marker.setMap(map)
			    
			    var content = '<div class="customoverlay">' +
				    '<a href="#"><span class="title"><%=gd.getGd_name()%></span></a>' +
				    '</div>';
				
				// 커스텀 오버레이가 표시될 위치입니다 
				var position = new kakao.maps.LatLng<%=gd.getGd_coords()%>;  
				
				// 커스텀 오버레이를 생성합니다
				var customOverlay1 = new kakao.maps.CustomOverlay({
				    map: map,
				    position: position,
				    content: content,
				    yAnchor: 1, 
				    zIndex: 6
				});
			    
			    //인포윈도우(툴팁)를 표시하는 클로저를 만드는 함수
				function makeOverListener(map, marker, infowindow) {
				    return function() {
				        infowindow.open(map, marker);
				
				    };
				}
				
				// 인포윈도우(툴팁)를 닫는 클로저를 만드는 함수
				function makeOutListener(infowindow) {
				    return function() {
				        infowindow.close();
				
				    };
				}
                
              	//커스텀 오버레이의 위치, 내용
				var overlayPosition<%=gd.getPi_id()%> = new kakao.maps.LatLng<%=gd.getGd_coords() %>;
				var overlayContent = '<div class ="label"><span class="left"></span><span class="center"><%=goodDayList.get(i).getGd_seq() %></span><span class="right"></span></div>';
             	
				// 커스텀 오버레이를 생성
				 var customOverlay = new kakao.maps.CustomOverlay({
				     position: overlayPosition<%=gd.getPi_id()%>,
				     content: overlayContent,
				     zIndex: 5
				 });
			
				// 커스텀 오버레이를 지도에 표시
				customOverlay.setMap(map);
             	<%
             } 
         }   
         %>
		</script>
		<br>
		
		<div class="tableBox">
			<table id="myschd" cellspacing="0" width="100%" >
				<tr bgColor="#C5E0B4" height="50" width="100%">
					<td colspan="5" id="title_td">
					<%if (goodPost.getGp_id() != null) { %>
						<span id="schd_name">일정명 : <%=gi.getGi_name() %> | 작성자 : <%=goodPost.getMi_nickname()%></span>
						<a href="/traverSite/postView?gpid=<%=goodPost.getGp_id() %>&giid=<%=gi.getGi_id()%>&miid=<%=gi.getMi_id()%>"><button type="button" class="btn" id="recpost">추천글 보기</button></a>
					<%} else { %>
						<span id="schd_name">일정명 : <%=gi.getGi_name() %> | 작성자 : <% %></span>
						<a href="#"><button type="button" class="btn" id="recpost" onclick="postDel()">추천글 보기</button></a>
					<%} %>
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
						<a href="#" width="180" height="100%"> <!-- 일차정보를 가지고 여행떠나기 메인으로 이동 -->
							<div id="daybox">
								<span class="day"> <%=i %>일차 </span>
							</div>
		<%
		for (int j = 0; j < fullGoodDayList.size(); j ++) {
			GoodDay gd = fullGoodDayList.get(j);
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