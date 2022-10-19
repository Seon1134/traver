<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<style>
.main_box { width: 100%; height: 800px; display: flex; align-items: center; justify-content: center; }
.changePwBox {
    width:600px; height:300px;
    border:solid 1px #39f;
    text-align:center;
}
.changePw { 
    font-size:20px; font-weight:bold;
}
#newPwd1 { height:30px; }
#newPwd2 { height:30px; }
#pwChangeBtn { height:35px; width:60px; }

</style>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<!-- 컨테이너 시작 -->
<div class="container">
   <div class="container-default_box">
   
   <div class="main_box"> 
	    <div class="changePwBox">
	        <br/><br/><br/><br/>
	        <span class="changePw">비밀번호 변경</span>
	        <br/><br/><br/>
	        <form name="changePwForm" action="#" method="post">
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
			               <input type="submit" value="확인" id="pwChangeBtn"/>
			           </td>
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