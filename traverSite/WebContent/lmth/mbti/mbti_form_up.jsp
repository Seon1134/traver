<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String title = (String)request.getAttribute("title");
String nickname = (String)request.getAttribute("nickname");
String mbti = (String)request.getAttribute("mbti");
String giname = (String)request.getAttribute("giname");
String list = (String)request.getAttribute("list");
String content = (String)request.getAttribute("content");
String gpid = (String)request.getAttribute("gpid");
String giid = (String)request.getAttribute("giid");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추천 글 수정</title>
<style>
.container-default_box { position: relative; }
#section1 { width:1000px; margin: 50px auto; position: relative; }
.btn {
	background: inherit ; border: none; box-shadow: none; border-radius: 0; 
	padding: 0; overflow: visible; cursor: pointer;
	float: right; margin-right: 10px;
}
.sub_font { font-size: 19px; font-weight: bold; }
input[type="text"] {
	hegith: 30px; font-size: 16px; margin-left:10px;
	border: none; border-bottom: 1px solid #888;
}
hr { margin: 15px 0;}
#red { float: right; color: red; font-size: 12px; }
#map { border: 1px solid #888; }
textarea { border: 1px solid #888; width: 100%;}
#dayselect, #schselect { width: 100px; height: 30px; } 
#content { padding: 5px; lint-height: 1.5; }
#ctcnt { float: right; }
#upbtn { margin: 16px 450px 40px 0; right: }
#upimg { height: 40px; margin-top: -2px;}
</style>
<script src="../../file/js/jquery-3.6.1.js"></script>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<div class="container">
	   <div class="container-default_box">
	   		<div id="section1">
	   		<form action="/traverSite/postProcUp" method="post">
	   		<input type="hidden" name="gpid" value="<%=gpid %>">
	   		<input type="hidden" name="giid" value="<%=giid %>">
				<label for="title" class="sub_font"> 제목 </label><input type="text" name="title" value="<%=title %>" size="50" autofocus>
				<hr>
				<label for="sch_name" class="sub_font"> 일정 </label><input type="text" value="<%=giname %>" size="20" readonly>
				<span id="red"> * 일정은 수정할 수 없습니다</span>
				<br><br>
	   			<%=list %>
	   			<hr>
	   			<label for="content" class="sub_font">일정 소개</label><br><br>
	   			<textarea id="content" name="content" cols="117" rows="5"><%=content %></textarea>
	   			<span id="ctcnt"><span id="count">0</span> / 1000</span>
	   			<br><br>
	   			<a href="mbti_view.jsp"><button type="submit" class="btn" id="upbtn"><image id="upimg" src="file/img/updatebtn.png" alt="수정하기"></button></a>
	   		</form>
	   		</div>
	   </div>
</div>
<%@ include file="../../cni/footer.jsp" %>
</body>
</html>