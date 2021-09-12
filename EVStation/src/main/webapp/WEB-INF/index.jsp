<%@ page contentType="text/html; charset=UTF-8" %>
<%
	String memnum ="17";
	session.setAttribute("memnum", memnum);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<style>
@media ( min-width : 768px) {
	.container {
		width: 750px
	}
}

@media ( min-width : 992px) {
	.container {
		width: 940px
	}
}

a {
	text-decoration-line: none;
}

#alarmpage {
	position :absolute;
	border: solid black 1px;
	width : 210px;
	height : 300px;
	left : 1230px;
}

</style>
</head>
<body>
	<div class="container">
		<header class="py-3">
			<div class="row justify-content-center  ">

				<div class="col-6 pt-2">
		  	<a href="/" class="link-secondary"> <img src="/img/logo.png"
						width="200" height="100">
					</a>
					<!--  <a class="link-secondary" href="#">Subscribe</a> -->
				</div>

				<div class="col-6 d-flex-column-reverse justify-content-end align-items-center">
					<!-- justify-content 자식요소 정렬  -->
					<div id="login" style="text-align:right;margin-bottom:10px;"><img style="cursor:pointer;"src="/img/alarm1.png"
						width="30" height="30" onclick="ring(${memnum})">
					</div>
					<div style="float:right;">
						
						<a class="btn btn-sm btn-outline-success" href="/DsAlarm">로그인</a> <a
							class="btn btn-sm btn-outline-success" href="#">회원가입</a>
					</div>
				</div>

			</div>
		

		<div class="menubar py-1 mb-2">
			<nav
				class="nav d-flex justify-content-center border-top border-bottom">
				<a class="p-2  link-success" href="#">페이지 소개</a> <a
					class="p-2 link-success" href="reviewList">충전소 현황</a> <a
					class="p-2 link-success" href="#">기대효과</a> <a
					class="p-2 link-success" href="#">자유게시판</a> <a
					class="p-2 link-success" href="#">공지사항</a> <a
					class="p-2 link-success" href="/qnaList">Q&A</a>
			</nav>
		</div>
		</header>
	</div>


	<main>
		<div class="container input-group d-flex justify-content-center">
			
			<div class="w-100 input-group">
					<span class="input-group-text"> <svg xmlns="http://www.w3.org/2000/svg" width="16"
							height="16" fill="currentColor" class="bi bi-search"
							viewBox="0 0 16 16"><path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
		</svg></span> <input type="text" class="form-control" id="search1"
						placeholder="충전소명을 입력하세요">
			</div>
		
		<div id="map" class="m-3" style="width:500px;height:400px;"></div>
		</div>
	</main>



	<footer
		class="container-fluid my-3 d-flex justify-content-center align-items-center border-top"
		style="height: 100px;">

		<div class="row">
			<div class="col-12 pt-3">
				<p>
					Project built for <a href="#">Portfolio</a> by <a href="#">Team
						2</a>.
				</p>
				<p>Copyright @ 2021 EvStation</p>
			</div>
		</div>

	</footer>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1b85cb3c2a7f14edb22d60f2c53b0e10"></script>
		<script>
			var container = document.getElementById('map');
			var options = {
				center: new kakao.maps.LatLng(33.450701, 126.570667),
					level: 3
			};
		var map = new kakao.maps.Map(container, options);
		</script>
		<script>
		$(function(){
			$.ajax({
				type : "get",
				url : "countAlarm",
				data : { "memnum" : ${memnum}},
				dataType : "text"
			}).done(function(data){
				//alert(data)
			}).fail(function(e){
				alert("실패")
				alert(e.responseText)				
			})
		
		})
		
		function ring(x){ //알람 창 열고 데이터 가져오는 함수
			//alert(${memnum})
			$.ajax({
				type : "get",
				url : "/getAlarm",
				data : {"memnum" : ${memnum}},
				dataType : "text"
			}).done(function(data){
				//alert("성공")
				if($('#alarmpage').html()){
					$('#alarmpage').remove();
				}else{
					$('#login').append("<div id='alarmpage'></div>"	);
					$('#alarmpage').html(data) //alarmpage에 따로만든 jsp파일넣기
				}
			}).fail(function(e){
				alert("실패")
				alert(e.responseText);
			})
		}
		function delAlarm(x){
			let alanum = x;
			$.ajax({
				type : "get",
				url : "/delAlarm",
				data : {"alanum" : alanum},
				dataType : "text"
			}).done(function(data){
				//alert(data)
				$('#'+alanum).remove();
			}).fail(function(e){
				alert("실패")
				alert(e.responseText);
			})
		}
		</script>
</body>

</html>