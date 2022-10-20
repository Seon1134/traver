<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴 완료</title>
<style>
.main_box { width: 100%; height: 800px; display: flex; align-items: center; justify-content: center; }

.leftBox {
	width:200px; height:800px;
    border:solid 1px lightgray; border-top:none;
    margin-right:200px;
}
.mypage { 
	color:black; font-weight:bold; font-size:20px; margin-left: 33px;
}
.menu { color: gray; 
	font-weight:bold; font-size:18px; line-height: 1.5;
}
a:hover{ color:black; }
.cancelComplete {
	width:600px; height:300px;
    border:solid 1px #39f;
    margin-right:150px;
}

.chk1{ 
	margin-top:60px; text-align:center; 
	color:#3f6; font-size:25px; 
	font-weight:bold;
}
.chk2 { 
	margin-top:20px; text-align:center; 
	font-size:18px; font-weight:bold;
	color:gray;
}
.chk3 { 
	margin-top:10px; text-align:center; 
	font-size:18px; font-weight:bold;
	color:gray;
}
.chk4 { 
	margin-top:10px; text-align:center; 
	font-size:18px; font-weight:bold;
	color:gray;
}
.homeBtn { margin-left:260px; }
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
				<li><a href="info_up_form.jsp" class="menu">&nbsp;&nbsp;| 회원 정보 수정</a></li><br/>
				<li><a href="pw_check.jsp" class="menu">&nbsp;&nbsp;| 비밀번호 변경</a></li><br/>
				<li><a href="member_del.jsp" class="menu">&nbsp;&nbsp;| 회원 탈퇴</a></li><br/>
			</ul>
		</div>
		<div class="cancelComplete">
				<h2 class="chk1">회원 탈퇴 완료</h2>
				<p class="chk2">고객님과 함께여서</p>
				<p class="chk3">즐거운 <span style="color:#3f6;">트레버</span> 였습니다.</p>
				<p class="chk4">감사합니다.</p><br/><br/>
				<a href="../_main/index.jsp" class="homeBtn">	
					<input type="button" value="홈으로" style="height:35px; width:80px;"/>
					<!-- 탈퇴 완료 후 메인페이지로 이동 -->
				</a><br/>
		</div>
	</div><!-- main_box -->

   </div>
</div>
<!-- 컨테이너 종료 -->
<%@ include file="../../cni/footer.jsp" %>      
</body>
</html>