<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<MemberInfo> memberInfo = (ArrayList<MemberInfo>)request.getAttribute("memberInfo");

AdminMemberInfo adminMemberInfo = (AdminMemberInfo)request.getAttribute("adminMemberInfo");

int cpage = adminMemberInfo.getCpage(),psize = adminMemberInfo.getPsize(),rcnt = adminMemberInfo.getRcnt();
int spage = adminMemberInfo.getSpage(),bsize = adminMemberInfo.getBsize(),pcnt = adminMemberInfo.getPcnt();

String schtype = adminMemberInfo.getSchtype(), keyword = adminMemberInfo.getKeyword();
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
<title>트레버</title>
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
			<div class="mem_contents">
				<h2>회원 관리</h2>
				<div class="subM">
					<!-- 찾기 영역 -->
					<form action="" name="frm_mem">
						<select name="schtype">
							<option value="id" <% if (schtype.equals("id")) { %> selected="selected" <% } %>>아이디</option>
							<option value="nickname" <% if (schtype.equals("nickname")) { %> selected="selected" <% } %>>닉네임</option>
							<option value="name" <% if (schtype.equals("name")) { %> selected="selected" <% } %>>이름</option>
							<option value="mail" <% if (schtype.equals("mail")) { %> selected="selected" <% } %>>이메일</option>
							<option value="status" <% if (schtype.equals("status")) { %> selected="selected" <% } %>>상태</option>
							<option value="join" <% if (schtype.equals("join")) { %> selected="selected" <% } %>>가입일</option>
						</select> 
						<input type="text" name="keyword" placeholder="검색란" value="<%=keyword %>"> 
						<input type="submit" value="찾기" style="cursor: pointer;">
					</form>
					<form action="memberFormIn" name="frm_member_svc" method="post">
						<ul>
							<li><span class="count">총 회원수 : <span class="mem_num"><%=rcnt %></span></span></li>
							<li><input type="button" value="회원 삭제" id="memDel"  onclick="getSelectedValues()"></li>
							<li><input type="button" value="회원 추가" id="memIn" onclick="location.href='/traverSite/lmth/admin/01_member/mem_form_in.jsp';"></li>
						</ul>
					</form>
				</div>
			</div>
			<div class="mem_table">
			<form action="adminMemberFormUp" name="frm_member_table" method="get">
				<table>
					<thead>
						<tr>
							<th scope="col"><input type="checkbox" id="chkAll"></th>
							<th scope="col">아이디</th>
							<th scope="col">닉네임</th>
							<th scope="col">이름</th>
							<th scope="col">이메일</th>
							<th scope="col">상태</th>
							<th scope="col">가입일</th>
							<th scope="col">관리</th>
						</tr>
					</thead>
					<tbody>
					<%
					if (memberInfo.size() > 0) {
						for (int i = 0; i < memberInfo.size(); i++) {
							MemberInfo mi = memberInfo.get(i);
							String miid = mi.getMi_id();
					%>
					<tr align="center">
						<td>
							<input type="checkbox" name="chk" value="<%=mi.getMi_id() %>">
						</td>
						<td><%=mi.getMi_id() %></td>
						<td><%=mi.getMi_nickname() %></td>
						<td><%=mi.getMi_name() %></td>
						<td><%=mi.getMi_mail() %></td>
						<td><% if (mi.getMi_status().equals("a")) { %>정회원<% } else if (mi.getMi_status().equals("b")) { %>정지 회원<% } else if (mi.getMi_status().equals("c")) { %>탈퇴 회원<% } %></td>
						<td><%=mi.getMi_join() %></td>
						<td>
							<input type="button" value="수정" onclick="location.href='adminMemberFormUp?miid=<%=miid %>';" class="mem_btn_type">
						</td>
					</tr>
					<%
						}
					} else {
						out.println("<tr><td colspan='8' align='center'>");
						out.println("검색결과가 없습니다.</td></tr>");
					}
					%>
					</tbody>
				</table>
				</form>
				<div class="num_list">
					<tr>
					<td>
					<%
					if (rcnt > 0) {	// 게시글이 있으면 - 페이징 영역을 보여줌
						String lnk = "adminMemberList?cpage=";
						pcnt = rcnt / psize;
						if (rcnt % psize > 0)	pcnt++;	// 전체 페이지 수
					
						if (cpage == 1) {
							out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
						} else {
							out.println("<a href='" + lnk + "1" + schargs + "'>[처음]</a>&nbsp;&nbsp;&nbsp;");
							out.println("<a href='" + lnk + (cpage - 1) + schargs + "'>[이전]</a>&nbsp;&nbsp;");
						}
					
						spage = (cpage - 1) / bsize * bsize + 1;	// 현재 블록에서의 시작 페이지 번호
						for (int i = 1, j = spage ; i <= bsize && j <= pcnt ; i++, j++) {
						// i : 블록에서 보여줄 페이지의 개수만큼 루프를 돌릴 조건으로 사용되는 변수
						// j : 실제 출력한 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 사용해야 함
							if (cpage == j) {
								out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
							} else {
								out.println("&nbsp;<a href='" + lnk + j + schargs + "'>" + j + "</a>&nbsp;");
							}
						}
					
						if (cpage == pcnt) {
							out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
						} else {
							out.println("&nbsp;&nbsp;<a href='" + lnk + (cpage + 1) + schargs + "'>[다음]</a>");
							out.println("&nbsp;&nbsp;&nbsp;<a href='" + lnk + pcnt + schargs + "'>[마지막]</a>");
						}
					}
					%>
					</td>
					</tr>
				</div>
			</div>
		</div>
	</div>
</body>
</html>