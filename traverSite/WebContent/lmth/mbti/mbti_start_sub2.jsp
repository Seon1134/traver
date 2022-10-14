<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MBTI 등록</title>
<style>
.container-default_box {
	text-align: center;
}
#content { margin: 200px 0; }

.bold { 
	font-size: 23px; font-weight: bold; 
	display: inline; 
}
.mbti { color: #4EA2B9; font-size: 30px;}

#wel_img { 	
	width: 500px;	
	vertical-align: middle;
}
#welcomebox { width: 900px; margin-left: 105px; }
#welcome { 
	width: 290px;
	padding: 70px 0 0 30px; 
	float: right; position: relative; left: -12%; 
	text-align: left; 
	}
#wel_desc { font-size: 18px; line-height: 1.7;}

.btn {
	margin-top:20px;
	background: inherit ; border: none; box-shadow: none; border-radius: 0; 
	padding: 0; 
	overflow: visible; cursor: pointer;
}
.btn_img { height: 40px; }
</style>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<div id="header_area"></div>
<div class="container">
   <div class="container-default_box">
   <div id ="content">
	   <span class="bold mbti"><%=loginInfo.getMi_mbti() %></span><span class="bold">로 정상 등록 되었습니다.</span><br><br>
	   		<div id="welcomebox">
		       	<img src="../../file/img/mbti_welcome.png" id="wel_img">
		       	<div id="welcome">
			   		<span class="bold">환영합니다!</span><br><br>
			   		<span id="wel_desc">이제부터 MBTI 여행을 이용 할 수 있습니다!</span><br>
			   		<a href="/traverSite/MBTIMain"><button class="btn"><image class="btn_img" id="gobestbtn" src="../../file/img/gobestbtn.png" alt="MBTI여행으로 이동"></button></a>&nbsp;&nbsp;&nbsp;
			   	</div>
		   	</div>
	   </div>
   </div>
</div>
<%@ include file="../../cni/footer.jsp" %>
</body>
</html>