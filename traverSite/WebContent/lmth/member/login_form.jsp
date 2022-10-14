<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<% 
request.setCharacterEncoding("utf-8");
String url = request.getParameter("url");
if (url == null)    url = "/traverSite/index.jsp";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>

.main_box { width: 100%; height: 800px; display: flex; align-items: center; justify-content: center; }
.idBox { 
	border:1px solid black; width:240px; 
}
.pwBox { 
	border:1px solid black; width:240px; 
}
#box1 {margin-right: 100px;	}
#box2 {}

.img1 { width:400px; height:400px; }
.img2 { width:90px; height:60px; } 
#memberjoin {width: 160px; height: 15px; border: 1px solid #e9faf6; background-color: #e9faf6; text-align: center; font-weight: bold; margin: 0 0 50px 50px; }
#uid, #pwd { 
	border:none; margin-bottom:10px;
}
#idmargin{ 
	margin-bottom:8px; 
}
#mi_id { 
	width:100px; height:30px; margin-left:70px;
}
</style>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<%
if (isLogin) {
	out.println("<script> alert('잘못된 경로로 들어오셨습니다.'); history.back(); </script>");
	out.close();
}
%>
<!-- 컨테이너 시작 -->
<div class="container">
   <div class="container-default_box">
   
   		<div class="main_box">
	  		<div id="box1" name="box">
	  			<img src="../../file/img/login.png" alt="서브 이미지" class="img1" />
  			</div>
			<div id="box2">
				<div id=memberjoin>
	   				<a href="join_agreement.jsp" style="color:gray;">트레버 회원 가입</a>
				</div>
				<div>
					<img src="../../file/img/logo.png" alt="Traver LogIn이미지" class="img2"/>
				</div><br/>
				
				<form name="frmLogin" action="/traverSite/login" method="post">
					<input type="hidden" name="url" value="<%=url %>" />
					<div class="idBox" id="idmargin">
						<label for="uid"><img src="../../file/img/id_logo.png" /></label>
						<input type="text" name="uid" id="uid" value="test11" maxlength="20" required="required" /><br />
					</div>
					<div class="pwBox">
						<label for="pwd"><img src="../../file/img/pw_logo.png" /></label>
						<input type="password" name="pwd" id="pwd" value="111111" maxlength="20" required="required"/><br />
					</div><br/>
					<a href="find_form_id.jsp">아이디 </a>/ <a href="find_form_pw.jsp">비밀번호</a>&nbsp;찾기<br/><br/>
					<input type="submit" value="로그인" id="mi_id" />				
					<br/><br/>
                </form>
                
			</div>
		</div>
   </div>
</div>
<!-- 컨테이너 종료 -->
<%@ include file="../../cni/footer.jsp" %>
</body>
</html>