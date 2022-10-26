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
input[type="text"] { height:23px; margin-left: 5px; position: relative; left: 783px; }
#scheCnt { position: relative; top: 6px; } 
.linematch { display: flex; white-space: nowrap; }
#x-sch {
	width: 10px;
	border: none;
	position: relative;
    right: 18px;
    top: 8px;
}
#schBtn { 
	width:30px; height:30px; 
	margin-left: 5px;     
	position: relative;
    left: 785px;
}

.upBox { 
	background-color:#b4e0bda6; width:200px; height:50px; 
	border:solid 1px #b4e0bda6; color:black; padding: 8px 0; line-height: 1.5;
}
.mouseEventBox { width: 240px; }
.delbtnInside { width:220px; }
.delBtn {cursor: pointer; float: right; }

.dnumSize { font-size: 17px; font-weight: bold; ;}
#schdName { 
	width: 180px;
	height: 50px;
	padding-bottom: 10px;
	font-size: 17px;
	font-weight: bold;
}
.btn {
	background: inherit;
	border: none;
	box-shadow: none;
	border-radius: 0;
	padding: 0;
	overflow: visible;
	cursor: pointer;
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

String o = request.getParameter("o");
String keyword = request.getParameter("keyword");

String args = "", yargs = "", oargs = "", schargs = "";
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
		 	
		 		<div class="linematch">
						<select name="o" onchange="location.href='/traverSite/ischdList?<%=schargs + yargs%>&o=' + this.value;">
							<option value="a" <% if (o.equals("a")) { %>selected="selected"<% } %>>등록 최신 순</option>
							<option value="b" <% if (o.equals("b")) { %>selected="selected"<% } %>>등록 오래된 순</option>
					 	</select>
				 
				 		<span id="scheCnt">&nbsp;&nbsp;&nbsp;일정 수 :  <%=goodList.size() %>   </span>
					 		<div id="schNbtn" style="display:flex;">
								 	<input type="text" name="keyword" value="<%=keyword %>" placeholder="일정제목으로 검색하세요." >
								<button class="btn" onclick="btnClick()">
									<img src="/traverSite/file/img/sch.png" id="schBtn"/>
								</button>
							</div>
						</div> <!-- linematch -->
					</form>
				
			</div> <!-- contents_sch -->
			<br/><br/>
		 
			<div class="tableBox">
				<form name="frmSch2" method="post">
					<table width="100%" >
<%
	if (goodList.size() > 0) { 	// 관심일정 목록이 있으면
		int i = 0;
		for (i = 0 ; i < goodList.size() ; i++) {
			GoodInfo gi = goodList.get(i);
			
			String giid = gi.getGi_id();
			String title = gi.getGi_name();
			if (title.length() > 10)	title = title.substring(0, 9) + " ...";
			
			String dnum = "";
			if ( gi.getGi_dnum() == 1) {
				dnum = "당일치기";
			} else {
				String dnum1 = (gi.getGi_dnum() - 1) + "박 ";
				String dnum2 = gi.getGi_dnum() + "일";
				dnum = dnum1 + dnum2;
			}
			
			if (i % 5 == 0) 	out.println("<tr>");
%>

					<td width="200" align="center" >
						<div class="mouseEventBox">
							<div class="delbtnInside">
								<button type="button" value="X" class="delBtn btn" onclick="mscdDel('<%=giid %>');" >
								<img src="file/img/x.png" id="x-sch">
								</button>
							</div>
								<a href="ischdDetail?giid=<%=gi.getGi_id()%>&day=1">
									<div class="upBox" >
										<span id="schdName"><%=title %></span><br />
										<span class="dnumSize"><%=dnum %></span><br />
									</div>	
									<img src="/traverSite/file/img/map_img/<%=gi.getGi_img() %>" width="202" height="180"/>
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