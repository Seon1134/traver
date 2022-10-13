<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("utf-8");
PlaceInfo placeInfo = (PlaceInfo)request.getAttribute("placeInfo");
if (placeInfo == null) {
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어오셨습니다.');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/traverSite/lmth/admin/file/css/reset.css" type="text/css" rel="stylesheet">
<link href="/traverSite/lmth/admin/file/css/style.css" type="text/css" rel="stylesheet">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/traverSite/lmth/admin/file/js/jquery-3.6.1.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=16147bc7c24202d21b21c1b0b06cf459&libraries=services"></script>
<script>
function sample6_execDaumPostcode() {
   new daum.Postcode({
      oncomplete : function(data) {
         // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

         // 각 주소의 노출 규칙에 따라 주소를 조합한다.
         // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
        var addr = ''; // 주소 변수
        var extraAddr = ''; // 참고항목 변수

         //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
         if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
            addr = data.roadAddress;
         } else { // 사용자가 지번 주소를 선택했을 경우(J)
            addr = data.jibunAddress;
         }

         // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
         if (data.userSelectedType === 'R') {
            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if (data.bname !== ''
                  && /[동|로|가]$/g.test(data.bname)) {
               extraAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if (data.buildingName !== ''
                  && data.apartment === 'Y') {
               extraAddr += (extraAddr !== '' ? ', '
                     + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if (extraAddr !== '') {
               extraAddr = ' (' + extraAddr + ')';
            }
            // 조합된 참고항목을 해당 필드에 넣는다.
            document.getElementById("sample6_extraAddress").value = extraAddr;

         } else {
            document.getElementById("sample6_extraAddress").value = '';
         }

         // 우편번호와 주소 정보를 해당 필드에 넣는다.
         document.getElementById('sample6_postcode').value = data.zonecode;
         document.getElementById("sample6_address").value = addr;
        addrCoords(addr); // 그리고 함수실행
         // 커서를 상세주소 필드로 이동한다.
         document.getElementById("sample6_detailAddress")
               .focus();
      }
   }).open();
}
function addrCoords (addr) {
   var geocoder = new daum.maps.services.Geocoder();
   geocoder.addressSearch(addr, function(result, status) { // 주소좌표 검색
       if (status === kakao.maps.services.Status.OK) { // 정상적으로 검색완료시
           coords = new kakao.maps.LatLng(result[0].y, result[0].x); // 좌표저장
         document.getElementById('sample6_addressCoords').value = coords;
      } else {
         alert(coords);
      }
   });
}

$(document).ready(
function() {
   var fileTarget = $('.filebox .upload-hidden');

   fileTarget.on('change', function() { // 값이 변경되면
      if (window.FileReader) { // modern browser
         var filename = $(this)[0].files[0].name;
      } else { // old IE
         var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출
      }
      // 추출한 파일명 삽입
      $(this).siblings('.upload-name').val(filename);
   });
});

/* 이미지 추가 버튼 관련 쿼리
var count = 0;
$(function(){
   $('#button-add-file').click(addFileForm);
   $(document).on('click', '.button-delete-file', function(event) {
      $(this).parent().remove();
      count--;
   });
});
function addFileForm() {
   var html = "<div class='filebox' id='item_" + count + "'>";
   html += "<input class='upload-name' value='파일선택' disabled='disabled'>";
   html += "<label for='ex_filename'>업로드</label>";
   html += "<input type='file' id='ex_filename' name='file_path' class='upload-hidden'>";
   html += "<button class='button-delete-file'>삭제</button></div>";
   
   if ( count < 3) {
      $("#addItem").append(html);
      count++;
   } else {
      alert('추가할 이미지는 4장을 초과할 수 없습니다.');
   }
}
*/

function checkSize(input) {
    if (input.files && input.files[0].size > (2 * 1024 * 1024)) {
        alert("파일 사이즈가 2mb 를 넘습니다.");
        input.value = null;
    }
}

</script>
</head>
<body>
<%@ include file="../cni/header.jsp" %>
   <div class="place_02_contents">
      <div class="container">
         <div class="place_02_h2">
            <h2>장소 수정</h2>
         </div>
         <form name="frm_place_up" action="/traverSite/adminPlaceProcUp" method="post">
            <div class="place_02_tab01">
               <h3>장소 기본 정보</h3>
               <table>
               <tbody>
                  <tr>
                     <th scope="row">장소명</th>
                     <td><input type="text" name="pf_name" value="<%=placeInfo.getPi_name() %>"></td>
                     <th scope="row">전화번호</th>
                     <td><input type="text" name="pf_phone" value="<%=placeInfo.getPi_phone() %>"></td>
                  </tr>
                  <tr>
                     <th scope="row">홈페이지</th>
                     <td><input type="text" name="pf_homepage" value="<%=placeInfo.getPi_link() %>"></td>
                     <th scope="row">분류</th>
                     <td>
                     	<select class="sel_style" name="pf_ctgr">
                     	   <option value="1"<% if (placeInfo.getPi_ctgr().equals("1")) { %> selected="selected" <% } %>>숙소</option>
                           <option value="2"<% if (placeInfo.getPi_ctgr().equals("2")) { %> selected="selected" <% } %>>음식점</option>
                           <option value="3"<% if (placeInfo.getPi_ctgr().equals("3")) { %> selected="selected" <% } %>>관광지(놀거리, 명소 등)</option>
                     	</select>
                     </td>
                  </tr>
                  <tr>
                     <th scope="row">위치</th>
                     <td>
                        <div class="location_sty_01">
                           <input type="text" id="sample6_postcode" placeholder="우편번호" readonly="readonly" name="pf_postcode" value="<%=placeInfo.getPi_zip() %>"> 
                           <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" style="vertical-align: middle;" class="location_btn">
                        </div>
                        <div class="location_sty_02"> 
                           <input type="text" id="sample6_address" placeholder="주소" readonly="readonly" name="pf_address" value="<%=placeInfo.getPi_addr1() %>">
                        </div>
                        <div class="location_sty_03">
                           <input type="text" id="sample6_detailAddress" placeholder="상세주소" name="pf_detailAddress" value="<%=placeInfo.getPi_addr2() %>"> 
                           <input type="text" id="sample6_extraAddress" placeholder="여분주소" name="pf_extraAddress">
                        </div>
                         <input type="hidden" id="sample6_addressCoords" value="" name="pf_addressCoords">
                     </td>
                     <th scope="row">게시 여부</th>
                     <td>
                     	<select class="sel_style">
                     		<option value="y" <% if (placeInfo.getPi_isview().equals("y")) { %> selected="selected" <% } %>>게시</option>
                     		<option value="n" <% if (placeInfo.getPi_isview().equals("n")) { %> selected="selected" <% } %>>게시 중단</option>
                     	</select>
                     </td>
                  </tr>
                  <tr>
                     <th scope="row">설명</th>
                     <td colspan="3"><textarea rows="15" cols="2" style="height: 200px; width: 800px;" name="pf_text" ><%=placeInfo.getPi_desc() %></textarea></td>
                  </tr>
                  <tr>
                     <th scope="row">이미지(썸네일)</th>
                     <td colspan="3">
                        <div class="filebox">
                           <input class="upload-name" value="<%=placeInfo.getPi_img1() %>" disabled="disabled">
                           <label for="filename">업로드</label> 
                           <input type="file" id="filename" name="file_path_ssum" class="upload-hidden" accept="image/png, image/jpeg" onchange="checkSize(this)" value="<%=placeInfo.getPi_img1() %>">
                           <span class="imgSel">＊이미지 크기는 2MB이하로 해주세요. (등록 가능한 이미지 JPG, PNG, JPEG)</span>
                        </div>
                     </td>
                  </tr>
                  <tr>
                     <th scope="row">이미지</th>
                     <td colspan="3" id="addItem">
                        <div class="sub_img_con">
                        <div class="filebox" style="margin-bottom: 10px;">
                           <input class="upload-name" value="<% if (placeInfo.getPi_img2() == null ) { %>파일 선택<% } else { %><%=placeInfo.getPi_img2() %><% } %>" disabled="disabled">
                           <label for="ex_filename_01">업로드</label>
                           <input type="file" id="ex_filename_01" name="file_path1" class="upload-hidden" onchange="checkSize(this)" value="<%=placeInfo.getPi_img2() %>">
                        </div>
                        <div class="filebox" style="margin-bottom: 10px;">
                           <input class="upload-name" value="<% if (placeInfo.getPi_img3() == null ) { %>파일 선택<% } else { %><%=placeInfo.getPi_img3() %><% } %>" disabled="disabled">
                           <label for="ex_filename_02">업로드</label>
                           <input type="file" id="ex_filename_02" name="file_path2" class="upload-hidden" onchange="checkSize(this)" value="<%=placeInfo.getPi_img3() %>">
                        </div>
                        <div class="filebox" style="margin-bottom: 10px;">
                           <input class="upload-name" value="<% if (placeInfo.getPi_img4() == null ) { %>파일 선택<% } else { %><%=placeInfo.getPi_img4() %><% } %>" disabled="disabled">
                           <label for="ex_filename_03">업로드</label>
                           <input type="file" id="ex_filename_03" name="file_path3" class="upload-hidden" onchange="checkSize(this)" value="<%=placeInfo.getPi_img4() %>">
                        </div>
                        <div class="filebox" style="margin-bottom: 10px;">
                           <input class="upload-name" value="<% if (placeInfo.getPi_img5() == null ) { %>파일 선택<% } else { %><%=placeInfo.getPi_img5() %><% } %>" disabled="disabled">
                           <label for="ex_filename_04">업로드</label>
                           <input type="file" id="ex_filename_04" name="file_path4" class="upload-hidden" onchange="checkSize(this)" value="<%=placeInfo.getPi_img5() %>">
                        </div>
                        </div>
                     </td>
                  </tr>
                  </tbody>
               </table>
            </div>
            <div class="confirm">
               <input type="button" value="취소" class="place_02_btn1" onclick="location.href='./place_list.jsp'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <input type="submit" value="확인" class="place_02_btn2" style="cursor: pointer;">
            </div>
         </form>
      </div>
   </div>
</body>
</html>