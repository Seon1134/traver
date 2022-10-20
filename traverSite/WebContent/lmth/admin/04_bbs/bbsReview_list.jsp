<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<AdminReviewList> adminReviewList = (ArrayList<AdminReviewList>)request.getAttribute("adminReviewList");

AdminBbsReVInfo adminBbsReVInfo = (AdminBbsReVInfo)request.getAttribute("adminBbsReVInfo");

int cpage = adminBbsReVInfo.getCpage(),psize = adminBbsReVInfo.getPsize(),rcnt = adminBbsReVInfo.getRcnt();
int spage = adminBbsReVInfo.getSpage(),bsize = adminBbsReVInfo.getBsize(),pcnt = adminBbsReVInfo.getPcnt();

String schtype = adminBbsReVInfo.getSchtype(), keyword = adminBbsReVInfo.getKeyword();
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
function toggleBtn1() {
	  
	// 토글 할 버튼 선택 (btn1)
	var btn2 = document.getElementById('btn2');
	
	// btn2 숨기기 (display: none)
	if(btn2.style.display !== 'none') {
	  btn2.style.display = 'none';
	}
	// btn2 보이기 (display: block)
	else {
	  btn2.style.display = 'block';
	}
}

var state = 1;

function bbs_02_img_chn() {
    if ( state == 0 ) {
        state = 1;
        document.getElementById('bbs_02_chn').src = "/traverSite/lmth/admin/file/img/bbs_02_down.png";
    } else {
        state = 0;
        document.getElementById('bbs_02_chn').src = "/traverSite/lmth/admin/file/img/bbs_02_up.png";
    }
}
$(document).ready(function(){
	 $('#adminBbs_rev_table th').each(function (column) {
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

	      var rec = $('#adminBbs_rev_table').find('tbody>tr').get();

	      rec.sort(function (a, b) {
	        var val1 = $(a).children('td').eq(column).text().toUpperCase();
	        var val2 = $(b).children('td').eq(column).text().toUpperCase();
	        return (val1 < val2)?-sortdir:(val1>val2)?sortdir:0;
	      });

	      $.each(rec, function(index, row) {
	          $('#adminBbs_rev_table tbody').append(row);
	      });
	    });
	 });
	});
</script>
</head>
<body>
	<%@ include file="../cni/header.jsp"%>

	<div class="content">
		<div class="inner">
			<div class="sub_nav">
				<h2>게시물 관리</h2>
				<ul>
					<li><a href="/traverSite/admimBbsContentsList">전체 게시글</a></li>
					<li><a href="/traverSite/admimBbsReviewList">전체 리뷰</a></li>
				</ul>
			</div>
			<div class="content_area">
				<div class="main_bbs_02">
					<div class="container">
						<div class="bbs_02_contents">
							<h2>전체 리뷰</h2>
							<div class="subB">
								<!-- 찾기 영역 -->
								<form action="" name="frm_bbs_rev">
									<select name="bbs_02_Sel">
										<option value="id">아이디</option>
										<option value="pname">장소명</option>
										<option value="idx">번호</option>
										<option value="content">내용</option>
										<option value="date">등록일</option>
									</select> 
										<input type="text" name="keyword" placeholder="검색란" value="<%=keyword %>">
										<input type="submit" value="찾기" style="cursor: pointer;">
								</form>
								<ul>
									<li><span class="count">총 리뷰 : <span class="bbs_num"><%=rcnt %>개</span></span></li>
									<li><input type="button" value="리뷰 삭제" id="bbsDel" onclick="getSelectedValues()"></li>
								</ul>
							</div>
						</div>
						<div class="bbs_02_table">
						<form action="adminBbsReviewFormUp" name="frm_bbs_review_table" method="get">
							<table id="adminBbs_rev_table">
								<thead>
									<tr>
										<th scope="col">
											<input type="checkbox" id="chkAll">
										</th>
										<th scope="col" style="cursor: pointer;">아이디</th>
										<th scope="col" style="cursor: pointer;">장소명</th>
										<th scope="col" style="cursor: pointer;">리뷰 번호</th>
										<th scope="col" style="cursor: pointer;">내용</th>
										<th scope="col" style="cursor: pointer;">등록일</th>
										<th scope="col" style="cursor: pointer;">관리</th>
									</tr>
								</thead>
								<tbody>
								<%
								if (adminReviewList.size() > 0) {
									for (int i = 0; i < adminReviewList.size(); i++) {
										AdminReviewList rl = adminReviewList.get(i);
										String rlid = Integer.toString(rl.getRl_idx());
								%>
									<tr align="center">
										<td>
											<input type="checkbox" name="chk" value="<%=rlid %>">
										</td>
										<td><%=rl.getMi_id() %></td>
										<td><%=rl.getRl_pname() %></td>
										<td><%=rl.getRl_idx() %></td>
										<td>
											<div id="btn1"  onclick="toggleBtn1()">
												<p onclick="bbs_02_img_chn()">
													<%=rl.getRl_content() %><img src="/traverSite/lmth/admin/file/img/bbs_02_down.png" id="bbs_02_chn" class="bbs_02_review_img">
												</p>
											</div>
											<div id="btn2" style="display: none;">
												<%=rl.getRl_img1() %>    
												<%=rl.getRl_img2() %>    
												<%=rl.getRl_img3() %>    
												<%=rl.getRl_img4() %>
                							</div>
										</td>
										<td><%=rl.getRl_date() %></td>
										<td><input type="button" value="수정" onclick="Location.href='adminBbsFormUp?rlidx=<%=rlid %> %>';" class="bbs_02_btn_type"></td>
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
								String lnk = "admimBbsReviewList?cpage=";
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
			</div>
		</div>
	</div>
</body>
</html>