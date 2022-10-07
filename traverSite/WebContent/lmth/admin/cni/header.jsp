<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page import="vo.*" %>
<%
AdminInfo adminInfo = (AdminInfo)session.getAttribute("adminInfo");
boolean isLogin = false;
if (adminInfo != null) {
	isLogin = true;
}
%>

<link rel="shortcut icon" href="#">
<header>
	<div class="container">
		<div class="nav1">
			<div class="logo">
				<h1>
					<a href="/traverSite/lmth/admin/admin_main.jsp" title="traver 홈페이지로 이동"> <img
						src="/traverSite/lmth/admin/file/img/logo.png" title="로고">
					</a>
				</h1>
			</div>
			<nav>
				<ul class="nav0">
					<li><a href="/traverSite/lmth/admin/01_member/mem_01.jsp">회원 관리</a></li>
					<li><a href="/traverSite/adminPlaceList">장소 관리</a></li>
					<li><a href="/traverSite/lmth/admin/03_report/report_01.jsp">신고 관리</a></li>
					<li><a href="/traverSite/lmth/admin/04_bbs/bbs_01.jsp">게시물 관리</a></li>
					<li><a href="/traverSite/lmth/admin/05_schedule/sch_01.jsp">일정 관리</a></li>
				</ul>
			</nav>
		</div>
		<div class="nav2">
			<ul>
			<% if (isLogin) { %>
				<li><a href="/traverSite/lmth/admin/logout.jsp">로그아웃</a></li>
			<% } else { %>
				<li><a href="/traverSite/lmth/admin/login.jsp">로그인</a></li>
			<% } %>
			</ul>
		</div>
	</div>
</header>


