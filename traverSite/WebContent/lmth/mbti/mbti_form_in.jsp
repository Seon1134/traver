<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	ArrayList<ScheduleInfo> scheduleList = (ArrayList<ScheduleInfo>) request.getAttribute("scheduleList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추천 글 등록</title>
<style>
.container-default_box {
	position: relative;
}

#section1 {
	width: 1000px;
	margin: 50px auto;
	position: relative;
}

.btn {
	background: inherit;
	border: none;
	box-shadow: none;
	border-radius: 0;
	padding: 0;
	overflow: visible;
	cursor: pointer;
	float: right;
	margin-right: 10px;
}

.sub_font {
	font-size: 19px;
	font-weight: bold;
}

#section1 input[type="text"] {
	hegith: 30px;
	font-size: 16px;
	margin-left: 10px;
	border: none;
	border-bottom: 1px solid #888;
}

hr {
	margin: 15px 0;
}

#map {
	border: 1px solid #888;
	z-index: 0;
}

textarea {
	border: 1px solid #888;
	width: 100%;
}

#dayselect {
	width: 100px;
	height: 30px;
	cursor: pointer;
}

#content {
	padding: 5px;
	lint-height: 1.5;
}

#ctcnt {
	float: right;
}

#subbtn {
	margin: 16px 450px 40px 0;
	right:
}

#section2 {
	width: 100%;
	height: 100%;
	padding: 150px 0 150px 0;
	background-color: rgb(88, 88, 88, 0.8);
	position: absolute;
	top: 0;
	left: 0;
}

#section3 {
	width: 1118px;
	margin: auto;
	border: 1px solid black;
	padding: 30px 30px 30px 50px;
	background-color: #fff
}

#search-box {
	display: inline-block;
	width: 200px;
	height: 28px;
	border: 1px solid #767676;
	position: flex;
	align-items: center;
	margin-bottom: 20px;
}

#sch {
	height: 23px;
	border: none;
	margin-top: 2px;
}

#x-sch {
	width: 10px;
	margin-top: 9px;
	border: none;
}

#x {
	float: right;
	width: 20px;
}

#sch {
	font-size: 16px;
}

#list {
	width: 100%;
	height: 600px;
	overflow: auto;
	font-size: 16px;
}

.post {
	float: left;
	margin: 0 5px 10px 5px;
}

.post_title {
	width: 180px;
	height: 52px;
	display: inline-block;
	padding: 10px;
	background-color: #BDD7EE;
	font-size: 20px;
	font-weight: bold;
	line-height: 1.5;
}

.small {
	font-size: 14px;
}

.postimg {
	width: 200px;
	height: 200px;
}

.display_none {
	display: none;
}
</style>
<script src="file/jq/jquery-3.6.1.js"></script>
<script>
	window.onload = function() {
		const getoldbtn = document.querySelector('#getoldbtn');
		const x = document.querySelector('#x');

		getoldbtn.addEventListener('click', function() {
			section2.classList.remove('display_none');
		});
		x.addEventListener('click', function() {
			section2.classList.add('display_none');
		});
	}
</script>
<script>
	$(document).ready(function() {
		$("#content").keyup(function() {
			var cmt = $(this).val();
			if (cmt.length > 1000) {
				alert("1000자를 초과하였습니다.");
				cmt = cmt.substring(0, 1000);
				$(this).val(cmt);
			}
			$("#count").text(cmt.length);
		});
	});
</script>
</head>
<body>
	<%@ include file="../../cni/header.jsp"%>
	<div class="container">
		<div class="container-default_box">
			<div id="section1">
				<button class="btn" id="getoldbtn">
					<image src="file/img/" alt="기존 일정 가져오기">
				</button>
				</a>&nbsp;&nbsp;
				<button class="btn" id="getnewbtn">
					<image src="file/img/" alt="새 일정 만들기">
				</button>
				</a> <br>
				<br>
				<br>
				<form name="post_frm" action="" method="post">
					<label for="title" class="sub_font"> 제목 </label> <input type="text"
						placeholder="<%%>" size="50" autofocus>
					<hr>
					<label for="schd_name" class="sub_font"> 일정 </label> <input
						id="schd_name" type="text" placeholder="<%%>" size="20" readonly><br>
					<br> 여기는 나중에~~<br>
					<br> <select id="dayselect">
						<option value="day1">1일차</option>
						<option value="day1">여기도 나중에 수정</option>
					</select><br>
					<br>
					<div id="map" style="width: 100%; height: 350px;"></div>
					<script type="text/javascript"
						src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2b05cef42f58551f118588eb3f26ff67&libraries=services"></script>
					<script>
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div ID 넣기
						mapOption = {
							center : new kakao.maps.LatLng(33.3880, 126.60000), // 지도의 중심좌표 : 제주도로 설정해놨어
							level : 10
						// 지도의 확대 레벨 : 줄이거나 늘리면댐
						};

						// 지도를 표시할 div와  지도 옵션으로  지도를 생성
						var map = new kakao.maps.Map(mapContainer, mapOption);
					</script>
					<br>
					<hr>
					<label for="content" class="sub_font">일정소개</label><br>
					<br>
					<textarea id="content" cols="117" rows="7"></textarea>
					<span id="ctcnt"><span id="count">0</span> / 1000</span> <br>
					<br> <a href="mbti_view.jsp"><button type="button"
							class="btn" id="subbtn">
							<image src="file/img/" alt="등록하기">
						</button></a>
					<!-- 나중에 링크 변경 -->
				</form>
			</div>
		</div>
		<div class="display_none" id="section2">
			<div id="section3">
				<button class="btn">
					<img src="file/img/x.png" id="x">
				</button>
				<br>
				<div id="list">
					<%
					if ( scheduleList.size() > 0 ) {
						for (int i = 0; i < scheduleList.size(); i++) {
							ScheduleInfo si = scheduleList.get(i);
							
							String title = si.getSi_name();
							if (title.length() > 12)	title = title.substring(0, 10) + " ...";
					%>
							<div class="post">
								<div class="post_title">
									<%=title %><br><%=(si.getSi_dnum() - 1)%>박&nbsp;<%=si.getSi_dnum()%>일
									<span class="small">(<%=(si.getSi_sdate()).substring(5)%>~<%=(si.getSi_edate()).substring(5)%>)
									</span>
								</div>
								<div class="post_img">
									<img src="file/img/<%=si.getSi_img() %>" class="postimg">
								</div>
							</div>
					<%
						}
					}
					%>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../../cni/footer.jsp"%>
</body>
</html>