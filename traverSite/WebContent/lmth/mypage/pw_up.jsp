<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<style>

<!-- 재덕 css 수정 시작 -->

.container_test {display: flex;}
.container_test .container-default_box_test {width: 100%; height: 800px;}
.container_test .leftBox_test { width: 250px; height: 30vh; border-right: #666; text-align: center; margin: 60px 0 0 273px; position: fixed;}
.container_test .leftBox_test .mypage_test {font-size: 22px; font-weight: 600; padding-bottom: 45px; border-bottom: 1px solid gray;}
.container_test .leftBox_test .menu_test {font-size: 18px; font-weight: 500; padding: 15px; }
.container_test .leftBox_test .menu_test:hover {background: #10b492; color: white;}
.container_test .leftBox_test .menu_test a:hover {color: white;}
.container_test .leftBox_test .menu_first {}
.container_test .changePwBox_test {width: calc(100% - 575px); background: #fff; padding: 60px; box-sizing: border-box; display: flex; justify-content: flex-end;}
.container_test .changePwBox_test .pw_up_test {margin-top: 60px; border: 1px solid gray; border-radius: 5px; padding: 85px; text-align: center;}



<!-- 재덕 css 수정 끝 -->


.main_box {
	width: 100%;
	height: 800px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.leftBox {
	width: 200px;
	height: 800px;
	border: solid 1px lightgray;
	border-top: none;
	margin-right: 200px;
}

.mypage {
	color:black; font-weight:bold; font-size:20px; margin-left: 33px;
}

.menu {
	color: gray;
	font-weight: bold;
	font-size:18px; line-height: 1.5;
}

a:hover {
	color: black;
}

.changePwBox {
	width: 500px;
	height: 360px;
	border: solid 1px #39f;
	margin-right: 150px;
}

.msg {
	margin: 5px 0;
}

.pw1 {
	font-size: 20px;
	font-weight: bold;
	text-align: center;
	margin: 0 0 30px 0;
}

#newPwd1 {
	height: 30px;
}

#newPwd2 {
	height: 30px;
}

#pwChangeBtn {
	height: 35px;
	width: 60px;
}

.fontBlue { font-weight:bold; color:blue; }
.fontRed { font-weight:bold; color:red; }
</style>
<script src="/traverSite/file/jq/jquery-3.6.1.js"></script>
<script>
function chkPw(newpw, oldpw) {
	var regEngNum = /^[A-Za-z0-9]*$/;
	var msg = ""; 
	if (regEngNum.test(newpw)) { 
		if (newpw.length >= 6) {
			if ( newpw == oldpw ) {
				msg = "<p class='fontRed'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;현재 비밀번호와 동일합니다.</p>";
				$("#pwChk").val("n");   
			} else {
				msg = "<p class='fontBlue'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;사용 가능한 비밀번호입니다.</p>";
				$("#pwChk").val("y");
			}
		} else {
			msg = "<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;※ 6 ~ 20자 이내로 영문과 숫자를 조합해주세요.</p>";
			$("#pwChk").val("n");   
		}
	} else {
		msg = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;※ 6 ~ 20자 이내로 영문과 숫자를 조합해주세요.";
		$("#pwChk").val("n");   
	}
	$("#pwMsg").html(msg);
}
function chkEqualPw (pw, chkPw) {
	   var msg = ""; 
	   if ( pw == chkPw) {
	      msg = "<p class='fontBlue'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;비밀번호가 동일합니다.</p>"
	      $("#pwChk2").val("y"); 
	   } else {
	      msg = "<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;비밀번호가 동일하지 않습니다.</p>"
	      $("#pwChk2").val("n"); 
	   }
	   $("#pwMsg2").html(msg);
	}
	
$(document).ready(function() { // 이메일 도메인 선택 시 우측 input에 자동 입력
    $("#newPwd1, #newPwd2").keyup(function() {
    	if ($("#pwChk").val() == "y" && $("#pwChk2").val() == "y" )	 
    		$("#pwChangeBtn").removeAttr("disabled")
    	else 							
			$("#pwChangeBtn").attr("disabled","disabled")
    	
    });
});
function submitalert() {
	alert("성공적으로 수정되었습니다.");
	document.changePwForm.submit()
}
</script>
</head>
<body>
<%@ include file="../../cni/header.jsp"%>
<%
if (!isLogin) {
		out.println("<script> alert('잘못된 경로로 들어오셨습니다.'); history.back(); </script>");
		out.close();
	}
%>
<!-- 컨테이너 시작 -->
<div class="container_test">
	<div class="container-default_box_test">

		<!-- <div class="main_box"> -->
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
			<div class="changePwBox_test" align="center">
				<form name="changePwForm" action="member_proc.mem" method="post" class="pw_up_test">
				<h2 class="pw1">비밀번호 변경</h2>
				<input type="hidden" name="kind" value="pwUp" /> 
				<input type="hidden" name="pwChk" id="pwChk" value="n" /> 
       			<input type="hidden" name="pwChk2" id="pwChk2" value="n" /> 
					<table>
						<tr>
							<td align="center"><input type="password" name="mi_pw"
								id="newPwd1" maxlength="20" placeholder="새 비밀번호를 입력해주세요."
								size="30" required="required" onkeyup="chkPw(this.value, '<%=loginInfo.getMi_pw() %>');"/><br /></td>
						</tr>
						<tr>
							<td align="left"><br><p id="pwMsg" class="msg">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;※ 6 ~ 20자 이내로 영문과 숫자를 조합해주세요.</p></td>
						</tr>
						<tr>
							<td align="center"><br> <input type="password"
								name="newPwd2" id="newPwd2" maxlength="20"
								placeholder="새 비밀번호를 다시 입력해주세요." size="30" required="required" onkeyup="chkEqualPw(this.form.newPwd1.value, this.value);" /><br /></td>
						</tr>
						<tr>
							<td align="left"><br><p id="pwMsg2" class="msg"></p></br></td>
						</tr>
						<br>
						<tr>
							<td align="center"><input type="button" value="확인"
								style="height: 35px; width: 80px;" id="pwChangeBtn" onclick="submitalert();" /></td>
						</tr>
						<!-- 비밀번호 변경 완료 후 로그인 창으로 이동 -->
					</table>
				</form>
			</div>
		<!-- </div> -->
		<!-- main_box -->
	</div>
</div>
<!-- 컨테이너 종료 -->
<%@ include file="../../cni/footer.jsp"%>
</body>
</html>