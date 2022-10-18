<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<AdminSchList> adminSchList = (ArrayList<AdminSchList>)request.getAttribute("adminSchList");

AdminSchInfo adminSchInfo = (AdminSchInfo)request.getAttribute("adminSchInfo");

int cpage = adminSchInfo.getCpage(),psize = adminSchInfo.getPsize(),rcnt = adminSchInfo.getRcnt();
int spage = adminSchInfo.getSpage(),bsize = adminSchInfo.getBsize(),pcnt = adminSchInfo.getPcnt();

String schtype = adminSchInfo.getSchtype(), keyword = adminSchInfo.getKeyword();
String schargs = "", args = "";
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	schargs = "&schtype=" + schtype + "&keyword=" + keyword;
	// 검색조건과 검색어가 있으면 검색관련 데이터들을 쿼리스트링으로 지정
}
args = "&cpage=" + cpage + schargs;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/traverSite/lmth/admin/file/css/reset.css" type="text/css" rel="stylesheet">
<link href="/traverSite/lmth/admin/file/css/style.css" type="text/css" rel="stylesheet">
<script src="/traverSite/lmth/admin/file/js/jquery-3.6.1.js"></script>
<script>
function adminMemberDel(miid) {
	if (confirm("정말 삭제하시겠습니까?")) {
		$.ajax({
			type : "POST", 
			url : "/traverSite/adminMemberProcDel", 
			data : {"miid" : miid}, 
			success : function(chkRs) {
				if (chkRs == 0) {
					alert("회원 삭제에 실패했습니다.\n다시 시도하세요.");
				}
				location.reload();
			}
		});
	}
}
	
function getSelectedValues() {
// 체크박스들 중 선택된 체크박스들의 값들을 쉼표로 구분하여 문자열로 리턴하는 함수
	var chk = document.frm_member_table.chk;
	var idxs = "";	// chk컨트롤 배열에서 선택된 체크박스의 값들을 누적 저장할 변수(ex 1,2,3)
	for (var i = 0 ; i < chk.length ; i++) {
		if (chk[i].checked)	{
			idxs += "," + chk[i].value;
		}
	}
	adminMemberDel(idxs.substring(1))
	return idxs.substring(1);
}

$(document).ready(function() {
	$("#chkAll").click(function() {
		if($("#chkAll").is(":checked")) $("input[name=chk]").prop("checked", true);
		else $("input[name=chk]").prop("checked", false);
	});

	$("input[name=chk]").click(function() {
		var total = $("input[name=chk]").length;
		var checked = $("input[name=chk]:checked").length;

		if(total != checked) $("#chkAll").prop("checked", false);
		else $("#chkAll").prop("checked", true); 
	});
});
</script>
</head>
<body>
	<%@ include file="../cni/header.jsp"%>
	<div class="main">
		<div class="container">
			<div class="sch_contents">
				<h2>전체 게시글</h2>
				<div class="subS">
					<!-- 찾기 영역 -->
					<form action="" name="frm_sch">
						<select name="schSel">
							<option value="mi" <% if (schtype.equals("mi_id")) { %> selected="selected" <% } %>>아이디</option>
							<option value="mi" <% if (schtype.equals("mi_nickname")) { %> selected="selected" <% } %>>닉네임</option>
							<option value="mi" <% if (schtype.equals("mi_name")) { %> selected="selected" <% } %>>이름</option>
							<option value="si" <% if (schtype.equals("si_name")) { %> selected="selected" <% } %>>일정명</option>
							<option value="si" <% if (schtype.equals("si_date")) { %> selected="selected" <% } %>>등록일</option>
						</select> 
						<input type="text" name="keyword" placeholder="검색란" value="<%=keyword %>"> 
						<input type="submit" value="찾기" style="cursor: pointer;">
					</form>
					<form action="schedule" name="frm_schedule_svc" method="post">
					<ul>
						<li><span class="count">총 일정 수 : <span class="sch_num"><%=rcnt %></span></span></li>
						<li><input type="button" value="선택 삭제" id="schDel" onclick="getSelectedValues()"></li>
					</ul>
					</form>
				</div>
			</div>
			<div class="schs_table">
			<form action="" name="frm_schedule" method="get">
				<table>
					<thead>
						<tr>
							<th scope="col"><input type="checkbox" id="chkAll"></th>
							<th scope="col">아이디</th>
							<th scope="col">닉네임</th>
							<th scope="col">이름</th>
							<th scope="col">일정명</th>
							<th scope="col">등록일</th>
						</tr>
					</thead>
					<tbody>
					<%
					if (adminSchList.size() > 0) {
						for (int i = 0; i < adminSchList.size(); i++) {
							AdminSchList as = adminSchList.get(i);
							String siid = as.getSi_id();
					%>
						<tr align="center">
							<td>
								<input type="checkbox" name="chk" value="<%=as.getSi_id() %>">
							</td>
							<td><%=as.getMi_id() %></td>
							<td><%=as.getMi_nickname() %></td>
							<td><%=as.getMi_name() %></td>
							<td><%=as.getSi_name() %></td>
							<td><%=as.getSi_date() %></td>
						</tr>
					<%
						}
					} else {
						out.println("<tr><td colspan='6' align='center'>");
						out.println("검색결과가 없습니다.</td></tr>");
					}
					%>
					</tbody>
				</table>
			</form>
			</div>
		</div>
	</div>
</body>
</html>