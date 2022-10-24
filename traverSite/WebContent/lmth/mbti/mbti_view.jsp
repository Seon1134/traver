<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
GoodPost goodPost = (GoodPost)request.getAttribute("goodPost");
boolean isGood = (boolean)request.getAttribute("isGood");
boolean isInterest = (boolean)request.getAttribute("isInterest");
GoodInfo goodInfo = (GoodInfo) request.getAttribute("goodInfo");
ArrayList<GoodDay> goodDayList = (ArrayList<GoodDay>) request.getAttribute("goodDayList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추천 글 보기</title>
<style>
.container-default_box { position: relative; }
.btn { 
	height: 20px;
	background: inherit ; border: none; box-shadow: none; border-radius: 0; 
	padding: 0; overflow: visible; cursor: pointer;
	float: right; margin-right: 10px; text-align: middle;
}
#section1 { width: 1000px; margin: 50px auto; padding-bottom: 50px; position: relative; }
#title { font-size: 25px; font-weight: bold; }
#goodicon, #interest, #report { width: 30px; vertical-align: middle; margin-right: 3px;}
#goodcnt2 { float: right; margin-right: 10px; }
.ctt_font { font-size: 18px; line-height: 1.5; }
#writer { position: relative; top: 4px; }
#lastup, #date { font-size: 13px; float: right; margin-right: 10px; margin-top: 13px;}
hr { margin: 15px 0;}
#schname, #placename { font-size: 20px; font-weight: bold; }
#schdetail { font-size: 15px; }
#dayselect { width: 100px; height: 30px; }
#map { border: 1px solid #888; }
#contentbox { width: 100%; margin-bottom: 20px;  }
#updatebtn, #deletebtn { float: left; margin-right: 5px; }
#list { float: right; top: -500px;  }


#section2 { 
	width: 600px; margin: auto; border: 1px solid black; 
	padding: 20px; background-color: #fff;
	position: absolute; top: 225px; left: 280px;   
	z-index: 3;
}
#x { float: right; width: 20px; }
#placeimg1 { width: 300px; height: 300px; margin-bottom: 5px; object-fit: cover; }
.descimg { width:65px; height:65px; margin-right:8px; padding-bottom:0px; object-fit: cover;}
#placedesc { float: right; }
#placedetail { width: 270px; }
#placename { margin-bottom: 10px; }
#placeinfo { margin-top: 20px; line-height:1.7; }


#section3 {
	border: 1px solid black;  width: 480px;
	padding: 20px; background-color: #fff;
	position: absolute; top: 100px; left: 280px;   
	z-index: 3; line-height: 2;
}
#report-title { font-size: 22px; font-weight: bold; }
#report-hr { margin-bottom: 5px; }
.red { color: red; }
#report1 { height: 35px; background-color:#DEEBF7; font-weight: bold; font-size: 16px; margin-top: 10px; padding-top: 4px;}
#report2 { padding: 10px; border: 1px solid #DEEBF7; }
.btn2{ float: none; display :inline-block; }
#button { text-align: center; }
.btn3 { height: 35px; }
.display_none { display: none; }
</style>
<script src="file/jq/jquery-3.6.1.js"></script>
<script>
window.onload = function(){
	const pin = document.querySelector('#pin');
	const section2 = document.querySelector('#section2');
	const x = document.querySelector('#x');
	
	pin.addEventListener('click', function() {
		section2.classList.remove('display_none');
	});
	
	x.addEventListener('click', function() {
		section2.classList.add('display_none');
	});
	
	const cancel = document.querySelector('#cancel');
	const report = document.querySelector('#report');
	const section3 = document.querySelector('#section3');

	report.addEventListener('click', function() {
		section3.classList.remove('display_none');
	});
	
	cancel.addEventListener('click', function() {
		section3.classList.add('display_none');
	});
	
}
</script>
<script>
var clickCnt = 0;

	function postDel() {
		if (confirm("게시물을 삭제하시겠습니까?")) {
			var Delfrm = document.Delfrm;
			Delfrm.submit();
		}
	}
	function swapImg(img) {
		var big = document.getElementById("placeimg1");
		big.src = "file/img/" + img;
	}
	function bigImg() {
		var big = document.getElementById("placeimg1");
		big.src = "file/img/silla1.jpg";
	}
	function gcntUpdate(gpid, giid, miid) {
		if ( clickCnt == 0 ) {
			$.ajax({
				type : "POST",
				url : "/traverSite/postView",
				data : {
					"gpid" : gpid, 
					"giid" : giid,
					"miid" : miid,
					"kind" : "good"
				},
				success : function(result) {
					if (result == 0) {
						alert("좋아요에 실패했습니다.\n다시 시도하세요.");
					}
					clickCnt++;
					location.reload();
				}
			});
		}
	}
	function goodUpdate(gpid, giid, miid) {
		$.ajax({
			type : "POST",
			url : "/traverSite/postView",
			data : {
				"gpid" : gpid, 
				"giid" : giid,
				"miid" : miid,
				"kind" : "interest"
			},
			success : function(result) {
				if (result == 0) {
					alert("관심등록에 실패했습니다.\n다시 시도하세요.");
				}
				location.reload();
			}
		});
	}
