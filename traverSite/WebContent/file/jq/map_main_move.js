$(document).ready(function () {
	$(".left_open").click(function(){
		$(".left-side").toggleClass("open"); 
		// main_left_side 열렸다 닫혔다 번갈아가며 실행
          
		if($(".left-side").hasClass("open")) {
		// 메뉴 닫겨있으면 열기
			$(".left__side__open_img").attr("src", "/traverSite/file/img/left_side_close.png");
            $(".left-side").animate({left:0}, 300)
            $(".main-top_area").animate({left:"300px"}, 300)
        } else {
        // 열려있으면 닫기
            $(".left__side__open_img").attr("src", "/traverSite/file/img/left_side_open.png");
            $(".left-side").animate({left:"-273px"}, 300)
            $(".main-top_area").animate({left:"20px"}, 300)
        }
    })
	$(".right_open").click(function(){
        $(".right-side").toggleClass("open"); 
        // main_left_side 열렸다 닫혔다 번갈아가며 실행
          
        if($(".right-side").hasClass("open")) {
        // 메뉴 닫겨있으면 열기
            $(".right__side__open_img").attr("src", "/traverSite/file/img/right_side_close.png");
            $(".right-side").animate({right:0}, 300)
            
        } else {
        // 열려있으면 닫기
            $(".right__side__open_img").attr("src", "/traverSite/file/img/right_side_open.png");
            $(".right-side").animate({right:"-291px"}, 300)
        }
    })
})