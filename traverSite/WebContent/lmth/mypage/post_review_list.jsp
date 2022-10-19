<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 작성 글/리뷰</title>
<style>
.main_box { width: 100%; height: 800px; display: flex; align-items: center; justify-content: center; }

.leftBox {
	width:200px; height:800px;
    border:solid 1px lightgray; border-top:none;
    margin-right:0;
}
.mypage { 
	color:black; font-weight:bold; font-size:18px;
} 
.menu { color: gray; 
	font-weight:bold; font-size:16px;
}
a:hover{ color:black; }

.skybluebox1 { 
	width:350px; height:700px;
    top:150px; background-color:#deeef4;
    margin-right:150px; 
}
.skybluebox2 {
	width:350px; height:700px;
    top:150px; background-color:#deeef4;
    margin-right:150px; 
}
.box1 { color:black; font-weight:bold; font-size:20px; }
.box2 { width:350px; height:500px; overflow:auto;}
.tl { font-size:16px; color:gray; }
</style>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<!-- 컨테이너 시작 -->
<div class="container">
   <div class="container-default_box">
   
   <div class="main_box">
	   	<div class="leftBox">
			<br/><br/><br/>
			<h2 class="mypage">&nbsp;&nbsp;마이페이지</h2><br/><br/>
			<hr/>
			<ul><br/><br/>
				<li><a href="post_review_list.jsp" class="menu">&nbsp;&nbsp;|내 작성 글/리뷰</a></li><br/>
				<li><a href="info_up_form.jsp" class="menu">&nbsp;&nbsp;|회원 정보 수정</a></li><br/>
				<li><a href="pw_check.jsp" class="menu">&nbsp;&nbsp;|비밀번호 변경</a></li><br/>
				<li><a href="member_del.jsp" class="menu">&nbsp;&nbsp;|회원 탈퇴</a></li><br/>
			</ul>
	 	</div>
	 	<div class="skybluebox1">
	 		<div>
	 			<br/><br/>
	 			<p class="box1">&nbsp;&nbsp;작성글</p><br/><br/><hr/>
	 			<br/>
	 			<div class="box2">
	  			<a href="#" class="tl">&nbsp;&nbsp;글제목...</a><br/><br/><br/>
	  			<a href="#" class="tl">&nbsp;&nbsp;글제목...</a><br/><br/><br/>
	  			<a href="#" class="tl">&nbsp;&nbsp;글제목...</a><br/><br/><br/>
	 			</div>
			</div>
	 	</div>
	   <div class="skybluebox2">
	   		<div>
	   			<br/><br/>
	   			<p class="box1">&nbsp;&nbsp;작성 리뷰</p><br/><br/><hr/>
	   			<br/>
	   			<div class="box2">
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
		   			<a href="#" class="tl">&nbsp;&nbsp;리뷰제목...</a><br/><br/><br/>
	   			</div>
			</div>
	   </div>
   	</div> <!-- main_box  -->
   	
   </div>
</div>
<!-- 컨테이너 종료 -->
<%@ include file="../../cni/footer.jsp" %>
</body>
</body>
</html>