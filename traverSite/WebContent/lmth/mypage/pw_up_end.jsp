<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경 완료</title>
<style>
.main_box { width: 100%; height: 800px; display: flex; align-items: center; justify-content: center; }

.leftBox {
	width:200px; height:800px;
    border:solid 1px lightgray; border-top:none;
    margin-right:200px;
}
.mypage { 
	color:black; font-weight:bold; font-size:18px;
}
.menu { color: gray; 
	font-weight:bold; font-size:16px;
}
a:hover{ color:black; }

.changePwBox {
   width:600px; height:300px; 
    border:solid 1px #39f; text-align:center;
    margin-right:150px;
}
.pw1 { font-size:20px; font-weight:bold; }

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
				<li><a href="info_form.jsp" class="menu">&nbsp;&nbsp;|회원 정보 수정</a></li><br/>
				<li><a href="pw_check.jsp" class="menu">&nbsp;&nbsp;|비밀번호 변경</a></li><br/>
				<li><a href="member_del.jsp" class="menu">&nbsp;&nbsp;|회원 탈퇴</a></li><br/>
			</ul>
		</div> 
		<div class="changePwBox">
			<br /><br /><br /><br /><br /><br />
			<span class="pw1" >회원님의 비밀번호 변경이 <span style="color:#3f6;">완료</span>되었습니다.</span><br /><br /><br /><br />
			<span class="pw1">감사합니다.</span>
		</div>
	</div><!-- main_box -->
   
   </div>
</div>
<!-- 컨테이너 종료 -->
<%@ include file="../../cni/footer.jsp" %>   
</body>
</html>