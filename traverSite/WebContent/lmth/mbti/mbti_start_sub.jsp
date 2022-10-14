<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MBTI 테스트1</title>
<style>
.container-default_box {
	text-align: center;
	padding: 212px 150px 280px 150px;
}
.questbox {
	width: 100%;
	margin: 0 auto;
}
#quest_img { 	
	width: 500px;
	vertical-align: middle;
}
.quest { 
	margin: 110px 48px 0px 0px;
	float: right;
	right: 150px;
	position: relative;
}
.bold { font-size: 25px; font-weight: bold; }
.asw { font-size: 18px;  cursor: pointer; }
#yesbox { margin: 3px 0 8px 0; }
#yes, #no { cursor: pointer; }
.inline {  display: inline; }
#mbtibox, #testbox { padding-top: 80px; }
#mbtiselect { 
	width: 250px; height: 40px; 
	border: 3px solid #B5E8F6;
	color: #888; font-size: 20px; text-align: center; cursor: pointer;
}
#nombti {display:inline;}
.btn {
	background: inherit ; border: none; box-shadow: none; border-radius: 0; 
	padding: 0; overflow: visible; cursor: pointer;
}
.btn_img { height: 40px; }
#submitbtn { height: 36px; }


#testbox { 
	width: 500px; 
	line-height: 1.7;
	margin: 0 auto; }
#testdesc { font-size: 16px; }

.display_none { display: none; }
</style>
<script src="/traverSite/file/jq/jquery-3.6.1.js"></script>
<script>
$(document).ready(function() {
	$("#mbtiselect").change(function() {
		$("#sbmbtn").removeAttr("disabled");
    });
});
</script>
<script>
window.onload = function(){
	const mbtibox = document.querySelector('#mbtibox');
	const testbox = document.querySelector('#testbox');
	const yes = document.querySelector('#yes');	
	const no = document.querySelector('#no');
	
	yes.addEventListener('change', function() {
		mbtibox.classList.remove('display_none');
		testbox.classList.add('display_none');
	});
	
	no.addEventListener('change', function() {
		testbox.classList.remove('display_none');
		mbtibox.classList.add('display_none');
	});
}
</script>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<div class="container">
   <div class="container-default_box">
   		<div class="questbox">
	       	<img src="../../file/img/quest_img.png" id="quest_img">
	       	<div class="quest">
		   		<span class="bold">자신의 MBTI를 알고있나요?</span><br><br><br>
		   		<div id="yesbox"><input type="radio" name="knowmbti" id="yes"><label for="yes"><span class="asw">네, 알고 있어요!</span></label></div><br>
		   		<div id="nobox"><input type="radio" name="knowmbti" id="no"><label for="no"><span class="asw"> 아니요, 몰라요!</span></label></div>
		   	</div>
	   	</div>
	   	<br><br>
	   	<div id="mbtibox" class="display_none" >
	   		<form name="mbtifrm" action="member_proc.mem" method="post">
	   		<input type="hidden" name="kind" value="mbti1" />
		   		<span class="bold inline">나의 MBTI는 </span>
		   		<select id="mbtiselect" name="mi_mbti" class="inline">
		   			<option value="" selected>&nbsp;&nbsp;MBTI를 선택해주세요</option>
		   			<option value="ISTJ">ISTJ</option>
		   			<option value="ISTP">ISTP</option>
		   			<option value="ISFJ">ISFJ</option>
		   			<option value="ISFP">ISFP</option>
		   			<option value="INTJ">INTJ</option>
		   			<option value="INTP">INTP</option>
		   			<option value="INFJ">INFJ</option>
		   			<option value="INFP">INFP</option>
		   			<option value="ESTJ">ESTJ</option>
		   			<option value="ESTP">ESTP</option>
		   			<option value="ESFJ">ESFJ</option>
		   			<option value="ESFP">ESFP</option>
		   			<option value="ENTJ">ENTJ</option>
		   			<option value="ENTP">ENTP</option>
		   			<option value="ENFJ">ENFJ</option>
		   			<option value="ENFP">ENFP</option>
		   		</select>
		   		<span class="bold inline">입니다</span><br><br>
		   		<button type="submit" class="btn" id="sbmbtn" disabled ><image class="btn_img" id="submitbtn" src="../../file/img/submitbtn.png" alt="제출하기" ></button>
	   		</form>
	   	</div>
	   	<div id="testbox" class="display_none">
	   		<span id="testdesc">30초내로 진행 가능한 짧은 MBTI 테스트를 진행하면<br> 자신에게 맞는 여행지를 추천 받을 수 있습니다!</span><br>
	   		<span class="bold">MBTI 진단 테스트를 진행할까요?</span><br><br>
	   		<form name="nombti" id="nombti" action="member_proc.mem" method="post">
	   		<input type="hidden" name="kind" value="mbti1">
	   		<input type="hidden" name="mi_mbti" value="0000">
	   		<button class="btn"><image class="btn_img" id="gobestbtn" src="../../file/img/gobestbtn.png" alt="추천 둘러보기"></button>&nbsp;&nbsp;&nbsp;
	   		</form>
	   		<a href="mbti_test.jsp"><button class="btn"><image class="btn_img" id="gotestbtn" src="../../file/img/gotestbtn.png" alt="진행하기"></button></a>
	   		
	   	</div>
   </div>
</div>
<%@ include file="../../cni/footer.jsp" %>
</body>
</html>