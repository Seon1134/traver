<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/traverSite/lmth/admin/file/css/reset.css" type="text/css" rel="stylesheet">
<link href="/traverSite/lmth/admin/file/css/style.css" type="text/css" rel="stylesheet">
<script src="/traverSite/lmth/admin/file/js/jquery-3.6.1.js"></script>
<script>
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
</script>
</head>
<body>
	<%@ include file="../cni/header.jsp"%>

	<div class="content">
		<div class="inner">
			<div class="sub_nav">
				<h2>게시물 관리</h2>
				<ul>
					<li><a href="/traverSite/lmth/admin/04_bbs/bbs_01.jsp">전체 게시글</a></li>
					<li><a href="/traverSite/lmth/admin/04_bbs/bbs_02.jsp">전체 리뷰</a></li>
				</ul>
			</div>
			<div class="content_area">
				<div class="main_bbs_02">
					<div class="container">
						<div class="bbs_02_contents">
							<h2>전체 리뷰</h2>
							<div class="subB">
								<!-- 찾기 영역 -->
								<form action="">
									<select name="bbs_02_Sel">
										<option value="아이디">아이디</option>
										<option value="닉네임">등록일</option>
									</select> <input type="text" name="" placeholder="검색란"> <input
										type="button" value="찾기">
								</form>
								<ul>
									<li><span class="count">총 리뷰 : <span class="bbs_num">20개</span></span></li>
									<li><input type="button" value="리뷰 삭제" id="bbsDel"></li>
								</ul>
							</div>
						</div>
						<div class="bbs_02_table">
							<table>
								<thead>
									<tr>
										<th scope="col"><input type="checkbox"></th>
										<th scope="col">아이디</th>
										<th scope="col">장소명</th>
										<th scope="col">리뷰 번호</th>
										<th scope="col">내용</th>
										<th scope="col">등록일</th>
										<th scope="col">관리</th>
									</tr>
								</thead>
								<tbody>
									<tr align="center">
										<td><input type="checkbox"></td>
										<td>admin</td>
										<td>제주 호텔</td>
										<td>1</td>
										<td>
											<div id="btn1"  onclick="toggleBtn1()">
												<p onclick="bbs_02_img_chn()">여행 후기입니다. 여기 완전 재미있네요.
												<img src="/traverSite/lmth/admin/file/img/bbs_02_down.png" id="bbs_02_chn" class="bbs_02_review_img">
												</p>
											</div>
											<div id="btn2" style="display: none;">
                								<p>ㅇㄴㅇㄴㅇㅁㄴㅇ</p>            
                								<p>ㅇㄴㅇㄴㅇㅁㄴㅇ</p>            
                								<p>ㅇㄴㅇㄴㅇㅁㄴㅇ</p>            
                								<p>ㅇㄴㅇㄴㅇㅁㄴㅇ</p>            
                								<p>ㅇㄴㅇㄴㅇㅁㄴㅇ</p>            
                								<p>ㅇㄴㅇㄴㅇㅁㄴㅇ</p>            
                							</div>
										</td>
										<td>test1244@naver.com</td>
										<td><input type="button" value="수정" onclick="" class="bbs_02_btn_type"></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>