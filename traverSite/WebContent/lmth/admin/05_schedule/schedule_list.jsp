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
function adminShceduleDel(siid) {
	if (confirm("정말 삭제하시겠습니까?")) {
		$.ajax({
			type : "POST", 
			url : "/traverSite/admimScheduleProcDel", 
			data : {"siid" : siid}, 
			success : function(chkRs) {
				if (chkRs == 0) {
					alert("일정 삭제에 실패했습니다.\n다시 시도하세요.");
				}
				location.reload();
			}
		});
	}
}
	
function getSelectedValues() {
// 체크박스들 중 선택된 체크박스들의 값들을 쉼표로 구분하여 문자열로 리턴하는 함수
	var chk = document.frm_schedule_table.chk;
	var idxs = "";	// chk컨트롤 배열에서 선택된 체크박스의 값들을 누적 저장할 변수(ex 1,2,3)
	for (var i = 0 ; i < chk.length ; i++) {
		if (chk[i].checked)	{
			idxs += "," + chk[i].value;
		}
	}
	adminShceduleDel(idxs.substring(1))
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
$(document).ready(function(){
 $('#adminSch_tabel th').each(function (column) {
    $(this).click(function() {
      if($(this).is('.asc')) {
        $(this).removeClass('asc');
        $(this).addClass('desc');
        sortdir=-1;

      } else {
        $(this).addClass('asc');
        $(this).removeClass('desc'); sortdir=1;
      }

      $(this).siblings().removeClass('asc');
      $(this).siblings().removeClass('desc');

      var rec = $('#adminSch_tabel').find('tbody>tr').get();

      rec.sort(function (a, b) {
        var val1 = $(a).children('td').eq(column).text().toUpperCase();
        var val2 = $(b).children('td').eq(column).text().toUpperCase();
        return (val1 < val2)?-sortdir:(val1>val2)?sortdir:0;
      });

      $.each(rec, function(index, row) {
          $('#adminSch_tabel tbody').append(row);
      });
    });
 });
});
</script>
</head>
<body>
	<%@ include file="../cni/header.jsp"%>
	<div class="main">
		<div class="container">
			<div class="sch_contents">
				<h2>일정 관리</h2>
				<div class="subS">
					<!-- 찾기 영역 -->
					<form action="" name="frm_sch">
						<select name="schtype">
							<option value="miid" <% if (schtype.equals("id")) { %> selected="selected" <% } %>>아이디</option>
							<option value="minick" <% if (schtype.equals("nick")) { %> selected="selected" <% } %>>닉네임</option>
							<option value="miname" <% if (schtype.equals("name")) { %> selected="selected" <% } %>>이름</option>
							<option value="name" <% if (schtype.equals("name")) { %> selected="selected" <% } %>>일정명</option>
							<option value="date" <% if (schtype.equals("date")) { %> selected="selected" <% } %>>등록일</option>
						</select> 
						<input type="text" name="keyword" placeholder="검색란" value="<%=keyword %>"> 
						<input type="submit" value="찾기" style="cursor: pointer;">
					</form>
					<form action="schedule" name="frm_schedule_svc" method="post">
					<ul>
						<li><span class="count">총 일정 수 : <span class="sch_num"><%=rcnt %>개</span></span></li>
						<li><input type="button" value="선택 삭제" id="schDel" onclick="getSelectedValues()"></li>
					</ul>
					</form>
				</div>
			</div>
			<div class="schs_table">
			<form action="" name="frm_schedule_table" method="get">
				<table id="adminSch_tabel">
					<thead>
						<tr>
							<th scope="col"><input type="checkbox" id="chkAll"></th>
							<th scope="col" style="cursor: pointer;">아 이 디</th>
							<th scope="col" style="cursor: pointer;">닉 네 임</th>
							<th scope="col" style="cursor: pointer;">이 름</th>
							<th scope="col" style="cursor: pointer;">총 일 수</th>
							<th scope="col" style="cursor: pointer;">일 정 명</th>
							<th scope="col" style="cursor: pointer;">등 록 일</th>
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
							<td><%=as.getSi_dnum() - 1 %>박 <%=as.getSi_dnum() %>일</td>
							<td><%=as.getSi_name() %></td>
							<td><%=as.getSi_date() %></td>
						</tr>
					<%
						}
					} else {
						out.println("<tr><td colspan='7' align='center'>");
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
						String lnk = "adminScheduleList?cpage=";
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