<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page import="vo.*" %>
<%
MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo"); 
boolean isLogin = false;
if (loginInfo != null)  isLogin = true; 
%>
<link rel="stylesheet" href="/traverSite/file/css/reset.css" type="text/css">
<link rel="stylesheet" href="/traverSite/file/css/main.css" type="text/css">
<!--  헤더 시작 -->
<div class="header">
	<div class="header_area">
		<a href="/traverSite/index.jsp" title="traver 홈페이지로 이동" class="logo_box">
			<img src="/traverSite/file/img/logo.png" id="logo" />
		</a>
		<nav class="header-gnb">
			<ul class="main_menu">
				<li>
					<a href="/traverSite/placeList" class="gnb_link_menu">여행 떠나기</a>
				</li>
				<li>
					<a href="" class="gnb_link_menu">MBTI 여행</a>
					<ul class="gnb_link_sub">
						<li><a href="/traverSite/MBTIMain">Best 여행</a></li>
						<li><a href="/traverSite/postList">여행 전체보기</a></li>
					</ul>
				</li>
				<li>
					<%  if (isLogin) { %> <!-- 로그인 상태이면 --> 
					<a href="" class="gnb_link_menu">내 일정/장소</a>
						<ul class="gnb_link_sub" style="width: 170px;">
							<li><a href="/traverSite/mschdList">내 일정</a></li>
							<li><a href="/traverSite/ischdList">관심 일정</a></li>
						</ul>
					<% } else { %> <!-- 로그인 상태가 아니면 -->
					<a href="#" class="gnb_link_menu" style="visibility:hidden;">내 일정/장소</a>
					<% } %> 
				</li>
			</ul>
		</nav>
		<div class="header-service_area">
			<% if (isLogin) { %>
			<a href="/traverSite/mypageList" class="service-mypage">마이페이지</a>
			<a href="/traverSite/lmth/member/logout.jsp" class="service-logout">로그아웃</a>
			<% } else { %>
			<a href="#" class="service-mypage" style="visibility:hidden;">마이페이지</a>
			<a href="/traverSite/lmth/member/login_form.jsp">로그인</a>
			<% } %>
		</div>
	</div>
</div>
<!-- // 헤더 종료 -->