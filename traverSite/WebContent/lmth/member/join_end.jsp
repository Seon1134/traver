<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 완료</title>
<style>
.join_complete { 
    width:600px; height:500px; 
    margin:auto; margin-top:150px; margin-bottom:150px; 
    border:solid 1px #39f; 
}
.c1 { 
    text-align:center; color:#3f6;
    font-size:25px; font-weight:bold;
    margin-top:150px;
}
.font_setting { 
	font-size:18px; font-weight:bold; 
	text-align:center; line-height:20px;
}
.font_setting2 { 
	text-align:center; 
	font-size:18px; line-height:20px; 
}
.font_bold { 
	font-weight:bold; color:#3f6; 
}
#goTravel { 
	height:50px; width:80px; 
	margin-left:210px; margin-top:50px; 
	border:#3f6; 
}
#goMbti { 
	height:50px; width:80px; 
	margin-top:50px; border:#3f6;
}
</style>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<!-- 컨테이너 시작 -->
<div class="container">
   <div class="container-default_box">
   
   <div class="join_complete"> 
	   <h2 class="c1">회원가입 완료!!</h2>
	   <br/><br/><br />
	   <p class="font_setting">트레버의 회원이 되신걸 축하합니다!</p>
	   <p class="font_setting">앞으로 트레버의 다양한 여행정보를 실시간으로 확인하세요!</p>
	   <br/><br/><br />
	   <p class="font_setting2"><bold class="font_bold" >트레버</bold>와 함께 
	   <bold class="font_bold">여행</bold>을 떠나 볼까요?</p>
        
       <input type="button" id="goTravel" value="여행 떠나기" onclick="location='/traverSite/placeList'"/>
       &nbsp;&nbsp;&nbsp;
       <input type="button" id="goMbti" value="MBTI 여행" onclick="location='/traverSite/MBTIMain'"/>
   </div>
   
   </div>
</div>
<!-- 컨테이너 종료 -->
<%@ include file="../../cni/footer.jsp" %>
</body>
</html>