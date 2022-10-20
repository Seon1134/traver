<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	ArrayList<ScheduleInfo> scheduleInfoList = (ArrayList<ScheduleInfo>) request.getAttribute("scheduleInfoList");
	ScheduleInfo scheduleInfo = (ScheduleInfo) request.getAttribute("scheduleInfo");
	ArrayList<ScheduleDay> scheduleDayList = (ArrayList<ScheduleDay>) request.getAttribute("scheduleDayList");
	String title = (String) request.getAttribute("title");
	String content = (String) request.getAttribute("content");
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

.getbtn { height: 38px; }

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
	cursor: pointer;
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

function submit(i) {
	var post_frm = document.post_frm;
	var frm = document.getElementById(i);
	
   	frm.title.value = post_frm.title.value;
    frm.content.value = post_frm.content.value;
	
	frm.submit();
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
					<image class="getbtn" src="file/img/getold.png" alt="기존 일정 가져오기">
				</button>
				</a>&nbsp;&nbsp;
				<button class="btn" id="getnewbtn">
					<image class="getbtn" src="file/img/getnew.png" alt="새 일정 만들기">
				</button>
				</a> <br>
				<br>
				<br>
				<form name="post_frm" action="postProcIn" method="post">
				<% if ( scheduleDayList != null) {
					for ( int i = 0; i < scheduleDayList.size(); i++) { 
						ScheduleDay sd = scheduleDayList.get(i); 		%>
					<input type="hidden" name="sd" value="<%=sd.getPi_id()%>"> 
					<input type="hidden" name="sd" value="<%=sd.getSd_dnum()%>"> 
					<input type="hidden" name="sd" value="<%=sd.getSd_seq()%>"> 
					<input type="hidden" name="sd" value="<%=sd.getPi_name()%>">
					<input type="hidden" name="sd" value="<%=sd.getSd_coords()%>"> 
					<input type="hidden" name="sd" value="<%=sd.getSd_date()%>">
				<% } 
				}%>
					<label for="title" class="sub_font"> 제목 </label><input name="title" type="text" size="50" autofocus required
					value="<%=title %>">
					<hr>
					<label for="schd_name" class="sub_font"> 일정 </label> <input id="schd_name" type="text" 
					<% if (scheduleInfo != null ) { %> placeholder="<%=scheduleInfo.getSi_name()%>" <% } %> size="20" readonly required><br>
					<br>
				<%  String sdList = "";
					if ( scheduleInfo != null ) {
				%>	 
					<input type="hidden" name="si" value="<%=scheduleInfo.getMi_id()%>">
					<input type="hidden" name="si" value="<%=loginInfo.getMi_nickname()%>">
					<input type="hidden" name="si" value="<%=scheduleInfo.getSi_dnum()%>">
					<input type="hidden" name="si" value="<%=scheduleInfo.getSi_name()%>">
					<input type="hidden" name="si" value="<%=scheduleInfo.getSi_img()%>">
				     <% 
						for ( int j = 1; j <= scheduleInfo.getSi_dnum(); j++) {
						  sdList += j + "일차 : ";
							for ( int i = 0; i < scheduleDayList.size(); i++ ) { 
								ScheduleDay sd = scheduleDayList.get(i);
								if ( sd.getSd_dnum() == j) { 
									if ( sd.getSd_seq() == 1 ) 	
										sdList += sd.getPi_name();
									else 			
										sdList += " > " +sd.getPi_name();
								}
							}
							sdList += "<br><br>";
						} 
				 %>
				 	<%=sdList %>
				 	<input type="hidden" name="sdList" value="<%=sdList %>">
				 <% } %>
					<select id="dayselect" onchange="">
				<% 
					if ( scheduleInfo != null ) {
						for ( int i = 1; i <= scheduleInfo.getSi_dnum(); i++ ) { 
				%>
								<option value="<%=i %>"><%=i %>일차</option>
				<%			
						}
					}
				%>
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
						
						<%
						if ( scheduleDayList != null ) {
							for (int i = 0; i < scheduleDayList.size(); i++ ) {
								ScheduleDay sd = scheduleDayList.get(i);
								%> 
								
								var position<%=sd.getPi_id()%> = ({	// 마커의 윈도우인포에 장소 이름과 위치를 저장
									 content: "<div style='display:inline-block; margin:5px 0 5px 5px;'><%=sd.getPi_name()%></div>", 
								     latlng: new kakao.maps.LatLng<%=sd.getSd_coords()%>
								});
								
							    var marker = new kakao.maps.Marker({ // 마커를 생성
							        map: map, // 마커를 표시할 지도
							        position: position<%=sd.getPi_id()%>.latlng 
							    });
							    
							    var infowindow = new kakao.maps.InfoWindow({ // 마커에 표시할 툴팁 생성
							        content: position<%=sd.getPi_id()%>.content 
							    });
						    <% 
						    } 
						}	
						%>
					
					</script>
					<br>
					<hr>
					<label for="content" class="sub_font">일정소개</label><br>
					<br>
					<textarea id="content" name="content" cols="117" rows="7" required><%=content %></textarea>
					<span id="ctcnt"><span id="count">0</span> / 1000</span> <br>
					<br> <a href="mbti_view.jsp"><button type="submit"
							class="btn" id="subbtn">
							<image class="getbtn" src="file/img/submit.png" alt="등록하기">
						</button></a>
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
					if ( scheduleInfoList != null ) {
						for (int i = 0; i < scheduleInfoList.size(); i++) {
							ScheduleInfo si = scheduleInfoList.get(i);
					%>		
							<form name="<%=i %>" id="<%=i %>" action="/traverSite/postFormIn" method="post">  
							<input type="hidden" name="siid" value="<%=si.getSi_id() %>">
          					<input type="hidden" name="title">  
          					<input type="hidden" name="content">    
          				<% 
							String si_name = si.getSi_name();
							if (si_name.length() > 10)	si_name = si_name.substring(0, 9) + " ...";
						%>
							<div class="post" onclick="submit('<%=i %>');">
								<div class="post_title">
									<%=si_name %><br><%=(si.getSi_dnum() - 1)%>박&nbsp;<%=si.getSi_dnum()%>일
									<span class="small">(<%=(si.getSi_sdate()).substring(5)%>~<%=(si.getSi_edate()).substring(5)%>)
									</span>
								</div>
								<div class="post_img">
									<img src="file/img/<%=si.getSi_img() %>" class="postimg">
								</div>
							</div>
							</form>
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