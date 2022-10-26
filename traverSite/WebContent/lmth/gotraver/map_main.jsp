<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
request.setCharacterEncoding("utf-8");
ArrayList<PlaceInfo> placeList = (ArrayList<PlaceInfo>)request.getAttribute("placeList");



int viewDayNum = 1;
String addSchedulePlaceId = "";
String addSchedulePlaceIdArr[]; // 추가한 장소들 목록을 '배열로'저장할 변수

String placeListString = "";	// 검색결과가 포함된 장소명들을 넣을 변수
String placeCategory = request.getParameter("placeCategory");
String searchKeyword = request.getParameter("searchKeyword");
boolean isHaveLodging = false; // 숙소 존재여부
boolean isHaveRestaurant = false; // 음식점 존재여부
boolean isHaveTourist = false; // 관광지 존재여부
int viewOption = 0;	// 상단 보기 결과값

if (searchKeyword == null) {
	searchKeyword = "";
}


for (int i = 0; i < placeList.size(); i++ ) { // 장소들을 가져온다.
	PlaceInfo pi = placeList.get(i);
	placeListString += ","+pi.getPi_name();
	if(pi.getPi_ctgr().equals("1")) { //카테고리가 숙소인게 있다면
		isHaveLodging = true;
	} else if(pi.getPi_ctgr().equals("2")) { // 카테고리가 음식점이라면
		isHaveRestaurant = true;
	} else if (pi.getPi_ctgr().equals("3")) { // 카테고리가 관광지인게 있다면
		isHaveTourist = true;
	}
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행 떠나기</title>  
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<link rel="stylesheet" type="text/css" href="/traverSite/file/css/gotraver_main.css" >
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script type="text/javascript" src="/traverSite/file/js/map_main_move.js" ></script>
<script type="text/javascript" src="/traverSite/file/jq/map_main_move.js" ></script>
<script type="text/javascript" src="/traverSite/file/jq/map_main_view.js" ></script>
<script type="text/javascript" src="/traverSite/file/jq/map_main_schedule_day.js" ></script>
<script type="text/javascript" src="/traverSite/file/js/map_main_calendar.js" ></script>
<script type="text/javascript" src="/traverSite/file/jq/map_main_schedule_info.js" ></script>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<!-- 좌측 사이드박스 -->
<form action="/traverSite/scheduleIn">
<% 
if (isLogin) { 
	ArrayList<ScheduleDay> scheduleDayList = (ArrayList<ScheduleDay>)session.getAttribute("scheduleDayList");
	ScheduleInfo si = (ScheduleInfo)session.getAttribute("scheduleInfo");
	int selectDay = (int)session.getAttribute("selectDay");	// 선택 일차
	String selectDate = (String)session.getAttribute("selectDate");	// 선택 일차에 해당하는 날짜
	String[] dateList = (String[])session.getAttribute("dateList"); // '일차'에 맞는 날짜들 배열
	
	if (selectDay != 0) {
%>
<div class="left-side open">
	<div class="schedule-info">
		<span class="schedule_day_num"><% if (selectDay != 0) { %>Day <% } %><%=selectDay%></span>
		<span class="schedule_day_date"><%=selectDate%></span>
	</div>
	<div class="schedule-area">
		<ul class="schedule-list sortable">
		<%
		for (int i = 0; i < scheduleDayList.size(); i ++) {	
			ScheduleDay sd = scheduleDayList.get(i);
			if (sd.getSd_dnum() == selectDay) {
				addSchedulePlaceId += "," + sd.getPi_id();
			}
			
			if (sd.getSd_dnum() == selectDay) {
		%>
			<li class="schedule ui-state-default"><%= sd.getPi_name() %>
				<button type="button" class="schedule__del float_r" value="X" onclick="scheDel()">X</button>
				<input type="hidden" data-id="<%= sd.getPi_id() %>"/>
			</li>
		<%
			}
		} 
		%>
		</ul>
	</div>
	<div class="schedule-del_box">
		<input type="button" class="schedule__all_del" value="전체 삭제" onclick="scheAllDel()"/>
	</div>
	<div>
		<button type="button"  class="side__open left_open"><img src="/traverSite/file/img/left_side_close.png" class="left__side__open_img"></button>
	</div>
</div>
	<% } %>
<!-- //좌측 사이드 박스 -->

<!-- 컨테이너 -->
<div class="main">
	<div class="main-top_area">
		<div class="schedule_date">
		<% if (si.getSi_sdate() == null) { %>
			<input type="date" class="" id="sdate" name="sdate" onchange="limitDate(); setDay(this.value, this.form.edate.value, this.form.schedule_day);"> ~
			<input type="date" id="edate" name="edate" disabled onchange="setDay(this.form.sdate.value, this.value, this.form.schedule_day);">
		<% } else {  %>
			<input type="date" class="" id="sdate" name="sdate" value="<%=si.getSi_sdate()%>"onchange="limitDate(); setDay(this.value, this.form.edate.value, this.form.schedule_day);">~
			<input type="date" id="edate" name="edate" value="<%=si.getSi_edate()%>" min="<%=si.getSi_sdate()%>" max="<%=si.getSi_max() %>"
			<% if (si.getSi_edate() == null) { %> disabled <% } %> onchange="setDay(this.form.sdate.value, this.value, this.form.schedule_day);">
		<% }  %>
		</div>
		<div class="">
			<select id="schedule_day" name="schedule_day" class="schedule_day" onchange="getDate(this.value, this.form.sdate.value);">
				<option value="" class="schedule_day1" <%if (selectDay == 0){%>selected="selected"<% } %> >일차 선택</option>
				<% 
				if (si.getSi_dnum() != 0) { 
					for(int j = 1; j <= si.getSi_dnum(); j++) {
				%>
				<option value="<%= j %>" <%if (selectDay == j) {%>selected="selected"<% } %>>Day<%=j %></option>
				<%
					}
				}
				%>
			</select>
<!-- 			<select name="schedule_group" class="schedule_group" id="">
				<option value="1">전체보기</option>
				<option value="2">추가한 장소</option>
				<option value="3">찜한 장소</option>
				<option value="4">추가 + 찜한 장소</option>
			</select> -->
		</div>
	</div>
	
	<% if (selectDay != 0) {  %>
	<!-- 일정 보러가기 -->
	<div class="main-bottom-area">
		<div class="schedule_all_view_box">
			<input type="button" class="schedule_all_view_button go_schedule" value="일정 등록 하러 가기" />
		</div>
	</div>
	
	<div class="go_schedule_area_box display_none">
		<div class="go_schedule_area">
			<div class="go_schedule_left">
				<button type="button"><img class="arrow" src="file/img/left.png" alt="&lt;" /></button>
			</div>
			<div class="schedule_item">
				<div class="go_schedule_top">
					<input type="text" id="schedule_name" name="schedule_name" class="schedule_title" placeholder="일정명을 입력하세요" />
					<div class="chedule_button_box">
						<input type="button" class="chedule_button go_map" value="지도로 돌아가기"/>
						<input type="submit" class="chedule_button save_schdule" value="내 일정 등록"/>
					</div>
				</div>
				<div class="go_schedule_contnt-area">
					<div class="go_schedule_contnt">
					<% 
					if (si.getSi_dnum() != 0) { 
						for(int i = 1; i <= si.getSi_dnum(); i++) {
					%>
						<div class="go_schedule_day_box">
							<div class="schedule-info">
								<span class="schedule_day_num">Day <%=i %></span>
								<span class="schedule_day_date"><%=dateList[i]%></span>
							</div>
							<div class="schedule-area">
								<ul class="schedule-list sortable">
								<%
								for (int j = 0; j < scheduleDayList.size(); j ++) {
									ScheduleDay sd = scheduleDayList.get(j);
									if (sd.getSd_dnum() == i) {
								%>
									<li class="schedule ui-state-default"><%= sd.getPi_name() %>
										<button type="button" class="schedule__del float_r" value="X" onclick="scheDel()">X</button>
										<input type="hidden" data-id="<%= sd.getPi_id() %>"/>
									</li>
								<% 
									}
								}
								%>
								</ul>
							<div class="schedule-del_box">
								<input type="button" class="schedule__all_del" value="전체 삭제" onclick="scheAllDel()"/>
							</div>
							</div>
						</div>
					<%
						}
					}
					%>
					</div>
				</div>
			</div>
			<div class="go_schedule_right">
				<button type="button"><img class="arrow" src="file/img/right.png" alt="&gt;" /></button>
			</div>
		</div>
	</div>
	<!-- //일정 보러가기 -->
	<% } %>
</div>
<!-- //컨테이너 -->
<% } %>

<!-- 지도 -->
<div id="map">
</div>
<!-- services와 카카오지도 라이브러리 불러오기 -->
<style>
	.label {margin-bottom: 50px; }
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2b05cef42f58551f118588eb3f26ff67&libraries=services"></script>

<style>
	.label {margin-bottom: 50px; }
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2b05cef42f58551f118588eb3f26ff67&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'),  // 지도를 표시할 div 
mapOption = { 
	center: new kakao.maps.LatLng(33.3580, 126.57000), // 지도의 중심좌표
    level: 9 // 지도의 확대 레벨
};

window.onresize = function(event){ // 윈도우 크기 size 변경되면 
	var latlng = map.getCenter(); 
	var mainPoint = new kakao.maps.LatLng(latlng.getLat(), latlng.getLng()); // 중심위치 받아와서
	map.relayout();
	map.setCenter(mainPoint); // 윈도우 크기에 맞춰 중심위치 변경
	}

var map = new daum.maps.Map(mapContainer, mapOption); // 지도 생성

<%

for (int i = 0; i < placeList.size(); i++ ) {
	PlaceInfo pi = placeList.get(i);
	
	if(addSchedulePlaceId.indexOf(pi.getPi_id()) < 0) {	// 해당 장소가 해당 날짜, 일정에 [추가된 장소]가 아니라면
%>
	var position<%=pi.getPi_id()%> = ({	// 마커의 윈도우인포에 장소 이름과 위치를 저장
		 content: "<div style='display:inline-block; margin:5px 0 5px 5px;'><%=pi.getPi_name()%></div>", 
	     latlng: new kakao.maps.LatLng<%=pi.getPi_coords()%>
	});

    var marker = new kakao.maps.Marker({ // 마커를 생성
        map: map, // 마커를 표시할 지도
        position: position<%=pi.getPi_id()%>.latlng
    });

    var infowindow = new kakao.maps.InfoWindow({ // 마커에 표시할 툴팁 생성
        content: position<%=pi.getPi_id() %>.content 
    });
    
    var listBoxes = document.querySelector('.place');
    
    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow, listBoxes));
    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));

    marker.setMap(map); // 맵에 표시

