<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String siid = request.getParameter("siid");
System.out.println(siid);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	window.addEventListener('load', function(){
		sessionStorage.removeItem("selectDate");
		sessionStorage.removeItem("selectDay");
	})
	location.replace('/traverSite/mschdDetail?siid=<%=siid %>');
</script>
</head>
<body>
</body>
</html>