<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<style>
.main_box { width: 100%; height: 800px; display: flex; align-items: center; justify-content: center; }
.findForm {
    width:600px; height:300px;
    border:solid 1px #39f;
}
.findId { margin-left:160px; font-size:20px; font-weight:bold; color:lightgray;}
.findPw { font-size:20px; font-weight:bold; }
</style>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<!-- 컨테이너 시작 -->
<div class="container">
   <div class="container-default_box">
   
   <div class="main_box">  
	   <div class="findForm">
	        <br/><br/><br/><br/>
	        <a href="find_form_id.jsp" id="idinquiry" onclick="goPage('idInquiry','idinquiry');">
	            <span class="findId">아이디 찾기</span> <span style="font-size:20px;">|</span> 
	        </a>
	        <a href="find_form_pw.jsp" id="pwinquiry" onclick="goPage('pwinquiry','pwinquiry');">
	            <span class="findPw" >비밀번호 찾기</span>
	        </a>
	        <br/><br/><br/><br/>
	        <form name="frmFindPw" action="pwUpdate" method="post">
	        <input type="hidden" name="kind" value="lo" />
	            <table width="100%" align="center" >
	                <tr>
	                    <td align="right" style="font-weight:bold;" >아이디</td>
	                    <td align="center">
	                        <input type="text" name="mi_id" maxlength="20" required="required" size="20" style="height:30px;" placeholder="아이디"/>
	                    </td>
	                    <td></td>
	                </tr>
	                <tr>
	                    <td align="right" style="font-weight:bold;">이메일</td>
	                    <td align="center">
	                        <input type="email" name="mi_mail" maxlength="50" required="required" size="20" style="height:30px;" placeholder="이메일 주소"/>
	                    </td>
	                    <td>
	                        <input type="button" class="verifyBtn" value="인증" style="height:35px; width:60px;"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td></td>
	                    <td align="center">
	                        <input type="text" id="verifyNum" style="height:30px;" placeholder="본인 확인 번호(6자리)" maxlength="6"/>
	                    </td>
	                    <td><span class="blind">5:00</span></td>
	                </tr>
	                <tr>
	                    <td align="center" colspan="3">
	                        <input type="submit" value="확인" style="height:35px; width:60px;"/>
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