<%
	}
}
%>


var imageSrc = '/traverSite/file/img/icon_map.png', // 마커이미지의 주소
imageSize = new kakao.maps.Size(29, 42), // 마커이미지의 크기
imageOption = {offset: new kakao.maps.Point(14, 39)} // 마커이미지의 옵션. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정한다.  
var addDayMarkers = [];	//장소에 추가한 마커들을 가지고 있을 배열

<%
if (isLogin) { 
	ArrayList<ScheduleDay> scheduleDayList = (ArrayList<ScheduleDay>)session.getAttribute("scheduleDayList");
	int selectDay = (int)session.getAttribute("selectDay");
	if (scheduleDayList != null) {
		for (int j = 0 ; j < scheduleDayList.size(); j++) {
			ScheduleDay sd = scheduleDayList.get(j);
%>
			var schedulePlacePosition<%=sd.getPi_id()%> = ({	// 마커의 윈도우인포에 장소 이름과 위치를 저장
				 content: "<div style='display:inline-block; margin:5px 0 5px 5px;'><%=sd.getPi_name()%></div>", 
			    latlng: new kakao.maps.LatLng<%=sd.getSd_coords()%>
			});
<%
			switch(viewOption) {	// 0 Day별로 / 1 전체보기 / 2 추가장소 / 3 찜 / 4 추가찜
			case 0: // Day별로 보기 (선택안함)
				if (sd.getSd_dnum() == selectDay) { // 만약 '추가장소 일차'가 '현재 보여주는 일차'라면
					if(placeListString.indexOf(sd.getPi_name()) > 0) {// 장소 검색 결과에 추가한 장소가있으면
					// 추가해야함 : 선택한 카테고리값이 있다면, 그중에서 해당 장소의 카테고리가 동일하다면
%>
					var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
					markerPosition = new kakao.maps.LatLng(<%=sd.getSd_coords()%>);
					//마커의 이미지정보를 가지고 있는 마커이미지를 생성
					
					
					var schedulePlacePosition<%=sd.getPi_id()%> = ({	// 마커의 윈도우인포에 장소 이름과 위치를 저장
						 content: "<div style='display:inline-block; margin:5px 0 5px 5px;'><%=sd.getPi_name()%></div>", 
					     latlng: new kakao.maps.LatLng<%=sd.getSd_coords()%>
					});
					
				    var marker = new kakao.maps.Marker({ // 마커를 생성
				        map: map,
				        position: schedulePlacePosition<%=sd.getPi_id()%>.latlng,
				        image: markerImage, // 마커이미지 설정 
				        zIndex: 5
				    });
				    addDayMarkers.push(marker);
				    
				    var infowindow = new kakao.maps.InfoWindow({ // 마커에 표시할 툴팁 생성
				        content: schedulePlacePosition<%=sd.getPi_id() %>.content 
				    });
				    
				    var listBoxes = document.querySelector('.place');
				    
				    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow, listBoxes));
				    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));

				    marker.setMap(map); // 맵에 표시
				    
					//커스텀 오버레이의 위치, 내용
					var overlayPosition<%=sd.getPi_id()%> = new kakao.maps.LatLng<%=sd.getSd_coords() %>;
			<% if (placeCategory == null || placeCategory.equals("0")) { //선택된 카테고리가 없다면 %>
					var overlayContent = '<div class ="label"><span class="left"></span><span class="center"><%=viewDayNum %></span><span class="right"></span></div>';
			<% } else { //선택된 카테고리가 있다면  
					addSchedulePlaceIdArr = addSchedulePlaceId.split(","); // 해당 일차에 추가한 장소들을 배열로 만듦
					for (int y = 0 ; y < addSchedulePlaceIdArr.length; y++) {
						if ( addSchedulePlaceIdArr[y].equals(sd.getPi_id())) { // 현재 보이는 장소가 y번째 배열의 값이라면
			%>
					var overlayContent = '<div class ="label"><span class="left"></span><span class="center"><%= y %></span><span class="right"></span></div>';
			<%
						}
					}
				} 
			%>
					 
					 // 커스텀 오버레이를 생성
					 var customOverlay = new kakao.maps.CustomOverlay({
					     position: overlayPosition<%=sd.getPi_id()%>,
					     content: overlayContent,
					     zIndex: 5
					 });
				
					// 커스텀 오버레이를 지도에 표시
					customOverlay.setMap(map);
		<%		    				
					viewDayNum ++; // 일차 번호값 증가 
					}
				}
				break;
			case 1 : // 전체보기
		%>
				var overlayPosition<%=sd.getPi_id() %> = new kakao.maps.LatLng<%=sd.getSd_coords()%>;
				var overlayContent = '<div class ="label"><span class="left"></span><span class="center"><%=j %></span><span class="right"></span></div>';
				
				// 커스텀 오버레이를 생성
				var customOverlay = new kakao.maps.CustomOverlay({
				     position: overlayPosition<%=sd.getPi_id()%>,
				     content: overlayContent,
				     zIndex: 5
				});
			
				// 커스텀 오버레이를 지도에 표시
				customOverlay.setMap(map);
		<%
				break;
			case 2 : // 추가장소보기
				break;
			case 3: // 찜
				break;
			case 4: // 추가+찜
				break;	
			}
		}
	}
}

