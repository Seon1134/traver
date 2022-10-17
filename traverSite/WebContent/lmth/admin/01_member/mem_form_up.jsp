<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("utf-8");
MemberInfo memberInfo = (MemberInfo)request.getAttribute("memberInfo");
if (memberInfo == null) {
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어오셨습니다.');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>트레버</title>
<link href="/traverSite/lmth/admin/file/css/reset.css" type="text/css" rel="stylesheet">
<link href="/traverSite/lmth/admin/file/css/style.css" type="text/css" rel="stylesheet">
<script src="/traverSite/lmth/admin/file/js/jquery-3.6.1.js"></script>
<script>

</script>
</head>
<body>
	<%@ include file="../cni/header.jsp"%>
	<div class="mem_02_contents">
		<div class="container">
			<div class="mem_02_h2">
				<h2>회원 등록</h2>
			</div>
			<form name="frm_member_up" action="/traverSite/adminMemberProcUp" method="post">
				<div class="mem_02_tab01" style="width: 100%; padding : 0 80px; margin-bottom: 60px; box-sizing: border-box;">
					<h3>기본정보</h3>
					<table>
						<tbody>
							<tr>
								<th scope="row">아이디</th>
								<td><input type="text" name="id" value="<%=memberInfo.getMi_id() %>"></td>
								<th scope="row">이름</th>
								<td><input type="text" name="name" value="<%=memberInfo.getMi_name() %>"></td>
							</tr>
							<tr>
								<th scope="row">닉네임</th>
								<td><input type="text" name="nickname" value="<%=memberInfo.getMi_nickname() %>"></td>
								<th scope="row">이메일</th>
								<td><input type="email" name="email" value="<%=memberInfo.getMi_mail() %>"></td>
							</tr>
							<tr>
								<th scope="row">비밀번호</th>
								<td><input type="password" name="pw" value="<%=memberInfo.getMi_pw() %>"></td>
								<th scope="row">생년월일</th>
								<td><input type="text" name="birth" value="<%=memberInfo.getMi_birth() %>"></td>
							</tr>
							<tr>
								<th scope="row">MBTI</th>
								<td colspan="3">
								<select class="sel_style" name="mbti">
										<option value="choose" selected="selected" hidden="hidden">선택하세요.</option>
										<option value="ISTJ" <% if (memberInfo.getMi_mbti().equals("ISTJ")) { %> selected="selected" <% } %>>ISTJ</option>
										<option value="ISFJ" <% if (memberInfo.getMi_mbti().equals("ISFJ")) { %> selected="selected" <% } %>>ISFJ</option>
										<option value="INFJ" <% if (memberInfo.getMi_mbti().equals("INFJ")) { %> selected="selected" <% } %>>INFJ</option>
										<option value="INTJ" <% if (memberInfo.getMi_mbti().equals("INTJ")) { %> selected="selected" <% } %>>INTJ</option>
										<option value="ISTP" <% if (memberInfo.getMi_mbti().equals("ISTP")) { %> selected="selected" <% } %>>ISTP</option>
										<option value="ISFP" <% if (memberInfo.getMi_mbti().equals("ISFP")) { %> selected="selected" <% } %>>ISFP</option>
										<option value="INFP" <% if (memberInfo.getMi_mbti().equals("INFP")) { %> selected="selected" <% } %>>INFP</option>
										<option value="INTP" <% if (memberInfo.getMi_mbti().equals("INTP")) { %> selected="selected" <% } %>>INTP</option>
										<option value="ESTP" <% if (memberInfo.getMi_mbti().equals("ESTP")) { %> selected="selected" <% } %>>ESTP</option>
										<option value="ESFP" <% if (memberInfo.getMi_mbti().equals("ESFP")) { %> selected="selected" <% } %>>ESFP</option>
										<option value="ENFP" <% if (memberInfo.getMi_mbti().equals("ENFP")) { %> selected="selected" <% } %>>ENFP</option>
										<option value="ENTP" <% if (memberInfo.getMi_mbti().equals("ENFP")) { %> selected="selected" <% } %>>ENTP</option>
										<option value="ESTJ" <% if (memberInfo.getMi_mbti().equals("ESTJ")) { %> selected="selected" <% } %>>ESTJ</option>
										<option value="ESFJ" <% if (memberInfo.getMi_mbti().equals("ESFJ")) { %> selected="selected" <% } %>>ESFJ</option>
										<option value="ENFJ" <% if (memberInfo.getMi_mbti().equals("ENFJ")) { %> selected="selected" <% } %>>ENFJ</option>
										<option value="ENTJ" <% if (memberInfo.getMi_mbti().equals("ENTJ")) { %> selected="selected" <% } %>>ENTJ</option>
								</select>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="mem_02_tab02" style="width: 100%; padding : 0 80px; margin-bottom: 60px; box-sizing: border-box;">
					<h3>선택 정보</h3>
					<table>
						<tbody>
							<tr>
								<th scope="row">메일 수신</th>
								<td>
									<input type="radio" id="email_yes" name="email_on" checked="checked"><label for="email_yes">예</label>&nbsp;&nbsp;&nbsp;
									<input type="radio" id="email_no" name="email_out"><label for="email_no">아니오</label>
								</td>
								<th scope="row">회원 권한</th>
								<td>
									<select class="sel_style" name="status">
										<option value="구분" selected="selected" hidden="hidden">구분</option>
										<option value="a" <% if (memberInfo.getMi_status().equals("a")) { %> selected="selected" <% } %>>정회원</option>
										<option value="b" <% if (memberInfo.getMi_status().equals("b")) { %> selected="selected" <% } %>>정지 회원</option>
										<option value="c" <% if (memberInfo.getMi_status().equals("c")) { %> selected="selected" <% } %>>탈퇴 회원</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row">회원가입일</th>
								<td colspan="3"><input type="text" value="<%=memberInfo.getMi_join() %>"></td>
							</tr> 
						</tbody>
					</table>
				</div>
				<div class="confirm">
					<input type="button" value="취소" class="mem_02_btn1" onclick="location.href='/traverSite/adminMemberList';">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="submit" value="확인" class="mem_02_btn2" style="cursor: pointer;">
				</div>
			</form>
		</div>
	</div>
</body>
</html>