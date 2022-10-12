<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
request.setCharacterEncoding("utf-8");
ArrayList<PlaceInfo> placeList = (ArrayList<PlaceInfo>)request.getAttribute("placeList");
String placeCategory = request.getParameter("placeCategory");
String searchKeyword = request.getParameter("searchKeyword");
boolean isHaveLodging = false; // 숙소 존재여부
boolean isHaveRestaurant = false; // 음식점 존재여부
boolean isHaveTourist = false; // 관광지 존재여부

if (searchKeyword == null) {
	searchKeyword = "";
}


for (int i = 0; i < placeList.size(); i++ ) { // 장소들을 가져온다.
	PlaceInfo pi = placeList.get(i);
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
<script type="text/javascript" src="/traverSite/file/jq/map_main_move.js" ></script>
<script type="text/javascript" src="/traverSite/file/jq/map_main_view.js" ></script>
<script type="text/javascript" src="/traverSite/file/jq/map_main_schedule_day.js" ></script>
<script type="text/javascript" src="/traverSite/file/jq/map_main_schedule_info.js" ></script>
<script type="text/javascript" src="/traverSite/file/js/map_main_move.js" ></script>
<script type="text/javascript" src="/traverSite/file/js/map_main_calendar.js" ></script>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<!-- 좌측 사이드박스 -->
<form action="#">
<% 
if (isLogin) { 
	ArrayList<ScheduleDay> scheduleDayList = (ArrayList<ScheduleDay>)session.getAttribute("scheduleDayList");
	ScheduleInfo si = (ScheduleInfo)session.getAttribute("scheduleInfo");
	String selectDate = (String)session.getAttribute("selectDate");
	String selectDay = (String)session.getAttribute("selectDay");
	
	if (!selectDay.equals(" ")) {
%>
<div class="left-side open">
	<div class="schedule-info">
		<span class="schedule_day_num"><%=selectDay%></span>
		<span class="schedule_day_date"><%=selectDate%></span>
	</div>
	<div class="schedule-area">
		<ul class="schedule-list sortable">
		<%
		for (int i = 0; i < scheduleDayList.size(); i ++) {	
			ScheduleDay sd = scheduleDayList.get(i);
		%>
			<li class="schedule ui-state-default"><%= sd.getPi_name() %>
				<button type="button" class="schedule__del float_r" value="X" onclick="scheDel()">X</button>
				<input type="hidden" data-id="<%= sd.getPi_id() %>"/>
			</li>
		<% } %>
		</ul>
	</div>
	<div class="schedule-del_box">
		<input type="button" class="schedule__all_del" value="전체 삭제" onclick="scheAllDel()"/>
	</div>
	<div>
		<button type="button"  class="side__open left_open"><img src="../../file/img/open.png" class="side__open_img"></button>
	</div>
</div>
	<% } %>
<!-- //좌측 사이드 박스 -->

<!-- 컨테이너 -->
<div class="main">
	<div class="main-top_area">
		<div class="schedule_date">
		<% if (si.getSi_sdate() == null) { %>
			<input type="date" class="" id="sdate" name="sdate" onchange="limitDate(); setDay(this.value, this.form.edate.value, this.form.schedule_day);">~
			<input type="date" id="edate" name="edate" disabled onchange="setDay(this.form.sdate.value, this.value, this.form.schedule_day);">
		<% } else {  %>
			<input type="date" class="" id="sdate" name="sdate" value="<%=si.getSi_sdate()%>"onchange="limitDate(); setDay(this.value, this.form.edate.value, this.form.schedule_day);">~
			<input type="date" id="edate" name="edate" value="<%=si.getSi_edate()%>"disabled onchange="setDay(this.form.sdate.value, this.value, this.form.schedule_day);">
		<% }  %>
		</div>
		<div class="">
			<select id="schedule_day" name="schedule_day" class="schedule_day" onchange="getDate(this.value, this.form.sdate.value);">
				<% //if () %>
				<option value="" class="schedule_day1">일차 선택</option>
				
			</select>
			<select name="schedule_group" class="schedule_group" id="">
				<option value="1">전체보기</option>
				<option value="2">추가한 장소</option>
				<option value="3">찜한 장소</option>
				<option value="4">추가 + 찜한 장소</option>
			</select>
		</div>
	</div>
	<div class="main-bottom-area">
		<div class="schedule_all_view_box">
			<input type="button" class="schedule_all_view_button go_schedule" value="일정 보러가기" />
		</div>
	</div>
	
	<% if (!selectDay.equals(" ")) {  %>
	<!-- 일정 보러가기 -->
	<div class="go_schedule_area_box display_none">
		<div class="go_schedule_area">
			<div class="go_schedule_left">
				<button><img src="" alt="&lt;" /></button>
			</div>
			<div class="schedule_item">
				<div class="go_schedule_top">
					<input type="text" class="schedule_title" placeholder="일정명을 입력하세요" />
					<div class="chedule_button_box">
						<input type="button" class="chedule_button go_map" value="지도로 돌아가기"/>
						<input type="button" class="chedule_button save_schdule" value="내 일정 등록"/>
					</div>
				</div>
				<div class="go_schedule_contnt-area">
					<div class="go_schedule_contnt">
						<div class="go_scheduel_day_box">
							<div class="schedule-info">
								<span class="schedule_day_num">Day 1</span>
								<span class="schedule_day_date">2022-09-18</span>
							</div>
							<div class="schedule-area">
								<ul class="schedule-list sortable">
									<li class="schedule ui-state-default">제주호텔
										<button type="button" class="schedule__del float_r" value="X" onclick="scheDel()">X</button>
										<input type="hidden" />
									</li>
									<li class="schedule ui-state-default">제주음식점
										<button type="button" class="schedule__del float_r" value="X" onclick="scheDel()">X</button>
										<input type="hidden" />
									</li>
								</ul>
							<div class="schedule-del_box">
								<input type="button" class="schedule__all_del" value="전체 삭제" onclick="scheAllDel()"/>
							</div>
							</div>
						</div>
						<div class="go_scheduel_day_box">
							<div class="schedule-info">
								<span class="schedule_day_num">Day 2</span>
								<span class="schedule_day_date">2022-09-19</span>
							</div>
							<div class="schedule-area">
								<ul class="schedule-list sortable">
									<li class="schedule ui-state-default">호텔신라
										<button type="button" class="schedule__del float_r" value="X" onclick="scheDel()">X</button>
										<input type="hidden" />
									</li>
									<li class="schedule ui-state-default">음식점신라
										<button type="button" class="schedule__del float_r" value="X" onclick="scheDel()">X</button>
										<input type="hidden" />
									</li>
								</ul>
							<div class="schedule-del_box">
								<input type="button" class="schedule__all_del" value="전체 삭제" onclick="scheAllDel()"/>
							</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="go_schedule_right">
				<button><img src="" alt="&gt;" /></button>
			</div>
		</div>
	</div>
	<!-- //일정 보러가기 -->
	<% } %>
</div>
<!-- //컨테이너 -->
<% } %>


 

<!-- 우측 사이드 박스 -->
<div class="right-side open">
	<div class="right-side_header">
		<div class="search-box">
			<input type="text" class="search__txt" name="searchKeyword" placeholder="검색어를 입력하세요" onkeyup="enterkey(this.value)" value="<%=searchKeyword %>"/>
			<button type="button"  class="schedule__del search__del" value="X" onclick="schDel()">X</button>
		</div>
		<div class="ctgr-box">
		<!-- 검색 시, 보여줘야 할 00 개수 여부에따라 버튼 활성화/비활성화 -->
		<!-- js를 통해 버튼에 선택에 따라 btnSelect클래스 생성/삭제, select 클래스가있으면 배경색상변경 -->
		<!-- 검색값 여부에  따라 btnNone 클래스 생성/삭제, btnNone 클래스가 있으면 버튼 비활성화 (=onclick 이벤트 삭제) -->
	<button name="placeCategory" value="0" class="display_none" onclick="placeCategoryChange(this.value)">전체</button>
	<button name="placeCategory" value="1" class="ctgr" onclick="placeCategoryChange(this.value)">숙소</button>
	<button name="placeCategory" value="2" class="ctgr" onclick="placeCategoryChange(this.value)">음식점</button>
	<button name="placeCategory" value="3" class="ctgr" onclick="placeCategoryChange(this.value)">관광지</button>
		</div>
	</div>
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
						<img src="<%=pi.getPi_img1() %>" alt="<%=pi.getPi_name() %>섬네일 이미지" />
					</div>
					<div class="place-info">
						<div class="place__title"><%=pi.getPi_name() %></div>
						<div class="place__option-box">
							<button class="place__option place__info">정보</button>
							<button class="place__option place__review">리뷰</button>
							<button class="place__option place__add" value="<%=pi.getPi_id()%>">추가</button>
							<button class="place__option place__love">찜</button>
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
						<img src="#" alt="" />
					</div>
					<div class="place-info">
						<div class="place__title"><%=pi.getPi_name() %></div>
						<div class="place__option-box">
							<button class="place__option place__info">정보</button>
							<button class="place__option place__review">리뷰</button>
						<% if (isLogin) { %>
							<button class="place__option place__add">추가</button>
							<button class="place__option place__love">찜</button>
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
						<img src="#" alt="" />
					</div>
					<div class="place-info">
						<div class="place__title"><%=pi.getPi_name() %></div>
						<div class="place__option-box">
							<button class="place__option place__info">정보</button>
							<button class="place__option place__review">리뷰</button>
						<% if (isLogin) { %>
							<button class="place__option place__add">추가</button>
							<button class="place__option place__love">찜</button>
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
	<button class="side__open right_open"><img src="../../file/img/open.png" class="side__open_img"></button>
</div>

<!-- //우측 사이드 박스 -->
</form>


<%@ include file="place_review.jsp" %>
<!-- //리뷰 보기 -->

<%@ include file="place_review_form.jsp" %>
<!-- //리뷰작성 -->

<%@ include file="place_info.jsp" %>
<!-- //장소보기 -->



<!-- 지도 -->
<div id="map">
</div>
<!-- //지도 -->
<!-- services와 카카오지도 라이브러리 불러오기 -->
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
        content: position<%=pi.getPi_id()%>.content 
    });
    
    var listBoxes = document.querySelector('.place');
    
    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow, listBoxes));
    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));

<% } %>

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
</script>
</body>
</html>