%>




//인포윈도우(툴팁)를 표시하는 클로저를 만드는 함수
function makeOverListener(map, marker, infowindow, listBoxes) {
    return function() {
        infowindow.open(map, marker, listBoxes);
        listBoxes.style.background = '#eff7ff';

    };
}

// 인포윈도우(툴팁)를 닫는 클로저를 만드는 함수
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
        listBoxes.style.background = 'none'; 

    };
}


function delKeyword() {
	   var frm = document.schCata;
	   schCata.searchKeyword.value = "";
	   frm.submit();
	}
	</script>
	<!-- //지도 -->
	 
	 
	 
	</form>
	<form name="schCata" id="schCata" action="#">
	<input type="hidden" id="viewDayNum" name="viewDayNum" value="<%=viewDayNum %>">
	<!-- 우측 사이드 박스 -->
	<div class="right-side open">
	   <div class="right-side_header">
	      <div class="search-box">
	         <input type="text" class="search__txt" name="searchKeyword" id="searchKeyword" placeholder="검색어를 입력하세요" onkeyup="enterkey(this.value,this.form.viewDayNum.value)" value="<%=searchKeyword %>"/>
	         <button type="button"  class="schedule__del search__del" value="X" onclick="delKeyword()">X</button>
		</div>
		<div class="ctgr-box">
		<!-- 검색 시, 보여줘야 할 00 개수 여부에따라 버튼 활성화/비활성화 -->
		<!-- js를 통해 버튼에 선택에 따라 btnSelect클래스 생성/삭제, select 클래스가있으면 배경색상변경 -->
		<!-- 검색값 여부에  따라 btnNone 클래스 생성/삭제, btnNone 클래스가 있으면 버튼 비활성화 (=onclick 이벤트 삭제) -->
	<button type="submit" name="placeCategory" value="0" class="display_none" onclick="placeCategoryChange(this.value,this.form.viewDayNum.value)">전체</button>
	<button type="submit" name="placeCategory" value="1" class="ctgr" onclick="placeCategoryChange(this.value,this.form.viewDayNum.value)">숙소</button>
	<button type="submit" name="placeCategory" value="2" class="ctgr" onclick="placeCategoryChange(this.value,this.form.viewDayNum.value)">음식점</button>
	<button type="submit" name="placeCategory" value="3" class="ctgr" onclick="placeCategoryChange(this.value,this.form.viewDayNum.value)">관광지</button>
		</div>
	</div>
