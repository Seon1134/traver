<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>

<!-- 리뷰 보기 -->
<div class="place_review_box review_view_box display_none">
	<img src="/traverSite/file/img/x.png" class="review_x">
	<div class="place_review_title_box">
		<span class="place_review_title">전체 리뷰 수 : 14개</span>
	<% if(isLogin) { %>
		<button class="review_add">리뷰 쓰기</button>
	<% } %>
	</div>
	<div class="place_review_item_box">
		<div class="review_item">
			<div class="review_info clearfix">
				<span>홍 | 2022-09-12</span>
				<div class="review_option_box">
				<% if(isLogin) { %>
					<a href="#" class="review_option">수정</a>
					<a href="#" class="review_option">삭제</a>
					<a href="#" class="review_option">신고</a>
				<% } %>
				</div>
			</div>
			<div class="review_img_box">
				<img src="/traverSite/file/img/silla1.jpg" alt="" class="review__img" />
				<img src="/traverSite/file/img/silla2.jpg" alt="" class="review__img" />
				<img src="/traverSite/file/img/silla3.jpg" alt="" class="review__img" />
				<img src="/traverSite/file/img/silla4.jpg" alt="" class="review__img" />
			</div>
			<div class="review_content">
				<span>여기 정말 사진 그대로에요. 완전 예쁩니다. 강추!!</span>
			</div>
		</div>
		<div class="review_item">
			<div class="review_info clearfix">
				<span>민지 | 2022-10-18</span>
				<div class="review_option_box">
				<% if(isLogin) { %>
					<a href="#" class="review_option">수정</a>
					<a href="#" class="review_option">삭제</a>
					<a href="#" class="review_option">신고</a>
				<% } %>
				</div>
			</div>
			<div class="review_content">
				<span>여기서 서비스로 라면도 주는데, 맛있어요.ㅋㅋㅋㅋ 공기도 맑고 분위기도 좋아서 건강해지는 기분이에요. 호캉스 생각하시면 무조건 이쪽으로 고고!</span>
			</div>
		</div>
		<div class="review_item">
			<div class="review_info clearfix">
				<span>세아 | 2022-10-22</span>
				<div class="review_option_box">
				<% if(isLogin) { %>
					<a href="#" class="review_option">수정</a>
					<a href="#" class="review_option">삭제</a>
					<a href="#" class="review_option">신고</a>
				<% } %>
				</div>
			</div>
			<div class="review_content">
				<span>예쁩니다. 추천.</span>
			</div>
		</div>
		<div class="review_item">
			<div class="review_info clearfix">
				<span>정훈 | 2022-11-30</span>
				<div class="review_option_box">
				<% if(isLogin) { %>
					<a href="#" class="review_option">수정</a>
					<a href="#" class="review_option">삭제</a>
					<a href="#" class="review_option">신고</a>
				<% } %>
				</div>
			</div>
			<div class="review_content">
				<span>여기 와보셨나요??? 진짜 최고에요! 제발 한번씩만 와주세요</span>
			</div>
		</div>
		<div class="review_item">
			<div class="review_info clearfix">
				<span>지나가는사람 | 2022-12-02</span>
				<div class="review_option_box">
				<% if(isLogin) { %>
					<a href="#" class="review_option">수정</a>
					<a href="#" class="review_option">삭제</a>
					<a href="#" class="review_option">신고</a>
				<% } %>
				</div>
			</div>
				<div class="review_img_box">
				<img src="/traverSite/file/img/silla4.jpg" alt="" class="review__img" />
			</div>
			<div class="review_content">
				<span>사진이랑 비슷하긴한데.. 그냥 그래요.</span>
			</div>
		</div>
	</div>
</div>
