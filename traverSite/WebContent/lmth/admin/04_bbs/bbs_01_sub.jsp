<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/traverSite/lmth/admin/file/css/reset.css" type="text/css" rel="stylesheet">
<link href="/traverSite/lmth/admin/file/css/style.css" type="text/css" rel="stylesheet">
<script src="/traverSite/lmth/admin/file/js/jquery-3.6.1.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2b05cef42f58551f118588eb3f26ff67&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div ID 넣기
    mapOption = { 
        center: new kakao.maps.LatLng(33.3080, 126.60000), // 지도의 중심좌표 : 제주도로 설정해놨어
        level: 3 // 지도의 확대 레벨 : 줄이거나 늘리면댐
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성
var map = new kakao.maps.Map(mapContainer, mapOption); 
</script>
<script>
window.onload = function(){
	const getoldbtn = document.querySelector('#getoldbtn');
	const x = document.querySelector('#x');
	
	getoldbtn.addEventListener('click', function() {
		section2.classList.remove('display_none');
	});
	x.addEventListener('click', function() {
		section2.classList.add('display_none');
	});
}
</script>
<script>
$(document).ready(function() {
	$("#content").keyup(function() {
		var cmt = $(this).val();
		if ( cmt.length > 1000 ) {
			alert("1000자를 초과하였습니다.");
			cmt = cmt.substring(0,1000);
			$(this).val(cmt);
		}
		$("#count").text(cmt.length);
	});
});
</script>
</head>
<body>
<%@ include file="../cni/header.jsp"%>

<div class="content">
		<div class="inner">
			<div class="sub_nav">
				<h2>게시물관리</h2>
				<ul>
					<li><a href="/traverSite/admimBbsContentsList">전체 게시글</a></li>
					<li><a href="/traverSite/lmth/admin/04_bbs/bbs_02.jsp">전체 리뷰</a></li>
				</ul>
			</div>
			<div class="bbs_sub_01_content_area">
				<div class="main">
					<div class="container">
						<div class="bss_sub_01_contents">
							<h2>게시글 수정</h2>
							<div class="bbs_sch_Btn">
								<button class="btn" id="getOldBtn">
									<image src="../../file/img/" alt="기존 일정 가져오기"></button>
   								<button class="btn" id="getNewBtn">
   									<image src="../../file/img/" alt="새 일정 만들기"></button>
							</div>
						</div>
						<div class="bbs_01_sub_table">
							<form action="" name="post_frm" method="post">
							<label for="title" class="bbs_sub_title">제목</label>
							<input type="text"><hr>
							<label for="sch_name" class="bbs_sub_title">일정</label>
							<input type="text" readonly="readonly">
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>