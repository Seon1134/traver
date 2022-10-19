<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
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
    border:solid 1px #39f;
    margin-right:150px;
}
.pw1 { font-size:20px; font-weight:bold; text-align:center; }

#newPwd1 { height:30px; }
#newPwd2 { height:30px; }
#pwChangeBtn { height:35px; width:60px; margin-left:260px; }

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
	     <br/><br/><br/><br/>
	     <h2 class="pw1">비밀번호 변경</h2>
	     <br/><br/>
	     <form name="changePwForm" action="pwUpdate" method="post">
	      <table width="90%">
	       <tr>
	           <th align="right" style="font-weight:bold;">&nbsp;&nbsp;&nbsp;비밀번호</th>
	        <td align="center">
	            <input type="password" name="newPwd1" id="newPwd1" maxlength="20" placeholder="새 비빌번호를 입력해주세요." size="30" required="required"/><br />
	        </td>
	       </tr>
	           <td></td>
	           <td align="center">
	                  <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                                                  ※ 6 ~ 20자 이내로 영문과 숫자 조합해주세요.</p><br/>
	              </td>                  
	       <tr>
	           <td></td>
	        <td align="center">
	            <input type="password" name="newPwd2" id="newPwd2" maxlength="20" placeholder="새 비밀번호를 다시 입력해주세요." size="30" required="required"/><br />
	        </td>
	       </tr>
	       <tr>
	          <td></td>
	          <td align="left">
	              <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                              비밀번호가 동일합니다.</p></br></br>
	          </td>
	       </tr>
	       <tr>
	          <td colspan="2">
	              <input type="submit" value="확인" style="height:35px; width:80px;" id="pwChangeBtn"/>
	          </td> <!-- 비밀번호 변경 완료 후 로그인 창으로 이동 -->
	       </tr>
	      </table>
	     </form>
		</div>
	</div><!-- main_box -->
   
   </div>
</div>
<!-- 컨테이너 종료 -->
<%@ include file="../../cni/footer.jsp" %>   
</body>
</html>