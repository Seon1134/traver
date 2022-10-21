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
<!-- 재덕 css 수정 시작 -->

.container_test {display: flex;}
.container_test .container-default_box_test {width: 100%;}
.container_test .leftBox_test { width: 250px; height: 30vh; border-right: #666; text-align: center; margin: 60px 0 0 273px; position: fixed;}
.container_test .leftBox_test .mypage_test {font-size: 22px; font-weight: 600; padding-bottom: 45px; border-bottom: 1px solid gray;}
.container_test .leftBox_test .menu_test {font-size: 18px; font-weight: 500; padding: 15px; }
.container_test .leftBox_test .menu_test:hover {background: #10b492; color: white;}
.container_test .leftBox_test .menu_test a:hover {color: white;}
.container_test .leftBox_test .menu_first {}
.container_test .twoBigBoxes_test {width: calc(100% - 200px); background: #fff; padding: 60px; box-sizing: border-box; display: flex; justify-content: flex-end;}
.container_test .twoBigBoxes_test .skybluebox1_test {width: 420px; height: 700px; top: 150px; background-color: #deeef4; margin: 0px 80px 0 0px;}
.container_test .twoBigBoxes_test .skybluebox2_test {width: 420px; height: 700px; top: 150px; background-color: #deeef4; margin: 0px 100px 0 0px;}


<!-- 재덕 css 수정 끝 -->





.main_box { width: 100%; height: 800px; display: flex; align-items: center; justify-content: center; }

.leftBox {
	width: 200px;
    height: 800px;
    border: solid 1px lightgray;
    border-top: none;
    margin-right: 72px;
}
.mypage { 
	color:black; font-weight:bold; font-size:20px; 
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
.box2 { width:400px; height: 570px; overflow:auto; }
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
<div class="container_test">
   <div class="container-default_box_test">
   
  <!--  <div class="main_box"> -->
	   	<div class="leftBox_test">
	   		<ul class="mypage_test">
	   			<li><a href="/traverSite/mypageList"><h2>마이페이지</h2></a></li>
			</ul>
			<ul>
				<li class="menu_test menu_first"><a href="/traverSite/mypageList">내 작성 게시글 및 리뷰</a></li>
				<li class="menu_test"><a href="lmth/mypage/info_up_form.jsp">회원 정보 수정</a></li>
				<li class="menu_test"><a href="lmth/mypage/pw_check.jsp">비밀번호 변경</a></li>
				<li class="menu_test"><a href="lmth/mypage/member_del.jsp">회원 탈퇴</a></li>
			</ul>
	 	</div>
	 	<div class="twoBigBoxes_test">
	 	<div class="skybluebox1_test">
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
	   	<div class="skybluebox2_test">
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
	   
   	<!-- </div> main_box  -->
   	
   </div>
</div>
<!-- 컨테이너 종료 -->
<%@ include file="../../cni/footer.jsp" %>
</body>
</body>
</html>