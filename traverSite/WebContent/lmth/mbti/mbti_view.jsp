<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
GoodPost goodPost = (GoodPost)request.getAttribute("goodPost");
int result = (int)request.getAttribute("isGood");
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
#goodicon { width: 30px; vertical-align: middle; margin-right: 5px;}
.ctt_font { font-size: 18px; line-height: 1.5; }
#lastup { font-size: 13px; }
hr { margin: 15px 0;}
#schname, #placename { font-size: 20px; font-weight: bold; }
#schdetail { font-size: 15px; }
#dayselect { width: 100px; height: 30px; }
#map { border: 1px solid #888; }
#contentbox { width: 100%; margin-bottom: 20px;  }
#update, #delete { float: left; margin-right: 5px; }
#list { float: right; top: -500px;  }


#section2 { 
	width: 600px; margin: auto; border: 1px solid black; 
	padding: 20px 20px 20px 20px; background-color: #fff;
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
}
</script>
<script>
var clickCnt = 0;

	function postDel() {
		confirm("게시물을 삭제하시겠습니까?")
	}
	function swapImg(img) {
		var big = document.getElementById("placeimg1");
		big.src = "file/img/" + img;
	}
	function bigImg() {
		var big = document.getElementById("placeimg1");
		big.src = "file/img/silla1.jpg";
	}
	function gcntUpdate(gpid, miid) {
		if ( clickCnt == 0 ) {
			$.ajax({
				type : "POST",
				url : "/traverSite/postView",
				data : {
					"gpid" : gpid, 
					"miid" : miid
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
</script>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<div class="container">
   <div class="container-default_box">
   		<div id="section1">
   		<form name="mbtiViewFrm" method="post">
			<p id="title"><%=goodPost.getGp_title() %></p><br>
			<% if ( isLogin ) { %>
			<button type="button" class="btn"><img src="file/img/" id="report" alt="신고"></button>
			<button type="button" class="btn"><img src="file/img/" id="interest" alt="관심등록"></button>
			<button type="button" class="btn" id="goodbtn" onclick="gcntUpdate('<%=goodPost.getGp_id() %>', '<%=loginInfo.getMi_id() %>');">
			<img src=<% if ( result > 0 ) { %>"file/img/good2.png" <% } else { %> "file/img/good1.png" <% } %>
			id="goodicon" alt="좋아요"><span id="goodcnt"><%=goodPost.getGp_gcnt() %></span></button>
			<% } %>
			<span class="ctt_font" id="writer"><%=goodPost.getMi_id() %>(<%=goodPost.getGp_mbti() %>)</span><br>
			<span class="ctt_font" id="lastup">마지막 수정 : <%=goodPost.getGp_last() %></span>
			<hr>
			<p id="schname">일정이름<% %></p><br>
			<span class="ctt_font" id="schdetail">상세일정<% %></span>
			<br>
   			<hr>
   			<select id="dayselect">
   				<option value="day1">1일차</option>
   				<option value="day1">여기두 나중에 수정</option>
   			</select><button type="button" class="btn" id="pin">지도 핀</button><br><br>
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
			<div id="contentbox">
   				<span class="ctt_font" id="content"><%=goodPost.getGp_content() %></span>
   			</div>
   			<hr>
   			<% if ( isLogin ) { %>
   			<a href="mbti_form_up.jsp"><button type="button" class="btn" id="update"><img src="../../file/img/" id="update" alt="수정"></button></a>
   			<button type="button" class="btn" id="delete" onclick="postDel();"><img src="../../file/img/" id="delete" alt="삭제"></button>
   			<% } %>
   			<a href="mbti_list.jsp"><button type="button" class="btn" id="list"><img src="../../file/img/" id="list" alt="목록"></button></a>
   		</form>
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
   </div>
</div>
<%@ include file="../../cni/footer.jsp" %>
</body>
</html>