<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MBTI 첫 화면</title>
<style>
#visual {
	height: 360px;
	background-image: url('file/img/mbti_bg.png');
}
#p_vis_desc {
	width: 1200px; height: 400px;
	margin: 0 auto;
	position: relative;
}
#vis_desc {
	height: 200px; width: 400px;
    top: 20%; left: 10%;
    position: absolute;
}
#startbtn1 {
	width: 130px;
}
#main_title {
	font-size: 35px; font-weight: bold; color: #074442;
}
#vis_sub_desc {
	line-height: 1.7;
	font-size: 18px;
}
#char_visual {
	height: 79%; width: 100%;
	top: 150%;
	display: inline;
	margin-left: 150px;
}
#desc {
	padding: 50px;
	text-align: center;
}
.sub_desc {
	width: 33%;
	float: left;
}
.sub_img {
	height: 250px;
}
.sub_title {
	font-size: 20px; font-weight: bold; 
	margin: 10px;
}
.sub_desc p {
	width: 250px;
	margin: auto;
	line-height: 1.7;
}
.btn {
	background: inherit ; border: none; box-shadow: none; border-radius: 0; 
	padding: 0; overflow: visible; cursor: pointer;
}
#startbtn2 {
	margin-top: 40px;
	width: 150px;
}

</style>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<div id="visual">
	<div id="p_vis_desc">
		<div id="vis_desc">
			<h1 id="main_title">MBTI 여행</h1>
			<br><br>
			<span id="vis_sub_desc">
			자신의 MBTI에 맞는 여행 일정 추천<br>
			회원 간의 일정 공유 및 소통<br><br>
			</span>
			<a href="lmth/mbti/mbti_start_sub.jsp"><button class="btn"><image class="startbtn_img" id="startbtn1" src="file/img/startbtn1.png" alt="시작하기"></button></a>
		</div>
		<img id="char_visual" src="file/img/mbti_char.png">	
	</div>
</div>
<div class="container">
   <div class="container-default_box">
       	<div id="desc">
      		<div class="sub_desc">
      			<img src="file/img/sub_img1.png" class="sub_img">
	      		<h2 class="sub_title">나의 MBTI에 맞는 일정 추천</h2>
	      		<p>나와 비슷한 사람들이 좋아하는 일정을 찾아 실패 없는 여행을 즐기세요!</p>
      		</div>
   			<div class="sub_desc">
   				<img src="file/img/sub_img2.png" class="sub_img">
   				<h2 class="sub_title">다양한 일정표 활용</h2>
   				<p>다른 회원들의 일정을 내 일정으로<br>등록하여 다양한 여행을 즐겨보세요!</p>
   			</div>  
   			<div class="sub_desc">
   				<img src="file/img/sub_img3.png" class="sub_img">
   				<h2 class="sub_title">지도를 통한 경로 확인</h2>
   				<p>지도를 통해 장소를 확인하여 나에게 딱 맞는 효율적인 일정을 찾아보세요!</p>
   			</div>  
   			<a href="lmth/mbti/mbti_start_sub.jsp"><button class="btn"><image class="startbtn_img" id="startbtn2" src="file/img/startbtn2.png" alt="시작하기"></button></a>
   		</div>
   </div>
</div>
<%@ include file="../../cni/footer.jsp" %>
</body>
</html>