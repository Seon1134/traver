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

function scheduleSelect(selectDay, selectDate, dateList) {
	sessionStorage.setItem("selectDay", selectDay);	// '자바스크립트 세션'에 현재 Day값 저장
	sessionStorage.setItem("selectDate", selectDate);	// '자바스크립트 세션'에 현재 선택한 Day의 실제 날짜 저장
	$.ajax({
		type : "POST",
		url : "/traverSite/scheduleSelect",
		data : {
			"selectDay" : selectDay,	// '현재 선택한 일차'
			"selectDate" : selectDate,	// '선택한 일차의 날짜'
			"dateList" : dateList
		},
		success : function(result) {
			if (result == null) {
				alert("일차 등록 실패");
			}
			location.reload();
		}
	})
}