</form>
<form action="/traverSite/scheduleIn">
	<div class="place-area">
	<% if (isHaveLodging) { %>
		<!-- 숙소 -->
		<div class="place-section">
		<% if (placeCategory == null || placeCategory.equals("0")) { %>
			<div class="place-section__title">숙소</div>
		<% } %>
			<div class="place-list">
		<% 
		for(int i = 0; i < placeList.size() ; i ++) { 
			PlaceInfo pi = placeList.get(i);
			if (pi.getPi_ctgr().equals("1")) {
		%>
				<div class="place">
					<div class="place__img">
						<img src="/traverSite/file/img/map_img/<%=pi.getPi_img1() %>" alt="<%=pi.getPi_name() %>섬네일 이미지" />
					</div>
					<div class="place-info">
						<div class="place__title"><%=pi.getPi_name() %></div>
						<div class="place__option-box">
							<button type="button" class="place__option place__info">정보</button>
							<button type="button" class="place__option place__review">리뷰</button>
						<% if (isLogin) { %>
							<button type="button" class="place__option place__add" value="<%=pi.getPi_id()%>" data-id="<%=pi.getPi_coords() %>" data-value="<%=pi.getPi_ctgr()%>">추가</button>
							<button type="button" class="place__option place__love">찜</button>
						<% } %>
						</div>
					</div>
				</div>
		<% 	
			} 
		}
		%>
			</div>
		</div>
		<!-- //숙소 -->
	<% } %>
	<% if (isHaveRestaurant) {  %>
		<!-- 음식점 -->
		<div class="place-section">
		<% if (placeCategory == null || placeCategory.equals("0")) { %>
			<div class="place-section__title">음식점</div>
		<% } %>
			<div class="place-list">
		<% 
		for(int i = 0; i < placeList.size() ; i ++) { 
			PlaceInfo pi = placeList.get(i);
			if (pi.getPi_ctgr().equals("2")) {
		%>
				<div class="place">
					<div class="place__img">
						<img src="/traverSite/file/img/map_img/<%=pi.getPi_img1() %>" alt="<%=pi.getPi_name() %>섬네일 이미지" />
					</div>
					<div class="place-info">
						<div class="place__title"><%=pi.getPi_name() %></div>
						<div class="place__option-box">
							<button type="button" class="place__option place__info">정보</button>
							<button type="button" class="place__option place__review">리뷰</button>
						<% if (isLogin) { %>
							<button type="button" class="place__option place__add" value="<%=pi.getPi_id()%>" data-id="<%=pi.getPi_coords() %>" data-value="<%=pi.getPi_ctgr()%>">추가</button>
							<button type="button" class="place__option place__love">찜</button>
						<% } %>
						</div>
					</div>
				</div>
		<% 	
			} 
		}
		%>
			</div>
		</div>
		<!-- //음식점 -->
	<% } %>
	<% if (isHaveTourist) {  %>
		<!-- 관광지 -->
		<div class="place-section">
		<% if (placeCategory == null || placeCategory.equals("0")) { %>
			<div class="place-section__title">관광지</div>
		<% } %>
			<div class="place-list">
		<% 
		for(int i = 0; i < placeList.size() ; i ++) { 
			PlaceInfo pi = placeList.get(i);
			if (pi.getPi_ctgr().equals("3")) {
		%>
				<div class="place">
					<div class="place__img">
						<img src="/traverSite/file/img/map_img/<%=pi.getPi_img1() %>" alt="<%=pi.getPi_name() %>섬네일 이미지" />
					</div>
					<div class="place-info">
						<div class="place__title"><%=pi.getPi_name() %></div>
						<div class="place__option-box">
							<button type="button" class="place__option place__info">정보</button>
							<button type="button" class="place__option place__review">리뷰</button>
						<% if (isLogin) { %>
							<button type="button" class="place__option place__add" value="<%=pi.getPi_id()%>" data-id="<%=pi.getPi_coords() %>" data-value="<%=pi.getPi_ctgr()%>">추가</button>
							<button type="button" class="place__option place__love">찜</button>
						<% } %>
						</div>
					</div>
				</div>
		<% 	
			} 
		}
		%>
			</div>
		</div>
		<!-- //관광지 -->
	<% } %>
	</div>
	<button type="button" class="side__open right_open"><img src="/traverSite/file/img/right_side_close.png" class="right__side__open_img"></button>
</div>
</form>

<!-- //우측 사이드 박스 -->


<%@ include file="place_review.jsp" %>
<!-- //리뷰 보기 -->

<%@ include file="place_review_form.jsp" %>
<!-- //리뷰작성 -->

<%@ include file="place_info.jsp" %>
<!-- //장소보기 -->




</body>
</html>