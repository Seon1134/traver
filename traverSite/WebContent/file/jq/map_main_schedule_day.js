	// 장소추가 관련 ajax 스크립트
	
	window.addEventListener("load", function() {
		let addBtnList = document.querySelectorAll(".place__add"); // 모든 추가 버튼을 가져온다
		for (let i = 0; i < addBtnList.length; i++) {
			let btn = addBtnList.item(i);
			
			btn.addEventListener("click", function(event) { // 모든 '추가' 버튼에 클릭 eventListener 추가
				if (sessionStorage.getItem("selectDay") == null) {
					alert("날짜와 일차를 선택해주세요.");
				} else {
					let place = event.currentTarget; // 이벤트가 발생한 '현재 엘리먼트'을 가져온다
					let piid = place.getAttribute("value");
					let coords = place.getAttribute("data-id");
					let piname = place.parentElement.parentElement.querySelector('.place__title').innerText;
					let sddnum = sessionStorage.getItem("selectDay");
					let sddate = sessionStorage.getItem("selectDate");
					$.ajax({
						type : "POST",
						url : "/traverSite/scheduleDay",
						data : {
							"piid" : piid,
							"coords" : coords,
							"piname" : piname,
							"sddnum" : sddnum,
							"sddate" : sddate
						},
						success : function(result) {
							if (result == 0) {
								alert("하루 장소 추가는 최대 10개까지만 가능합니다");
							}
							location.reload();
						}
					})
				}
			});
		}
	})