// 일정 보기관련 스크립트

function enterkey(searchKeyword) {
	if (window.event.keyCode == 13) {
		placeSearchChange(searchKeyword);
    }
}

function placeCategoryChange(placeCategory, viewDayNum) {
// 카테고리 변경
	$.ajax({
		type : "POST",
		url : "/traverSite/placeList",
		data : {
			"placeCategory" : placeCategory,
			"viewDayNum" : viewDayNum,
		},
		success : function(placeList) {
			if (placeList.size() == 0) {
				alert("카테고리 변경에 실패했습니다.\n다시 시도하세요.");
			}
		}
	});
}

function placeSearchChange(searchKeyword, viewDayNum) {
// 검색어로 장소 리스트 변경
	$.ajax({
		type : "POST",
		url : "/traverSite/placeList",
		data : {
			"searchKeyword" : searchKeyword,
			"viewDayNum" : viewDayNum,
		},
		success : function(placeList) {
			if (placeList.size() == 0) {
				alert("검색에 실패했습니다.\n다시 시도하세요.");
			}
		}
	});
}


