<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 일정 목록</title>
<script>
function btnClick() {
	var frm = document.frmSch;
	var keyword = frm.keyword.value;
	if (keyword == "") {
		alert("검색어를 입력해 주세요.");
	}
 } 
</script>
<style>
.container-default_box { padding: 0px 40px 0px 40px; }

/* 재덕 수정 시작 */
.sch_h2 {margin: 40px 0;}
.contents_sch {height: 100px; width: 400px}
.contents_con {height: 600px;}
 
/* 재덕 수정 끝 */

#title { color: #000; }
select { height: 29px; vertical-align: middle; cursor: pointer; }
#search-box {
    border: 1px solid #767676;
    width:200px;
    height:30px;
    margin-left:800px;
    margin-bottom:50px;
}
input[type="text"] { height:23px; border: none; margin-left: 5px; }

.schNbtn { display: flex;  }
#schBtn { 
	width:70px; height:35px; 
	margin-left: 5px; 
	border: none; 
}
.btn {
	margin-bottom:60px;
	background: inherit; border: none; 
	box-shadow: none; border-radius: 0; 
	padding: 0;  cursor: pointer; 
}
.upBox { 
	background: #efefef; width:178px; height:50px; 
	border:solid 1px lightgray; color:black;
}
.mouseEventBox:hover { background: #efefef; width:178px; height:230px; }


#subtitle { font-size: 25px; font-weight: bold;}

#list { width: 100%; }
.post { float: left; margin: 10px 20px 10px 20px;}
.post_title { 
	width: 180px; height: 52px; 
	display: inline-block; padding: 10px;
	background-color: #BDD7EE;
	font-size: 20px; font-weight: bold; line-height: 1.5;
}
.small { font-size: 14px; }
.postimg { width: 200px; height: 200px; }
.display_none { display: none; }

.tableBox { width:100%; height:70%; overflow:auto; }
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
   
   	<div class="contents_con">
   		<div class="contents_sch">
	   		<div class="sch_h2">
	   			<a href="/traverSite/mschdList" id="title"><span id="subtitle">내 일정</span></a>
	   		</div>
	   		
		 	<form name="frmSch" method="get">
		 	<input type="hidden" name="o" value="<%=o%>"/>
		 	<input type="hidden" name="sy" value="<%=sy %>"/>

	   		<select name="sy" onchange="location.href='/traverSite/mschdList?<%=schargs + oargs%>&sy=' + this.value;">
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
			 <select name="o" onchange="location.href='/traverSite/mschdList?<%=schargs + yargs%>&o=' + this.value;">
				<option value="a" <% if (o.equals("a")) { %>selected="selected"<% } %>>등록 최신 순</option>
				<option value="b" <% if (o.equals("b")) { %>selected="selected"<% } %>>등록 오래된 순</option>
			 </select>
			 <span> 총 일정 수 : </span>
				 <!-- 추후 일정제목/장소명 셀렉트 박스는 삭제하고 검색박스만 남겨놓을 예정 -->
			 	<div class="schNbtn">
				 	<div id= "search-box" >
					 	<input type="text" name="keyword" value="<%=keyword %>" placeholder="일정제목으로 검색하세요." >
					</div>
					<button class="btn" onclick="btnClick()">
						<img src="/traverSite/file/img/sch.png" id="schBtn"/>
					</button>
				</div>
			 </form>	
			 	
		</div> <!-- contents_sch -->
		<br/><br/><br/><br/>
		
		<div class="tableBox">
		<table width="100%" callpadding="5" >
<%
	if (scheduleList.size() > 0) { 	// 일정 목록이 있으면
		int i = 0;
		for (i = 0 ; i < scheduleList.size() ; i++) {
			ScheduleInfo si = scheduleList.get(i);
			
			String title = si.getSi_name();
			if (title.length() > 12)	title = title.substring(0, 10) + " ...";
			
			String dnum1 = (si.getSi_dnum() - 1) + "박";
			String dnum2 = si.getSi_dnum() + "일";
			
			if (i % 5 == 0) 	out.println("<tr>");
%>

		<td width="20%" align="center" >
			<div class="mouseEventBox">
				<a href="mschdDetail?siid=<%=si.getSi_id() + args %>">
					<div class="upBox" >
						<span id="schdName"><%=title %></span><br />
						<span><%=dnum1%>&nbsp;<%=dnum2%></span><br />
						<span><%=si.getSi_sdate() %>~<%=si.getSi_edate() %></span><br />
					</div>	
					<img src="/traverSite/file/img/<%=si.getSi_img() %>" width="180" height="180"/>
				</a>	
			</div><br/>
		</td>
<%		
			if (i % 5 == 4) 	out.println("</tr>");
		}
		
		if (i % 5 > 0) {	// 일정이 5개 단위로 맞아 떨어지지 않았을 경우
			for (int j = 0; j < (5 - 1) ; j++) out.println("<td width='20%'></td>");
			out.println("</tr>");
		} // 빈 칸으로 5개를 채워준 후 </tr>을 닫아줌
		
	} else {	// 일정 목록이 없으면
		out.println("검색된 일정이 없습니다.");
	}
out.println("</table>");
%>		
	</div>	<!-- tableBox -->
		</div> <!-- contents_con -->
		
   </div> <!-- container-default_box -->
</div> <!-- container -->
<%@ include file="../../cni/footer.jsp" %>
</body>
</html>