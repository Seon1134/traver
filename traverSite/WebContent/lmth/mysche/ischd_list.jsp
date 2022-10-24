<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관심 일정 목록</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
function btnClick() {
	var frm = document.frmSch;
	var keyword = frm.keyword.value;
	if (keyword == "") {
		alert("검색어를 입력해 주세요.");
	}
 } 
 
function mscdDel(giid) {
	if (confirm("정말 삭제하시겠습니까?")) {
		$.ajax({
			type : "POST",
			url : "/traverSite/ischdProcDel",
			data : {"giid" : giid},
			success : function(chkRs) {	 
				if (chkRs == 0) {	// 삭제에 실패했을 경우
					alert("관심일정 삭제에 실패했습니다. \n다시 시도해 보세요.");
				}
				location.reload();	
			}
		});
	}
}
</script>
<style>
.container-default_box { padding: 0px 40px 0px 40px; }

.sch_h2 {margin: 40px 0;}
.contents_sch {height: 100px; width: 400px;}
.contents_con {height: 600px;}

#title { color: #000; }
select { height: 29px; vertical-align: middle; cursor: pointer; }
#search-box {
	border: 1px solid #767676;
    width:200px;
    height:30px;
    margin-left:643px;
    margin-bottom:50px;
}
input[type="text"] { height:23px; border: none; margin-left: 5px; }
#scheCnt { position: relative; top: 6px; } 
.linematch { display: flex; white-space: nowrap; }

.btn {
	margin-bottom:60px;
	background: inherit; border: none; 
	box-shadow: none; border-radius: 0; 
	padding: 0;  cursor: pointer;
}
#schBtn { 
	width:70px; height:33px; 
	margin-left: 5px; 
}

.upBox { 
	background-color: #C5E0B4; width:225px; height:70px; 
	border:solid 1px lightgray; color:black; padding-top:5px;
}
.mouseEventBox:hover { background: #efefef; width:225px; height:260px; }
.delbtnInside { width:220px; }
.delBtn {cursor: pointer; float: right; }

.dnumSize { font-size: 17px; font-weight: bold; ;}
#schdName { 
	width: 180px;
	height: 52px;
	padding: 10px;
	font-size: 17px;
	font-weight: bold;
	line-height: 1.5;
}


#subtitle { font-size: 25px; font-weight: bold;}
.tableBox { width:100%; height:1000px; overflow:auto; }

</style>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<GoodInfo> goodList = (ArrayList<GoodInfo>)request.getAttribute("goodList");
// 관심일정 목록이 들어있는 ArrayList<GoodInfo>를 형변환하여 받아옴

if (goodList.size() > 0) {
for (int i = 0 ; i < goodList.size() ; i++) {
	GoodInfo gi = goodList.get(i);
		String giid = gi.getGi_id();
	}
}

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
   <div class="container-default_box" style="height:1200px;">
   		
   		<div class="contents_con">
   			<div class="contents_sch">
   				<div class="sch_h2">
   					<a href="/traverSite/ischdList" id="title"><span id="subtitle">관심 일정</span></a>
				</div>
   		
   				<form name="frmSch" method="get">
			 	<input type="hidden" name="o" value="<%=o%>"/>
			 	<input type="hidden" name="sy" value="<%=sy %>"/>
		 	
		 		<div class="linematch">
   					<select class="sy" onchange="location.href='/traverSite/ischdList?<%=schargs + oargs%>&sy=' + this.value;">
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
						<select name="o" onchange="location.href='/traverSite/ischdList?<%=schargs + yargs%>&o=' + this.value;">
							<option value="a" <% if (o.equals("a")) { %>selected="selected"<% } %>>등록 최신 순</option>
							<option value="b" <% if (o.equals("b")) { %>selected="selected"<% } %>>등록 오래된 순</option>
					 	</select>
				 
				 		<span id="scheCnt">&nbsp;&nbsp;&nbsp;일정 수 :  <%=goodList.size() %>   </span>
					 		<div id="schNbtn" style="display:flex;">
								<div id= "search-box" >
								 	<input type="text" name="keyword" value="<%=keyword %>" placeholder="일정제목으로 검색하세요." >
								</div>
								<button class="btn" onclick="btnClick()">
									<img src="/traverSite/file/img/sch.png" id="schBtn"/>
								</button>
							</div>
						</div> <!-- linematch -->
					</form>
				
			</div> <!-- contents_sch -->
			<br/><br/><br/><br/>
		 
			<div class="tableBox">
				<form name="frmSch2" method="post">
					<table width="100%" callpadding="5" >
<%
	if (goodList.size() > 0) { 	// 관심일정 목록이 있으면
		int i = 0;
		for (i = 0 ; i < goodList.size() ; i++) {
			GoodInfo gi = goodList.get(i);
			
			String giid = gi.getGi_id();
			String title = gi.getGi_name();
			if (title.length() > 10)	title = title.substring(0, 9) + " ...";
			
			String dnum1 = (gi.getGi_dnum() - 1) + "박";
			String dnum2 = gi.getGi_dnum() + "일";
			
			if (i % 5 == 0) 	out.println("<tr>");
%>

					<td width="20%" align="center" >
						<div class="mouseEventBox">
							<div class="delbtnInside">
								<input type="button" value="X" class="delBtn" onclick="mscdDel('<%=giid %>');" />
							</div>
								<a href="ischdDetail?giid=<%=gi.getGi_id() + args %>">
									<div class="upBox" >
										<span id="schdName"><%=title %></span><br />
										<span class="dnumSize"><%=dnum1%>&nbsp;<%=dnum2%></span><br />
									</div>	
									<img src="/traverSite/file/img/<%=gi.getGi_img() %>" width="227" height="180"/>
								</a>	
						</div><br/><!-- mouseEventBox -->
					</td>
				</form>
<%		
			if (i % 5 == 4) 	out.println("</tr>");
		}
		
		if (i % 5 > 0) {	// 일정이 5개 단위로 맞아 떨어지지 않았을 경우
			for (int j = 0; j < (5 - 1) ; j++) out.println("<td width='20%'></td>");
			out.println("</tr>");
		} // 빈 칸으로 5개를 채워준 후 </tr>을 닫아줌
		
	} else {	// 일정 목록이 없으면
		out.println("검색된 관심 일정이 없습니다.");
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