<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
ArrayList<GoodPost> goodPostList = (ArrayList<GoodPost>)request.getAttribute("goodPostList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 작성 글/리뷰</title>
<style>
.main_box { width: 100%; height: 800px; display: flex; align-items: center; justify-content: center; }

.leftBox {
	width: 200px;
    height: 800px;
    border: solid 1px lightgray;
    border-top: none;
    margin-right: 72px;
}
.mypage { 
	color:black; font-weight:bold; font-size:20px; margin-left: 33px;
} 
.menu { color: gray; 
	font-weight:bold; font-size:18px; line-height: 1.5;
}
a:hover{ color:black; }

.twoBigBoxes { display:flex; margin-right:50px; }
.skybluebox1 { 
	width:350px; height:700px;
    top:150px; background-color:#deeef4;
    margin-left:50px; 
}
.skybluebox2 {
	width:350px; height:700px;
    top:150px; background-color:#deeef4;
    margin-left:80px; 
}
.box1 { color:black; font-weight:bold; font-size:20px; }
.box2 { width:350px; height: 570px; overflow:auto; }
.tl { font-size:16px; color:gray; }
</style>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<%
if (!isLogin) {
		out.println("<script> alert('잘못된 경로로 들어오셨습니다.'); history.back(); </script>");
		out.close();
	}
%>
<!-- 컨테이너 시작 -->
<div class="container">
   <div class="container-default_box">
   
   <div class="main_box">
	   	<div class="leftBox">
			<br/><br/><br/>
			<a href="/traverSite/mypageList"><h2 class="mypage">&nbsp;&nbsp;마이페이지</h2></a><br/><br/>
			<hr/>
			<ul><br/><br/>
				<li><a href="/traverSite/mypageList" class="menu">&nbsp;&nbsp;| 내 작성 글/리뷰</a></li><br/>
				<li><a href="lmth/mypage/info_up_form.jsp" class="menu">&nbsp;&nbsp;| 회원 정보 수정</a></li><br/>
				<li><a href="lmth/mypage/pw_check.jsp" class="menu">&nbsp;&nbsp;| 비밀번호 변경</a></li><br/>
				<li><a href="lmth/mypage/member_del.jsp" class="menu">&nbsp;&nbsp;| 회원 탈퇴</a></li><br/>
			</ul>
	 	</div>
	 	<div class="twoBigBoxes">
	 	<div class="skybluebox1">
	 		<div>
	 			<br/><br/>
	 			<p class="box1">&nbsp;&nbsp;작성글</p><br/><br/><hr/>
	 			<br/>
	 			<div class="box2">
	 			<% for (int i = 0; i < goodPostList.size(); i++) { 
	 				GoodPost gp = goodPostList.get(i); 					%>
	  				<a href="postView?gpid=<%=gp.getGp_id() %>&giid=<%=gp.getGi_id() %>&miid=<%=gp.getMi_id() %>"
	  				 class="tl">&nbsp;&nbsp;<%=gp.getGp_title() %></a><br/><br/><br/>
	  			<% } %>
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
	   </div>
	   
   	</div> <!-- main_box  -->
   	
   </div>
</div>
<!-- 컨테이너 종료 -->
<%@ include file="../../cni/footer.jsp" %>
</body>
</body>
</html>