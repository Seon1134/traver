<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String[] arrDomain = {"naver.com", "nate.com", "gmail.com", "daum.net", "yahoo.com"};
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
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

.infoFormBox {
	width:600px; padding: 0px 0px 30px 0px;
    border:solid 1px #39f;
    margin-right:150px;
}
.infoChange { 
    font-size:20px; font-weight:bold;
    text-align:center;
}
.btnChk { height:36px; }
#nickNameMsg { margin: 10px 0px; }
.nnBox { margin-top:5px; margin-left:50px;}
.nnBox2 { margin-top:0; margin-left:105px; }
.mbtiBox { margin-top:7px; margin-left:50px; }
.mailBox { margin-top:11px; margin-left:50px; }
.mailChkBox { margin-top:13px; margin-left:108px; }
.twoBtns { margin-top:16px; margin-left:230px; }

#btnCancel { height:40px; width:60px; }
#btnInfoChange { height:40px; width:60px; }

.fontBlue { font-weight:bold; color:blue; }
.fontRed { font-weight:bold; color:red; }
</style>
<script src="/traverSite/file/jq/jquery-3.6.1.js"></script>
<script>
function chkDup(kind, input) { // id,닉네임 중복체크
	var regEngNum = /^[A-Za-z0-9+]*$/; 
	if ( kind == 'n') {
		if (input.length <= 20) {  
	        $.ajax({
	            type : "POST",             
	            url : "/traverSite/dup",     
	            data : {"nickname" : input},      
	            success : function(chkRs) { 
	                var msg = "";         
	                if (chkRs == 0) {       
	                    msg = "<p class='fontBlue'>사용 가능한 닉네임 입니다.</p>";
	                    $("#nicknameChk").val("y");   
	                } else {                
	                    msg = "<p class='fontRed'>이미 사용중인 닉네임입니다.</p>";
	                    $("#nicknameChk").val("n");   
	                }
	                $("#nickNameMsg").html(msg);
	            }
	        });
	    } else { 
	    	$("#nickNameMsg").text("※ 20자 이내로 입력해주세요.");
		    $("#nicknameChk").val("n");   
	    }
	}
}

