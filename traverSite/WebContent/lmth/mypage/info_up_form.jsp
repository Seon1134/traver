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
	color:black; font-weight:bold; font-size:18px; 
}
.menu { color: gray; 
	font-weight:bold; font-size:16px;
}
a:hover{ color:black; }

.infoFormBox {
	width:600px; height:400px;
    border:solid 1px #39f;
    margin-right:150px;
}
.infoChange { 
    font-size:20px; font-weight:bold;
    text-align:center;
}
.btnChk { height:36px; }
.nnBox { margin-top:5px; margin-left:50px;}
.nnBox2 { margin-top:0; margin-left:105px; }
.mbtiBox { margin-top:7px; margin-left:50px; }
.mailBox { margin-top:11px; margin-left:50px; }
.mailChkBox { margin-top:13px; margin-left:108px; }
.twoBtns { margin-top:16px; margin-left:230px; }

#btnCancel { height:40px; width:60px; }
#btnInfoChange { height:40px; width:60px; }
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
	  		<div class="infoFormBox"><br/><br/>
			<h2 class="infoChange">회원 정보 수정</h2><br/><br/>
			<form name="frmInfoChange" action="#" method="post">
				<div class="nnBox">
					<label for="mi_nickname" style="font-weight:bold;">닉네임</label>&nbsp;&nbsp;
					<input type="text" name="mi_nickname" id="mi_nickname" maxlength="20" placeholder="닉네임을 입력해 주세요."
					size="20" style="height:30px;" onkeyup="chkDupNN(this.value);" /><br />
				</div>
				<div class="nnBox2">
					<span id="idMsg">※ 20자 이내로 입력해주세요.</span><br /><br />
				</div>
				<div class="mbtiBox">
					<label for="mi_mbti" style="font-weight:bold;">MBIT</label>&nbsp;&nbsp;&nbsp;&nbsp;
					<select name="mi_mbti" id="mi_mbti" style="height:36px; width:100px;">
						<option value="">ISTJ</option>
						<option value="">ISFJ</option>
						<option value="">INFJ</option>
						<option value="">INTJ</option>
						<option value="">ISTP</option>
						<option value="">ISFP</option>
						<option value="">INFP</option>
						<option value="">INTP</option>
						<option value="">ESTP</option>
						<option value="">ESFP</option>
						<option value="">ENFP</option>
						<option value="">ENTP</option>
						<option value="">ESTJ</option>
						<option value="">ESFJ</option>
						<option value="">ENFJ</option>
						<option value="">ENTJ</option>
					</select><br/><br/>
				</div>
				<div class="mailBox">
					<label for="mi_mail" style="font-weight:bold;">이메일</label>&nbsp;&nbsp;
					<input type="text" name="e1" size="10" style="height:30px;" placeholder="이메일"/> @
					<select name="e2" id="e2" style="height:36px;">
						<option value=""> 도메인 선택 </option>
						<%for (int i =0; i < arrDomain.length; i++ ) { %>   
		        		<option value="<%=arrDomain[i] %>"><%=arrDomain[i] %></option>  
						<% } %>
		       			 <option value="direct">직접 입력</option>
					</select>
					<input type="text" name="e3" id="e3" size="10" style="height:30px;"/>
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
				    <input type="submit" id="btnInfoChange" value="수정"/>
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
