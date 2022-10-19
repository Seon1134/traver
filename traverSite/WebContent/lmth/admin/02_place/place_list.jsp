<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<PlaceInfo> placeInfo = (ArrayList<PlaceInfo>)request.getAttribute("placeInfo");

AdminPlaceInfo adminPlaceInfo = (AdminPlaceInfo)request.getAttribute("adminPlaceList");

int cpage = adminPlaceInfo.getCpage(),psize = adminPlaceInfo.getPsize(),rcnt = adminPlaceInfo.getRcnt();
int spage = adminPlaceInfo.getSpage(),bsize = adminPlaceInfo.getBsize(),pcnt = adminPlaceInfo.getPcnt();

String schtype = adminPlaceInfo.getSchtype(), keyword = adminPlaceInfo.getKeyword();
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
function adminPlaceDel(piid) {
// 장바구니 내의 특정 상품을 삭제하는 함수
	if (confirm("정말 삭제하시겠습니까?")) {
		$.ajax({
			type : "POST", 
			url : "/traverSite/adminPlaceProcDel", 
			data : {"piid" : piid}, 
			success : function(chkRs) {
				if (chkRs == 0) {
					alert("장소 삭제에 실패했습니다.\n다시 시도하세요.");
				}
				location.reload();
			}
		});
	}
}

function getSelectedValues() {
// 체크박스들 중 선택된 체크박스들의 값들을 쉼표로 구분하여 문자열로 리턴하는 함수
	var chk = document.frm_place_table.chk;
	var idxs = "";	// chk컨트롤 배열에서 선택된 체크박스의 값들을 누적 저장할 변수(ex 1,2,3)
	for (var i = 0 ; i < chk.length ; i++) {
		if (chk[i].checked)	{
			idxs += "," + chk[i].value;
		}
	}
	adminPlaceDel(idxs.substring(1))
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
	<div class="place_main">
		<div class="container">
			<div class="place_contents">
				<h2>장소 관리</h2>
				<div class="subP">
				<!-- 찾기 영역 -->
				<form action="" name="frm_place">
					<select name="schtype">
						<option value="name" <% if (schtype.equals("name")) { %>selected="selected" <% } %>>장소명</option>
						<option value="phone" <% if (schtype.equals("phone")) { %>selected="selected" <% } %>>번호</option>
						<option value="ctgr" <% if (schtype.equals("ctgr")) { %>selected="selected" <% } %>>분류</option>
						<option value="date" <% if (schtype.equals("date")) { %>selected="selected" <% } %>>등록일</option>
						<option value="isview" <% if (schtype.equals("isview")) { %>selected="selected" <% } %>>게시여부</option>
						<option value="addr1" <% if (schtype.equals("addr1")) { %>selected="selected" <% } %>>주소</option>
					</select> 
					<input type="text" name="keyword" placeholder="검색란" value="<%=keyword %>"> 
					<input type="submit" value="찾기" style="cursor: pointer;">
				</form>
				<form action="placeFormIn" name="frm_place_svc" method="post">
					<ul>
						<li><span class="count">총 장소 : <span class="place_num"><%=rcnt %>개</span></span></li>
						<li><input type="button" value="장소 삭제" id="placeDel" onclick="getSelectedValues()"></li>
						<li><input type="button" value="장소 추가" id="placeIn" onclick="location.href='/traverSite/lmth/admin/02_place/place_form_in.jsp';"></li>
					</ul>
				</form>
				</div>
			</div>
				<div class="place_table">
				<form action="adminPlaceFormUp" name="frm_place_table" method="get">
					<table>
						<thead>
							<tr>
								<th scope="col"><input type="checkbox" id="chkAll"></th>
								<th scope="col">장 소 명</th>
								<th scope="col">번 호</th>
								<th scope="col">분 류</th>
								<th scope="col">등 록 일</th>
								<th scope="col">게 시 여 부</th>
								<th scope="col">주 소</th>
								<th scope="col">관 리</th>
							</tr>
						</thead>
						<tbody>
							<%
							if (placeInfo.size() > 0) {	
								for (int i = 0; i < placeInfo.size(); i++) {
									PlaceInfo pi = placeInfo.get(i);
									String piid = pi.getPi_id();
							%> 
							<tr align="center">
								<td>
									<input type="checkbox" name="chk" value="<%=pi.getPi_id() %>">
								</td>
								<td><%=pi.getPi_name() %></td>
								<td><%=pi.getPi_phone() %></td>
								<td><% if (pi.getPi_ctgr().equals("1")){ %>호텔<% } else if (pi.getPi_ctgr().equals("2")) { %>음식점<% } else {%>관광지<% } %></td>
								<td><%=pi.getPi_date() %></td>
								<td><% if (pi.getPi_isview().equals("y")) { %>게시 중<% } else if (pi.getPi_isview().equals("n")) { %>게시 중단<% } %></td>
								<td><%=pi.getPi_addr1() %></td>
								<td>
									<input type="button" value="수정" class="place_btn_type" onclick="location.href='adminPlaceFormUp?piid=<%=piid %>';">
								</td>
							</tr>
							<%
							}
						} else { // 글목록이 없으면
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
							String lnk = "adminPlaceList?cpage=";
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