<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이용약관</title>
<style>
.main_box { width: 100%; height: 800px; display: flex; align-items: center; justify-content: center; }
.chkbox_group { 
    width:700px; height:700px; 
    border:solid 1px black; background-color:#fafcfc;
}
.agreement1 { 
    width:650px; height:100px; overflow:auto; border:solid 1px black; 
    margin-left:25px; margin-top:15px;
}
.agreement2 { 
    width:650px; height:100px; overflow:auto; border:solid 1px black; 
    margin-left:25px; margin-top:15px;
}
.agreement3 { 
    width:630px; height:100px; overflow:auto; border:black; 
    margin-left:15px; margin-top:15px;
}
.check1 { margin:40px 5px 5px 20px; }
.check2 { margin:40px 5px 5px 20px; }
.check3 { margin:40px 5px 5px 20px; }
.check4 { margin:20px 5px 5px 430px; }

.title { 
    font-size:20px; font-weight:bold; 
    line-height:30px; margin:5px 5px 5px 5px; 
}
.r1 { font-weight:bold; }
.r2 { color:red; }

#btnCancel { border:solid 1px black; font-size:14px; width:70px; height:40px; }
#btnAgree { border:solid 1px black; font-size:14px; width:70px; height:40px; }
.btn_area { text-align:center; }

</style>
<script>
function checkSelectAll() {
  // 전체 체크박스
  const checkboxes = document.frmChk.querySelectorAll('input[name="chk"]');
  // 선택된 체크박스
  const checked = document.frmChk.querySelectorAll('input[name="chk"]:checked');
  // select all 체크박스
  const selectAll = document.frmChk.querySelector('input[name="selectall"]');
  
  selectAll.checked = (checkboxes.length === checked.length);

}
function selectAll(selectAll) {
	var arrChk = document.frmChk.chk;
	for (var i=0; i < arrChk.length; i++ )	{
		arrChk[i].checked = selectAll.checked;
	}
}	
</script>
</head>
<body>
<%@ include file="../../cni/header.jsp" %>
<!-- 컨테이너 시작 -->
<div class="container">
   <div class="container-default_box">
 
	   	<div class="main_box"> 
		   	<div class="chkbox_group">
			   	<h2 class="title" >트레버 이용약관 동의</h2><hr/>
			   	
				<form name="frmChk" action="join_form.jsp" method="post">
					<div class="check1">
						<label class="r1">
							<input type="checkbox" name="chk" value="1" required="required" onclick="checkSelectAll();" />
						이용약관 동의(<span class="r2">필수</span>)</label>
					</div>
					<div class="agreement1">
					트레버 서비스를 이용해 주셔서 감사합니다.<br />
					본 약관은 다양한 트레버 서비스의 이용과 관련하여 트레버 서비스를 제공하는 트레버 주식회사(이하
					'트레버')와 이를 이용하는 트레버 서비스 회원(이하 '회원') 또는 비회원과의 관계를 설명하며, 아울러<br />
					여러분들의 트레버 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.<br />
					약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />
					약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />
					약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />
					약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />
					약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />
					약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />
					</div>
						
					<div class="check2">
						<label class="r1">
							<input type="checkbox" name="chk" value="2" required="required" onclick="checkSelectAll();" />
						개인정보 수집 및 이용 동의(<span class="r2">필수</span>)</label>
					</div>
					<div class="agreement2">
					개인정보처리방침<br /><br />
					[차례]<br />
					1. 총칙<br />
					2. 개인정보 수집에 대한 동의<br />
					2. 개인정보의 수집 및 이용목적<br />
					약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />
					약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />
					약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />
					약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />
					약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />
					약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용<br />
					</div>
						
					<div class="check3">
						<label class="r1">
							<input type="checkbox" name="chk" value="3" onclick="checkSelectAll();" />
						이벤트 정보 수신(선택)</label>
					</div>
					<div class="agreement3">
					&nbsp;&nbsp;&nbsp;트레버에서 제공하는 이벤트/혜택 등 다양한 정보를 이메일로 받아보실 수 있습니다.<br />
					&nbsp;&nbsp;&nbsp;일부 서비스(별도 회원 체계로 운영하거나 트레버 가입 이후 추가 가입하여 이용하는 서비스 등)의
					&nbsp;&nbsp;&nbsp;경우, 개별 서비스에 대해 별도 수신 동의를 받을 수 있으며, 이때에도 수신 동의에 대해 별도로 안<br />
					&nbsp;&nbsp;&nbsp;내하고 동의를 받습니다.<br />
					</div>
			
					<div class="check4">
						<label class="r1">회원가입 약관에 모두 동의 합니다.
							<input type="checkbox" name="selectall" value="selectall" onclick="selectAll(this);" />
						</label>
					</div><br/><br/>	
					<div class="btn_area">
						<input type="button" id="btnCancel" value="취 소" onclick="history.back();" />
						<input type="submit" id="btnAgree" value="확 인" />
			        </div>
		   		</form>
		    </div>
	    </div><!-- main_box -->
   
   </div>
</div>
<!-- 컨테이너 종료 -->
<%@ include file="../../cni/footer.jsp" %>
</body>
</html>