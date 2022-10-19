<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 확인</title>
<style>
.main_box { width: 100%; height: 800px; display: flex; align-items: center; justify-content: center; }
.findIdBox {
    width:600px; height:300px;
    border:solid 1px #39f;
    text-align:center;
}
.findId { 
    font-size:20px; font-weight:bold;
}
.btn_login {
    border: solid 1px #000;
    background-position: 0 -140px;
    background-color:#ececec;
}
.btn_findpw {
    border: solid 1px #000;
    background-color:#ececec;
}
a:link { color:black; text-decoration:none;} 
a:visited { color:black; text-decoration:none;}

.btn_design { color:black}
</style>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<!-- 컨테이너 시작 -->
<div class="container">
   <div class="container-default_box">
   
   <div class="main_box"> 
		<div class="findIdBox">
	        <br/><br/><br/><br/>
	        <span class="findId">아이디 찾기</span>
	        <br/><br/><br/><br/><br/>
	        <span>회원님의 아이디는 test*입니다.</span>
	        <br/><br/><br/><br/><br/>
	        <a href="login_form.jsp" class="btn_login"><span class="btn_design">로그인하기</span></a>
	        <a href="find_form_pw.jsp" class="btn_findpw"><span class="btn_design">비밀번호 찾기</span></a>
	    </div>
    </div><!-- main_box -->
   
    </div>
</div>
<!-- 컨테이너 종료 -->
<%@ include file="../../cni/footer.jsp" %>  
</body>
</html>