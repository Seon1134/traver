<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../cni/header.jsp" %>
<%

request.setCharacterEncoding("utf-8");
ScheduleInfo si = (ScheduleInfo)request.getAttribute("si");
ArrayList<ScheduleDay> schdDayList = si.getSchdDayList();
out.println("test");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   		<select name="dayselect" id="">
   			<option value="">일차 선택</option>


		</select>
</body>
</html>