<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../cni/header.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ScheduleInfo si = (ScheduleInfo)request.getAttribute("si");
ArrayList<ScheduleDay> schdDayList = si.getSchdDayList();
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
<%
for (int i = 0; i < schdDayList.size() ; i++) {
	ScheduleDay sd = schdDayList.get(i);
	String tmp = sd.getSd_dnum() + "일차"; 
%>
			<option value="<%=sd.getSd_id() %>"><%=tmp %></option>
<% 
} 
%>
		</select>
</body>
</html>