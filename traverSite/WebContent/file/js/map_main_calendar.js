
function limitDate() { // 시작일자 선택 시 종료일자 컨트롤 활성화
		var sdate = document.getElementById('sdate'); //시작일 컨트롤
		var edate = document.getElementById('edate'); //종료일 컨트롤
		var strDate = sdate.value; //시작일 컨트롤의 value
		var arr1 = strDate.split('-'); //시작일 컨트롤의 value값을  배열로
		var dat1 = new Date(arr1[0], arr1[1] - 1, arr1[2]); //시작일 컨트롤의 date(일)값 (계산을 위해 필요함)
	
		edate.setAttribute("min", strDate); //min값 설정
		var dat2 = new Date(dat1.setDate(dat1.getDate() + 9)); //시작일에서 9일 더한 날짜 Date형 인스턴스 dat2에 저장
		edate.removeAttribute('disabled'); //edate 'disabled' 속성 삭제
	
		var fullEDate = dat2.toLocaleString().substring(0, 12)
				.replaceAll(". ", "-").replace(".", "");
	
		//종료일 스트링형으로 변환
		var date2 = fullEDate.substring(8); //종료일의 date(일)값
		if (date2 < 10) { date2 = "0" + date2; } //date(일) 값이 10보다 작으면 앞에 0붙이기 
	
		edate.setAttribute("max", fullEDate.substring(0, 8) + date2); //max값 설정
		setDay(sdate.value, edate.value, this.form.schedule_day);
	}

	
	function setDay(sdate, edate, target) { // 선택한 날짜를 계산하여 day(일차) select의 option을 변경
		var strDate1 = sdate; // 사용자가 선택한 '일정 시작일'값
		var strDate2 = edate; // 사용자가 선택한 '일정 종료일'값
		var arr1 = strDate1.split('-');
		var arr2 = strDate2.split('-');
		var dat1 = new Date(arr1[0], arr1[1] - 1, arr1[2]); // sdate, edate 모두 계산이 가능한 date값에 담음
		var dat2 = new Date(arr2[0], arr2[1] - 1, arr2[2]);
		var diffDay = (dat2 - dat1) / (24 * 60 * 60 * 1000) + 1;
		// diffDay = '일정의 총 일수' (초단위로 빼서 하루를 기준으로 나눔)
	
		for (var i = target.options.length - 1; i > 0; i--) {
			target.options[i] = null;
		} // 기존 day 삭제
		
		scheduleInfo(strDate1, strDate2, diffDay);
		// 세션에 저장하기위해 필드값들에 현재 구해온 값들을 Ctrl로 넘기는 함수 실행
	}
	
	function getDate(day, sdate) { // '선택한 Day일차', '일정 시작일'
		var arr1 = sdate.split('-');
		var dat1 = new Date(arr1[0], arr1[1] - 1, arr1[2]); // 시작날짜 년,월,일
		var dat2 = new Date(dat1.setDate((dat1.getDate()) + (day - 1))); // 시작날짜의 일 값만 뽑아온다
		// 현재날짜에 '선택한날짜'값을 더하는 것. (당일이라면 0일, 다음날이면 1일 이런식으로.)
		
		var fullEDate = dat2.toLocaleString().substring(0, 12)
				.replaceAll(". ", "-").replace(".", ""); // 선택날짜의 형식을 변환하고, '년,월,일'을 가져온다
		
		let fullEDateArr = fullEDate.split("-"); //0:년도, 1:월, 2:일 배열생성
		var sddate = fullEDateArr[0] + "-"; // retrun 값에 년도 저장 
		
		if (fullEDateArr[1] < 10) { // 10월 이상 +0월
			sddate += "0" + fullEDateArr[1] + "-"
		} else { // 10월 미만 +월
			sddate += fullEDateArr[1] + "-"
		}
		
		if (fullEDateArr[2] < 10) { // 10일 이상 +0일
			sddate += "0" + fullEDateArr[2]
		} else { // 10일 미만 +일
			sddate += fullEDateArr[2]
		}



		let dateList = ""; // 모든 일차의 date값을 저장할 string 변수
		for (let i = 0 ; i < 10 ; i++) { // 최대일차인 10일까지 돌린다 (값 받아오기 귀찮.)
			let dat3 = new Date(arr1[0], arr1[1] - 1, arr1[2]); // 시작날짜 년,월,일 (2)
			let dat4 = new Date(dat3.setDate(dat3.getDate() + i)); // 시작날짜에 [i]일을 더한 값. (n일차의 날짜)
			let fullDate =  dat4.toLocaleString().substring(0, 12).replaceAll(". ", "-").replace(".", "");
			// 시작날짜 '년,월,일'에서 .을 -로 바꾸고 . 삭제

			let dateArr = fullDate.split("-"); // 0:년도, 1:월, 2:일 배열생성
			dateList += "," + dateArr[0] + "-"; //date값에 쉼표 + 년도 넣기 
			
			if (dateArr[1] < 10) { // 10월 이상 +0월
				dateList += "0" + dateArr[1] + "-";
			} else { // 10월 미만 +월
				dateList += dateArr[1] + "-";
			}
			
			if (dateArr[2] < 10) { // 10일 이상 +0일
				dateList += "0" + dateArr[2];
			} else { // 10일 미만 +일
				dateList += dateArr[2];
			}
		}
		
		scheduleSelect(day, sddate, dateList);
		
		return sddate;
		// Day에 해당하는 날짜
	}
