<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재확인</title>
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
.container_test .pwChkBox_test { width: calc(100% - 575px); background: #fff; padding: 60px; box-sizing: border-box; display: flex; justify-content: flex-end;}
.container_test .pwChkBox_test .pwChkBox_test {width: 420px; height: 700px; top: 150px; background-color: #deeef4; margin: 0px 80px 0 0px;}
.container_test .pwChkBox_test .pw_con_frm_test {margin-top: 60px; border: 1px solid gray; border-radius: 5px; padding: 85px; text-align: center;}


<!-- 재덕 css 수정 끝 -->

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

.pwChkBox {
	width:600px; height:300px;
    border:solid 1px #39f;
    margin-right:150px;
}
.pw1 { font-size:20px; font-weight:bold; text-align:center;  margin: 0 0 30px;}
.pw2 { text-align:center; font-size:16px; }
.pw3 { margin-top:40px;}
.pw4 { margin-top:10px;}
.pw5 { margin-top:30px;}

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
	            $("#pwsubmit").removeAttr("disabled")
	        } else {                
	            msg = "<span class='fontRed'>비밀번호를 확인해 주세요.</span>"; 
	            $("#pwsubmit").attr("disabled","disabled")
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
		<div class="pwChkBox_test">
			<form name="frmPwCheck" action="pw_up.jsp" method="post" class="pw_con_frm_test">
			<h2 class="pw1">비밀번호 변경</h2>
				<div class="pw2"><span>※개인정보 보호를 위해 비밀번호를 재확인합니다.</span></div>
				<div class="pw3">
					<label for="mi_pw" style="font-weight:bold;">비밀번호 재확인</label>&nbsp;&nbsp;
					<input type="password" name="mi_pw" id="mi_pw" maxlength="20" placeholder="비밀번호를 입력해 주세요."
					size="20" style="height:30px;" onkeyup="chkPw('<%=loginInfo.getMi_id() %>', this.value);" />
				</div>
				<div class="pw4">
					<span id="pwMsg">비밀번호를 확인해 주세요.</span><br />
				</div>
				<div class="pw5">	
					<input id="pwsubmit" type="submit" value="확인" style="height:35px; width:80px;" disabled/>
				</div><br/> <!-- 비밀번호 확인 성공 후 확인버튼 누르면 변경폼 으로 이동 -->
			</form>
		</div>
	<!-- </div>main_box -->
   
   </div>
</div>
<!-- 컨테이너 종료 -->
<%@ include file="../../cni/footer.jsp" %>   
</body>
</html>