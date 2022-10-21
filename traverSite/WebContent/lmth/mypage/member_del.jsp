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
	color:black; font-weight:bold; font-size:20px; margin-left: 33px;
}
.menu { color: gray; 
	font-weight:bold; font-size:18px; line-height: 1.5;
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

.fontBlue { font-weight: bold; color:blue; }
.fontRed { font-weight: bold; color:red; }
</style>
<script src="/traverSite/file/jq/jquery-3.6.1.js"></script>
<script>
function chkPw(id, pw) { // 
	$.ajax({
	    type : "POST",             
	    url : "/traverSite/dup",   
	    data : {"id" : id, "pw" : pw },       
	    success : function(chkRs) {
	        var msg = "";          
	        if (chkRs == 1) {      
	            msg = "<span class='fontBlue'>비밀번호가 일치합니다.</span>";
	            $("#submitbtn").removeAttr("disabled")  
	        } else {                
	            msg = "<span class='fontRed'>비밀번호를 확인해 주세요.</span>";
	            $("#submitbtn").attr("disabled","disabled")   
	        }
	        $("#pwMsg").html(msg);
	    }
	});
}
</script>
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
		<div class="pwChkBox"><br/><br/>
			<h2 class="pw1">회원 탈퇴</h2><br/><br/>
			<form name="frmPwChange" action="member_del_check.jsp" method="post">
			<input type="hidden" name="kind" value="my" />
			<input type="hidden" name="pwChk" id="pwChk" value="n" />
				<div class="pw2"><span>※개인정보 보호를 위해 비밀번호를 재확인합니다.</span></div>
				<div class="pw3">
					<label for="mi_pw" style="font-weight:bold;">비밀번호 재확인</label>&nbsp;&nbsp;
					<input type="password" name="mi_pw" id="mi_pw" maxlength="20" placeholder="비밀번호를 입력해 주세요."
					size="20" style="height:30px;" onkeyup="chkPw('<%=loginInfo.getMi_id() %>', this.value);" /><br />
				</div>
				<div class="pw4">
					<p id="pwMsg">비밀번호를 확인해 주세요.</p>
				</div>
				<div class="pw5">	
					<input id="submitbtn" type="submit" value="확인" style="height:35px; width:80px;" disabled />
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