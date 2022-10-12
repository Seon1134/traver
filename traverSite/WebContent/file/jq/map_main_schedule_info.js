/**
 * 
 */


function scheduleInfo (sisdate, siedate, sidnum) {
	$.ajax({
		type : "POST",
		url : "/traverSite/scheduleInfo",
		data : {
			"sisdate" : sisdate,	//시작날짜
			"siedate" : siedate,	//종료날짜
			"sidnum" : sidnum	//총 일수
		},
		success : function(result) {
			if (result == 0) {
				alert("일차 등록 실패");
			}
			location.reload();
		}
	})	
}


function scheduleSelect (sddnum, sddate) {
	$.ajax({
		type : "POST",
		url : "/traverSite/scheduleSelect",
		data : {
			"sddnum" : sddnum,	// '현재 선택한 일차'
			"sddate" : sddate	// '선택한 일차의 날짜'
		},
		success : function(result) {
			if (result == null) {
				alert("일차 등록 실패");
			}
			location.reload();
		}
	})	
}


