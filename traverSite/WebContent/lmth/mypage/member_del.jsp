<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
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

.pw1 { font-size:20px; font-weight:bold; text-align:center; }

.pwChkBox {
	width:600px; height:300px;
    border:solid 1px #39f;
    margin-right:150px;
}
.pw1 { font-size:20px; font-weight:bold; text-align:center; }
.pw2 { text-align:center; font-size:16px; }
.pw3 { margin-top:40px; margin-left:120px; }
.pw4 { margin-top:10px; margin-left:240px; }
.pw5 { margin-top:30px; margin-left:260px; }
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
		<div class="pwChkBox"><br/><br/>
			<h2 class="pw1">회원 탈퇴</h2><br/><br/>
			<form name="frmPwChange" action="#" method="post">
				<div class="pw2"><span>※개인정보 보호를 위해 비밀번호를 재확인합니다.</span></div>
				<div class="pw3">
					<label for="mi_pw" style="font-weight:bold;">비밀번호 재확인</label>&nbsp;&nbsp;
					<input type="password" name="mi_pw" id="mi_pw" maxlength="20" placeholder="비밀번호를 입력해 주세요."
					size="20" style="height:30px;" onkeyup="chkDupPw(this.value);" /><br />
				</div>
				<div class="pw4">
					<span id="idMsg">비밀번호를 확인해 주세요.</span><br /><br />
				</div>
				<div class="pw5">	
					<input type="submit" value="확인" style="height:35px; width:80px;" onclick="chkPw(this.value);"/>
				</div><br/> <!-- 비밀번호 확인 성공 후 확인버튼 누르면 탈퇴재확인 폼으로 이동 -->
			</form>
		</div>
	</div><!-- main_box -->
   
   </div>
</div>
<!-- 컨테이너 종료 -->
<%@ include file="../../cni/footer.jsp" %>   
</body>
</html>