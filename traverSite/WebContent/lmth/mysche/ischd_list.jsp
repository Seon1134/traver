<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관심 일정 목록</title>
<style>
.container-default_box { padding: 0px 40px 0px 40px; }
#title { color: #000; }
select { height: 29px; vertical-align: middle; cursor: pointer; }
#search-box {
	display: inline-block;
    width: 190px;
    height: 26px;
    border: 1px solid #767676;
    position: flex;
    align-items: center;
}
input[type="text"] { height:23px; border: none; }

.schNbtn { display: flex;  }
.btn {
	margin-bottom:60px;
	background: inherit; border: none; 
	box-shadow: none; border-radius: 0; 
	padding: 0;  cursor: pointer;
}
#schBtn { 
	width:70px; height:35px; 
	margin-left: 5px; 
	border: none; 
}

#subtitle { font-size: 25px; font-weight: bold; margin: 0px 70px 50px 10px;}
#schbox { float: right }



.post { float: left; margin: 10px 20px 10px 20px;}
.post_title { 
	width: 180px; height: 52px; 
	display: inline-block; padding: 10px;
	background-color: #C5E0B4;
	font-size: 20px; font-weight: bold; line-height: 1.5;
}
.small { font-size: 14px; }
.postimg { width: 200px; height: 200px; }
</style>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<ScheduleInfo> scheduleList = (ArrayList<ScheduleInfo>)request.getAttribute("scheduleList");
// 일정 목록이 들어있는 ArrayList<ScheduleInfo>를 형변환하여 받아옴

String sy = request.getParameter("sy");
String o = request.getParameter("o");
String keyword = request.getParameter("keyword");

String args = "", yargs = "", oargs = "", schargs = "";
if (sy != null && !sy.equals("")) 				yargs += "&sy=" + sy;
if (o != null && !o.equals("")) 				oargs += "&o=" + o;
else 	o = "";
if (keyword != null && !keyword.equals("")) 	schargs += "&keyword=" + keyword; 
else 	keyword = "";

args = "&yargs=" + oargs + schargs; // 일정 디테일 보기용 쿼리

%>
<div class="container">
   <div class="container-default_box">
   		<br><br><br><br>
   		<a href="ischd_list.jsp" id="title"><span id="subtitle">관심 일정</span></a><br><br><br><br>
   		<select class="year">
				<option value="">전체보기</option>
<%
String today = LocalDate.now() + "";
int maxYear = Integer.parseInt(today.substring(0, 4));
for (int i = 2020 ; i <= maxYear + 1 ; i++) {
	
%>	   		
				<option value="<%=i %>" ><%=i %> 년</option>
<%		
}
%>
		 </select>
		 <select name="o" onchange="location.href='/traverSite/ischdDetail?<%=schargs + yargs%>&o=' + this.value;">
				<option value="a" <% if (o.equals("a")) { %>selected="selected"<% } %>>등록 최신 순</option>
				<option value="b" <% if (o.equals("b")) { %>selected="selected"<% } %>>등록 오래된 순</option>
		 </select>
		 
		 <span> 총 일정 수 :    </span>
		 <div id="schNbtn">
			<div id= "search-box" >
			 	<input type="text" name="keyword" value="<%=keyword %>" placeholder="일정제목으로 검색하세요." >
			</div>
			<button class="btn" onclick="btnClick()">
				<img src="/traverSite/file/img/sch.png" id="schBtn"/>
			</button>
		 </div>
		 
		 <div id="list">
			<div class="post">
	   			<div class="post_title">
	   				여행 일정 제목1<br>#박 #일 <span class="small">(##.##~##.##)</span>
	   			</div>
	   			<div class="post_img">
	   				<img src="#" class="postimg">
	   			</div>
	   		</div>
	   		<div class="post">
	   			<div class="post_title">
	   				여행 일정 제목2<br>#박 #일 <span class="small">(##.##~##.##)</span>
	   			</div>
	   			<div class="post_img">
	   				<img src="#" class="postimg">
	   			</div>
	   		</div>
	   		<div class="post">
	   			<div class="post_title">
	   				여행 일정 제목3<br>#박 #일 <span class="small">(##.##~##.##)</span>
	   			</div>
	   			<div class="post_img">
	   				<img src="#" class="postimg">
	   			</div>
	   		</div>
	   		<div class="post">
	   			<div class="post_title">
	   				여행 일정 제목4<br>#박 #일 <span class="small">(##.##~##.##)</span>
	   			</div>
	   			<div class="post_img">
	   				<img src="#" class="postimg">
	   			</div>
	   		</div>
	   		<div class="post">
	   			<div class="post_title">
	   				여행 일정 제목5<br>#박 #일 <span class="small">(##.##~##.##)</span>
	   			</div>
	   			<div class="post_img">
	   				<img src="#" class="postimg">
	   			</div>
	   		</div>
	   		<div class="post">
	   			<div class="post_title">
	   				여행 일정 제목6<br>#박 #일 <span class="small">(##.##~##.##)</span>
	   			</div>
	   			<div class="post_img">
	   				<img src="#" class="postimg">
	   			</div>
	   		</div>
	   		<div class="post">
	   			<div class="post_title">
	   				여행 일정 제목7<br>#박 #일 <span class="small">(##.##~##.##)</span>
	   			</div>
	   			<div class="post_img">
	   				<img src="#" class="postimg">
	   			</div>
	   		</div>
	   		<div class="post">
	   			<div class="post_title">
	   				여행 일정 제목8<br>#박 #일 <span class="small">(##.##~##.##)</span>
	   			</div>
	   			<div class="post_img">
	   				<img src="#" class="postimg">
	   			</div>
	   		</div>
	   		<div class="post">
	   			<div class="post_title">
	   				여행 일정 제목9<br>#박 #일 <span class="small">(##.##~##.##)</span>
	   			</div>
	   			<div class="post_img">
	   				<img src="#" class="postimg">
	   			</div>
	   		</div>
	   		<div class="post">
	   			<div class="post_title">
	   				여행 일정 제목10<br>#박 #일 <span class="small">(##.##~##.##)</span>
	   			</div>
	   			<div class="post_img">
	   				<img src="#" class="postimg">
	   			</div>
	   		</div>
	   		<div class="post">
	   			<div class="post_title">
	   				여행 일정 제목11<br>#박 #일 <span class="small">(##.##~##.##)</span>
	   			</div>
	   			<div class="post_img">
	   				<img src="#" class="postimg">
	   			</div>
	   		</div>
	   		<div class="post">
	   			<div class="post_title">
	   				여행 일정 제목12<br>#박 #일 <span class="small">(##.##~##.##)</span>
	   			</div>
	   			<div class="post_img">
	   				<img src="#" class="postimg">
	   			</div>
	   		</div>
		</div>	
   </div>
</div>
<%@ include file="../../cni/footer.jsp" %>
</body>
</html>