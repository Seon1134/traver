<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>

<!-- 장소보기 -->
<div class="display_none" id="place_info_box">
 	<img src="/traverSite/file/img/silla1.jpg" id="placeimg">
	<div id="placedesc">
		<img src="/traverSite/file/img/x.png" class="place_x"><br>
		<br>
		<div id="placedetail">
			<span id="placename">신라 호텔</span><br><br>
		<div id="placeinfo">
			<span>
			번호 : 064 – 123 - 4567<br>
			위치 : 제주 특별자치도 제주시 도련일동 1789-2<br>
			홈페이지 : jeju.co.kr<br>
			주차 시설 완벽, 주변 관광지와 가까움<br>
			주변에 맛집도 많음<br>
			</span>
		<% 
		if(isLogin) { 
			int selectDay = (int)session.getAttribute("selectDay");	// 선택 일차
			if (selectDay != 0) {
		%>
			<div class="place_info_option_box">
				<button class="place_info_option place__add">추가</button> |
				<button class="place_info_option place__review">리뷰</button> |
				<button class="place_info_option place__love">찜</button>
			</div>
		<% 
			}
		}
		%>
		</div>
		</div>
	</div>
	<img src="/traverSite/file/img/silla1.jpg" id="placeimg1" class="descimg" onclick="swapImg('silla1.jpg');">
	<img src="/traverSite/file/img/silla2.jpg" id="placeimg2" class="descimg" onclick="swapImg('silla2.jpg');">
	<img src="/traverSite/file/img/silla3.jpg" id="placeimg3" class="descimg" onclick="swapImg('silla3.jpg');">
	<img src="/traverSite/file/img/silla4.jpg" id="placeimg4" class="descimg" onclick="swapImg('silla4.jpg');">
</div>
