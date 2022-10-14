<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 일정 상세보기</title>
<style>
.container-default_box { padding: 0px 100px 0px 100px; }
#title { color: #000; }
#subtitle { font-size: 25px; font-weight: bold; margin: 0px 70px 50px 10px;}
#dayselect { width: 100px; height: 30px; cursor: pointer; }  
#map { border: 1px solid #888; }

#myschd { width: 100%; height: 100%; border: 1px solid #BDD7EE; margin-bottom: 70px; }
#schd_name, #daybox { font-size: 20px; font-weight: bold; }
#myschd td { padding: 10px; }

#schd_name { float: left; margin-top: 4px;}
#rec { float: right; font-size: 15px; color: #888; margin: 7px 5px 0 0; }
.btn { cursor: pointer; }
#recbtn { float: right; background: none;  font-size: 14px; width: 120px; height: 30px; }

#daybox { background-color: #EDEDED; padding: 10px; }
#placebox { padding: 10px; }
#myschd .daytd { padding: 0px; border: 1px solid #BDD7EE; cursor: pointer; }
#placebox { padding: 15px; }
.place { padding-bottom: 10px; }
</style>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<%
// "siid" 처리 
%>
<div class="container">
   <div class="container-default_box">
   		<br><br><br><br>
   		<a href="mschd_detail.jsp" id="title"><span id="subtitle">내 일정</span></a><br><br><br><br>
   		<select id="dayselect">
			<option value="day1">1일차</option>
			<option value="day1">여기두 나중에 수정</option>
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
		<table id="myschd" cellspacing="0">
		<tr bgColor="#BDD7EE" height="50">
		<td colspan="5" id="title_td">
		<span id="schd_name">여행 일정 제목</span>
		<a href="../mbti/mbti_form_in.jsp"><button type="button" class="btn" id="recbtn">MBTI 일정 추천</button></a>
		<span id="rec">회원님과 같은 MBTI에게 일정을 추천해보세요</span>
		</td></tr>
		<tr>
		<td class="daytd" width="20%">
			<div id="daybox">
			<span class="day"> 1일차 </span>
			</div>
			<div id="placebox">
			<p class="place"> 장소 </p><br>
			<p class="place"> 장소 </p><br>
			<p class="place"> 장소 </p><br>
			<p class="place"> 장소 </p><br>
			<p class="place"> 장소 </p><br>
			<p class="place"> 장소 </p><br>
			</div>
		</td>
		<td class="daytd" width="20%">
			<div id="daybox">
			<span class="day"> 2일차 </span>
			</div>
			<div id="placebox">
			<p class="place"> 장소 </p>
			</div>
		</td>
		<td class="daytd" width="20%">
			<div id="daybox">
			<span class="day"> 3일차 </span>
			</div>
			<div id="placebox">
			<p class="place"> 장소 </p><br>
			<p class="place"> 장소 </p><br>
			<p class="place"> 장소 </p><br>
			<p class="place"> 장소 </p><br>
			<p class="place"> 장소 </p><br>
			</div>
		</td>
		<td class="daytd" width="20%">
			<div id="daybox">
			<span class="day"> 4일차 </span>
			</div>
			<div id="placebox">
			<p class="place"> 장소 </p>
			</div>
		</td>
		<td class="daytd" width="20%">
			<div id="daybox">
			<span class="day"> 5일차 </span>
			</div>
			<div id="placebox">
			<p class="place"> 장소 </p>
			</div>
		</td>
		</tr>
		<tr>
		<td class="daytd" width="20%">
			<div id="daybox">
			<span class="day"> 6일차 </span>
			</div>
			<div id="placebox">
			<p class="place"> 장소 </p>
			</div>
		</td>
		</tr>
		</table>
   </div>
</div>
<%@ include file="../../cni/footer.jsp" %>
</body>
</html>