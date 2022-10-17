<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
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
			<form name="frm_member_in" action="/traverSite/adminMemberProcIn" method="post">
				<div class="mem_02_tab01" style="width: 100%; padding : 0 80px; margin-bottom: 60px; box-sizing: border-box;">
					<h3>기본정보</h3>
					<table>
						<tbody>
							<tr>
								<th scope="row">아이디</th>
								<td><input type="text" name="fm_id"></td>
								<th scope="row">이름</th>
								<td><input type="text" name="fm_name"></td>
							</tr>
							<tr>
								<th scope="row">닉네임</th>
								<td><input type="text" name="fm_nickname"></td>
								<th scope="row">이메일</th>
								<td><input type="email" name="fm_email"></td>
							</tr>
							<tr>
								<th scope="row">비밀번호</th>
								<td><input type="password" name="fm_pw"></td>
								<th scope="row">생년월일</th>
								<td><input type="text" name="fm_birth"></td>
							</tr>
							<tr>
								<th scope="row">MBTI</th>
								<td colspan="3">
								<select class="sel_style" name="fm_mbti">
										<option value="choose" selected="selected" hidden="hidden">선택하세요.</option>
										<option value="ISTJ">ISTJ</option>
										<option value="ISFJ">ISFJ</option>
										<option value="INFJ">INFJ</option>
										<option value="INTJ">INTJ</option>
										<option value="ISTP">ISTP</option>
										<option value="ISFP">ISFP</option>
										<option value="INFP">INFP</option>
										<option value="INTP">INTP</option>
										<option value="ESTP">ESTP</option>
										<option value="ESFP">ESFP</option>
										<option value="ENFP">ENFP</option>
										<option value="ENTP">ENTP</option>
										<option value="ESTJ">ESTJ</option>
										<option value="ESFJ">ESFJ</option>
										<option value="ENFJ">ENFJ</option>
										<option value="ENTJ">ENTJ</option>
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
									<select class="sel_style" name="fm_status">
										<option value="구분" selected="selected" hidden="hidden">구분</option>
										<option value="a">정회원</option>
										<option value="b">정지 회원</option>
										<option value="c">탈퇴 회원</option>
									</select>
								</td>
							</tr>
							<!-- 
							<tr>
								<th scope="row">회원가입일</th>
								<td colspan="3"></td>
							</tr> 
							-->
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