function submitalert() {
	alert("성공적으로 수정되었습니다.");
	document.frmInfoChange.submit()
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
				<li><a href="lmth/mypage/info_up_form.jsp" class="menu">&nbsp;&nbsp;| 회원 정보 수정</a></li><br/>
				<li><a href="pw_check.jsp" class="menu">&nbsp;&nbsp;| 비밀번호 변경</a></li><br/>
				<li><a href="member_del.jsp" class="menu">&nbsp;&nbsp;| 회원 탈퇴</a></li><br/>
			</ul>
		</div>
	  		<div class="infoFormBox"><br/><br/>
			<h2 class="infoChange">회원 정보 수정</h2><br/><br/>
			<form name="frmInfoChange" action="member_proc.mem" method="post">
			<input type="hidden" name="kind" value="up" />
				<div class="nnBox">
					<label for="mi_nickname" style="font-weight:bold;">닉네임</label>&nbsp;&nbsp;
					<input type="text" name="mi_nickname" id="mi_nickname" maxlength="20" 
					size="20" style="height:30px;" onkeyup="chkDup('n',this.value);" value="<%=loginInfo.getMi_nickname() %>" /><br />
				</div>
				<div class="nnBox2">
					<p id="nickNameMsg" class="box2">※ 20자 이내로 입력해주세요.</p>
				</div>
				<% if ( loginInfo.getMi_mbti() != null && !loginInfo.getMi_mbti().equals("0000") && !loginInfo.getMi_mbti().equals("") ) { %>
				<div class="mbtiBox">
					<label for="mi_mbti" style="font-weight:bold;">MBIT</label>&nbsp;&nbsp;&nbsp;&nbsp;
					<select name="mi_mbti" id="mi_mbti" style="height:36px; width:100px;">
						<option <% if (loginInfo.getMi_mbti().equals("ISTJ")) {%>selected<% } %>>ISTJ</option>
						<option <% if (loginInfo.getMi_mbti().equals("ISFJ")) {%>selected<% } %>>ISFJ</option>
						<option <% if (loginInfo.getMi_mbti().equals("INFJ")) {%>selected<% } %>>INFJ</option>
						<option <% if (loginInfo.getMi_mbti().equals("INTJ")) {%>selected<% } %>>INTJ</option>
						<option <% if (loginInfo.getMi_mbti().equals("ISTP")) {%>selected<% } %>>ISTP</option>
						<option <% if (loginInfo.getMi_mbti().equals("ISFP")) {%>selected<% } %>>ISFP</option>
						<option <% if (loginInfo.getMi_mbti().equals("INFP")) {%>selected<% } %>>INFP</option>
						<option <% if (loginInfo.getMi_mbti().equals("INTP")) {%>selected<% } %>>INTP</option>
						<option <% if (loginInfo.getMi_mbti().equals("ESTP")) {%>selected<% } %>>ESTP</option>
						<option <% if (loginInfo.getMi_mbti().equals("ESFP")) {%>selected<% } %>>ESFP</option>
						<option <% if (loginInfo.getMi_mbti().equals("ENFP")) {%>selected<% } %>>ENFP</option>
						<option <% if (loginInfo.getMi_mbti().equals("ENTP")) {%>selected<% } %>>ENTP</option>
						<option <% if (loginInfo.getMi_mbti().equals("ESTJ")) {%>selected<% } %>>ESTJ</option>
						<option <% if (loginInfo.getMi_mbti().equals("ESFJ")) {%>selected<% } %>>ESFJ</option>
						<option <% if (loginInfo.getMi_mbti().equals("ENFJ")) {%>selected<% } %>>ENFJ</option>
						<option <% if (loginInfo.getMi_mbti().equals("ENTJ")) {%>selected<% } %>>ENTJ</option>
					</select><br/><br/>
				</div>
				<% } %>
				<div class="mailBox">
				<% 	String mail = loginInfo.getMi_mail();
					String[] mailArr = mail.split("@");
					String e1 = mailArr[0];
					String e3 = mailArr[1];					%>
					<label for="mi_mail" style="font-weight:bold;">이메일</label>&nbsp;&nbsp;
					<input type="text" name="e1" size="10" style="height:30px;" value="<%=e1 %>"/> @
					<select name="e2" id="e2" style="height:36px;">
						<option value=""> 도메인 선택 </option>
						<%for (int i =0; i < arrDomain.length; i++ ) { %>   
		        		<option value="<%=arrDomain[i] %>" <% if (arrDomain[i].equals(e3)) {%> selected <% } %>><%=arrDomain[i] %></option>  
						<% } %>
		       			 <option value="direct">직접 입력</option>
					</select>
					<input type="text" name="e3" id="e3" size="10" style="height:30px;" value="<%=e3 %>"/>
					<button onclick="emailAuthentication()" id="eamilAuthBtn" type="button" class="btnChk">이메일 확인</button>
					<br />
				</div>
				<div class="mailChkBox">	
					<input type="text" name="verifyNum" style="height:30px;" placeholder="이메일 본인 확인 번호" maxlength="6"/>
					<span class="blind">5:00</span>
					<input type="submit" value="확인" style="height:35px; width:60px;"/>
				</div><br/>
				<div class="twoBtns">
				    <input type="button" id="btnCancel" value="취소" onclick="history.back(-1);"/>&nbsp;
				    <input type="button" id="btnInfoChange" value="수정" onclick="submitalert();"/>
			    </div>
			</form>
	  		</div>
   		</div><!-- main_box -->
   		
   </div>
</div>
<!-- 컨테이너 종료 -->
<%@ include file="../../cni/footer.jsp" %>
</body>
</html>
