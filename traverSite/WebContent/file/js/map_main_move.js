window.onload = function(){
	const goMap = document.querySelector('.go_map'); 
	const goSchedule = document.querySelector('.go_schedule');	
	const scheduleBox = document.querySelector('.go_schedule_area_box');
	
	const placeInfoOpenList = document.querySelectorAll('.place__info');
	const placeInfoCloseList = document.querySelectorAll('.place_x');
	const placeInfoBox = document.querySelector('#place_info_box');
	

	
	const reviewViewOpenList = document.querySelectorAll('.place__review');
	const reviewAddOpenList = document.querySelectorAll('.review_add');
	const reviewAddBackList = document.querySelectorAll('.review_add_back');
	const reviewCloseList = document.querySelectorAll('.review_x');
	const reviewViewBox = document.querySelector('.review_view_box');
	const reviewAddBox = document.querySelector('.review_add_box');
	
	// 지도로 돌아가기를 누르면 디스플레이 끄기 클래스 추가 
	goMap.addEventListener('click', function() {
		scheduleBox.classList.add('display_none');
	});
	
	// 내 일정보기를 누르면 디스플레이 끄기 클래스 삭제
	goSchedule.addEventListener('click', function() {
		scheduleBox.classList.remove('display_none');
	});
	
	for (let i = 0; i < placeInfoOpenList.length; i++) {
		// 장소 정보 버튼을 누르면 디스플레이 클래스 삭제 (보이기)
		placeInfoOpenList[i].addEventListener('click', function() {
			placeInfoBox.classList.remove('display_none');
		});
		
		// 장소 보기창 - x버튼을 누르면 디스플레이 클래스 추가 (가리기)
		placeInfoCloseList[i].addEventListener('click', function() {
			placeInfoBox.classList.add('display_none');
		});
		
		
	
		// 장소 리뷰 버튼 누르면 디스플레이 보이기 (리뷰보기 띄우기)
		reviewViewOpenList[i].addEventListener('click', function() {
			reviewViewBox.classList.remove('display_none');
		});
		
		// 리뷰추가 버튼 - 리뷰 display 없애기, 리뷰add 띄우기 (리뷰보기 -> 리뷰작성 화면으로)
		reviewAddOpenList[i].addEventListener('click', function() {
			reviewViewBox.classList.add('display_none');
			reviewAddBox.classList.remove('display_none');
			
		});
		
		// 작성취소 버튼 - 리뷰작성 display없애기, 리뷰 view 띄우기 (리뷰 작성->보기화면으로)
		reviewAddBackList[i].addEventListener('click', function() {
			reviewViewBox.classList.remove('display_none');
			reviewAddBox.classList.add('display_none');
		});
		
		// 리뷰 x버튼을 누르면 디스플레이 클래스 추가 (리뷰보기/작성 없애기)
		reviewCloseList[i].addEventListener('click', function() {
			reviewViewBox.classList.add('display_none');
			reviewAddBox.classList.add('display_none');
		});
	}
	
	$( function() {
		$( ".schedule-list" ).sortable();
		// 스케줄 드래그앤 드롭 함수
	} );
	
	function scheDel() {
		alert('일정 삭제 이벤트 발생');
		// 스케줄 삭제 X버튼 함수
	}
	function scheAllDel() {
		alert('일차 전체 삭제 이벤트 발생');
		// Day 일차 전체삭제 버튼 함수
	}

	function schDel() {
		alert('검색어 삭제 이벤트 발생');
		// 검색어 삭제 X버튼 함수
	}
	function test() {
		alert('버튼 동작 확인!');
	}
    function swapImg(img) {
		var big = document.getElementById("placeimg");
		big.src = "../../file/img/" + img;
	}

}