</script>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<div class="container">
   <div class="container-default_box">
   		<div id="section1">
   		<form name="mbtiViewFrm" action="/traverSite/postFormUp" method="post">
   		<input type="hidden" name="gpid" value="<%=goodPost.getGp_id()%>">
   		<input type="hidden" name="giid" value="<%=goodPost.getGi_id()%>">
   		<input type="hidden" name="title" value="<%=goodPost.getGp_title()%>">
   		<input type="hidden" name="nickname" value="<%=goodPost.getMi_nickname()%>">
   		<input type="hidden" name="mbti" value="<%=goodPost.getGp_mbti()%>">
   		<input type="hidden" name="giname" value="<%=goodInfo.getGi_name()%>">
   		<input type="hidden" name="list" value="<%=goodPost.getGp_list()%>">
   		<input type="hidden" name="content" value="<%=goodPost.getGp_content()%>">
			<span id="title"><%=goodPost.getGp_title() %></span>
			<% if ( isLogin ) { %>
			<button type="button" class="btn"><img src="file/img/report.png" id="report" alt="신고"></button>
			<button type="button" class="btn" id="interestbtn" onclick="goodUpdate('<%=goodPost.getGp_id() %>', '<%=goodPost.getGi_id() %>','<%=loginInfo.getMi_id() %>');">
			<img src=<% if ( isInterest ) { %>"file/img/bookmark2.png" <% } else { %> "file/img/bookmark1.png" <% } %> 
			id="interest" alt="관심등록"></button>
			<button type="button" class="btn" id="goodbtn" onclick="gcntUpdate('<%=goodPost.getGp_id() %>', '<%=goodPost.getGi_id() %>','<%=loginInfo.getMi_id() %>');">
			<img src=<% if ( isGood ) { %>"file/img/goood2.png" <% } else { %> "file/img/goood1.png" <% } %>
			id="goodicon" alt="좋아요"><span id="goodcnt"> 추천 : <%=goodPost.getGp_gcnt() %></span></button>
			<% } else { %> 
			<span id="goodcnt2"> 추천 : <%=goodPost.getGp_gcnt() %></span>
			<% } %>
			<br>
			<span class="ctt_font" id="writer"><%=goodPost.getMi_nickname() %>(<%=goodPost.getGp_mbti() %>)</span>
			<% if ( goodPost.getGp_last() != null ) { %>
			<span id="lastup">마지막 수정 : <%=goodPost.getGp_last() %></span>
			<% } %>
			<span id="date">등록일 : <%=goodPost.getGp_date() %></span>
			<hr>
			<p id="schname"><%=goodInfo.getGi_name() %></p><br>
			<%=goodPost.getGp_list() %>
   			<hr>
   			<select id="dayselect">
   				<% 
					if ( goodInfo != null ) {
						for ( int i = 1; i <= goodInfo.getGi_dnum(); i++ ) { 
				%>
								<option value="<%=i %>"><%=i %>일차</option>
				<%			
						}
					}
				%>
   			</select><button type="button" class="btn" id="pin">지도 핀</button><br><br>
			<div id="map" style="width:100%;height:350px;"></div>
			<style>
				.label {margin-bottom: 50px; }
			</style>
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2b05cef42f58551f118588eb3f26ff67&libraries=services"></script>
			<script>
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div ID 넣기
			    mapOption = { 
			        center: new kakao.maps.LatLng(33.3880, 126.60000), // 지도의 중심좌표 : 제주도로 설정해놨어
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
		                   content: "<div style='display:inline-block; margin:5px 0 5px 5px;'><%=gd.getGd_name()%></div>", 
		                    latlng: new kakao.maps.LatLng<%=gd.getGd_coords()%>
		               });
					
					var marker = new kakao.maps.Marker({ // 마커를 생성
				        map: map, // 마커를 표시할 지도
				        position: position<%=gd.getPi_id()%>.latlng, 
				        image: markerImage, // 마커이미지 설정 
				        zIndex: 5
				    });
		               
	                var infowindow = new kakao.maps.InfoWindow({ // 마커에 표시할 툴팁 생성
	                    content: position<%=gd.getPi_id()%>.content 
	                });
	                
	                marker.setMap(map); // 맵에 표시
	                
	              	//커스텀 오버레이의 위치, 내용
					var overlayPosition<%=gd.getPi_id()%> = new kakao.maps.LatLng<%=gd.getGd_coords() %>;
					var overlayContent = '<div class ="label"><span class="left"></span><span class="center"><%=goodDayList.get(1).getGd_seq() %></span><span class="right"></span></div>';
	             	
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
			<div id="contentbox">
   				<span class="ctt_font" id="content"><%=goodPost.getGp_content() %></span>
   			</div>
   			<hr>
   			<% if ( isLogin && loginInfo.getMi_id().equals(goodPost.getMi_id()) ) { %>
   			<button type="submit" class="btn" id="updatebtn"><img class="btn3" src="file/img/rewrite.png" id="updateimg" alt="수정"></button>
   			</form>
 			<form name="Delfrm" action="/traverSite/postProcDel" method="post">
   			<button type="button" class="btn" id="deletebtn" onclick="postDel();"><img class="btn3" src="file/img/delete.png" id="deleteimg" alt="삭제"></button>
   			<input type="hidden" name="kind" value="list">
   			<input type="hidden" name="gp_id" value="<%=goodPost.getGp_id() %>">
   			</form>
   			<% } %>
   			<a href="/traverSite/postList"><button type="button" class="btn" id="list"><img class="btn3" src="file/img/list.png" id="list" alt="목록"></button></a>
   		
   		</div>
   		<div class="display_none" id="section2">
   			<img src="file/img/silla1.jpg" id="placeimg1">
			<div id="placedesc">
			<img src="file/img/x.png" id="x"><br>
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
				</div>
				</div>
			</div>
			<img src="file/img/silla2.jpg" id="placeimg2" class="descimg" onmouseover="swapImg('silla2.jpg');" onmouseout="bigImg();">
			<img src="file/img/silla3.jpg" id="placeimg3" class="descimg" onmouseover="swapImg('silla3.jpg');" onmouseout="bigImg();">
			<img src="file/img/silla4.jpg" id="placeimg4" class="descimg" onmouseover="swapImg('silla4.jpg');" onmouseout="bigImg();">
			<img src="file/img/silla5.jpg" id="placeimg5" class="descimg" onmouseover="swapImg('silla5.jpg');" onmouseout="bigImg();">
		</div>
		<div class="display_none" id="section3">
			<form name="reportFrm" action="/traverSite/report">
			<input type="hidden" name="gp_id" value="<%=goodPost.getGp_id() %>">
			<span id="report-title">신고하기</span>
			<hr id="report-hr">
			<span class="red">* 반복된 허위신고시 서비스 활동이 제한될 수 있습니다.</span><br>
			<span class="red">* 신고한 게시글은 회원님의 게시글 목록에서 사라집니다.</span>
			<div id="report1">&nbsp;&nbsp;신고사유</div>
			<div id="report2">
			<input type="radio" name="report" value="lewd" id="lewd"><label for="lewd"> 음란성 리뷰</label><br>
			<input type="radio" name="report" value="advert" id="advert"><label for="advert"> 광고성 리뷰</label><br>
			<input type="radio" name="report" value="insult" id="insult"><label for="insult"> 욕설/부적절한 언어</label><br>
			<input type="radio" name="report" value="disturb" id="disturb"><label for="disturb"> 회원 분란 유도</label><br>
			<input type="radio" name="report" value="slander" id="slander"><label for="slander"> 회원 비방</label><br>
			<input type="radio" name="report" value="defamation" id="defamation"><label for="defamation"> 명예훼손/저작권 침해</label><br>
			<input type="radio" name="report" value="portrait_rights" id="portrait_rights"><label for="portrait_rights"> 초상권 침해/도촬</label><br>
			<input type="radio" name="report" value="plaster" id="plaster"><label for="plaster"> 도배성 리뷰</label><br>
			</div>
			<br>
			<div id="button">
			<button type="submit" class="btn btn2"><img class="btn3" src="file/img/ok.png" id="reportsubmit" alt="확인"></button>&nbsp;&nbsp;&nbsp;
			<button type="button" class="btn btn2" id="cancel"><img class="btn3" src="file/img/cancel.png" id="reportcancel" alt="취소"></button>
			</div>
			</form>
		</div>
   </div>
</div>
<%@ include file="../../cni/footer.jsp" %>
</body>
</html>