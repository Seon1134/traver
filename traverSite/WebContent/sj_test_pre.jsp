<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
// ArrayList를 만들어서 세션에 넣는 파일 (로그아웃과 동일)
// 여기를 거쳐서 맵을 열을 ctrl(placeList)로 보낼 예정!
ArrayList<PlaceInfo> asdf = new ArrayList<PlaceInfo>(); // 어레이리스트 생성
session.setAttribute("scheduleDayList", asdf); //어레이리스트 세션에 담기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>/* location.replace('sj_test.jsp'); */</script>
</body>
</html>
