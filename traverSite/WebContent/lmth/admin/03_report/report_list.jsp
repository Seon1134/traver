<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/traverSite/lmth/admin/file/css/reset.css" type="text/css" rel="stylesheet">
<link href="/traverSite/lmth/admin/file/css/style.css" type="text/css" rel="stylesheet">
</head>
<body>
	<%@ include file="../cni/header.jsp"%>

	<div class="report_contents">
		<div class="container">
			<div class="contents">
				<h2>신고 관리</h2>
				<div class="subR">
					<!-- 찾기 영역 -->
					<form>
						<select name="reportSel">
							<option value="게시물 링크">게시물 링크</option>
							<option value="신고자 아이디">신고자 아이디</option>
							<option value="신고대상 아이디">신고대상 아이디</option>
							<option value="신고 사유">신고 사유</option>
							<option value="신고자아이피">신고자아이피</option>
							<option value="신고 날짜">신고 날짜</option>
							<option value="상태">상태</option>
						</select> <input type="text" name="" placeholder="검색란"> <input
							type="button" value="찾기">
					</form>
					<ul>
						<li><input type="button" value="신고 취소" id="reportCan"
							onclick="confirm('신고를 취소하시겠습니까?')"></li>
						<li><input type="button" value="신고 처리" id="reportPro"
							onclick="confirm('신고를 처리하시겠습니까?')"></li>
					</ul>
				</div>
			</div>
			<div class="report_table">
				<table>
					<thead>
						<tr>
							<th scope="col"><input type="checkbox"></th>
							<th scope="col">게 시 글 링 크</th>
							<th scope="col">분 류</th>
							<th scope="col">신 고 자 아 이 디</th>
							<th scope="col">신 고 대 상 아 이 디</th>
							<th scope="col">신 고 사 유</th>
							<th scope="col">신 고 자 아 이 피</th>
							<th scope="col">신 고 날 짜</th>
							<th scope="col">상 태</th>
						</tr>
					</thead>
					<tbody>
						<tr align="center">
							<td><input type="checkbox"></td>
							<td><a href="http://naver.com" target="_blank">http://naver.com</a></td>
							<td>게시글</td>
							<td>admin</td>
							<td>test1</td>
							<td>도배성 게시물</td>
							<td>112.128.485.214</td>
							<td>2022-09-01</td>
							<td>처리완료</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>