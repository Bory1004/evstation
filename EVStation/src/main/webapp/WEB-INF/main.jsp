<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session = "true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<style>
@media ( min-width : 768px) {
	.container {
		width: 750px
	}
}
@media ( min-width : 992px) {
	.container {
		width: 840px
	}
}
a {
	text-decoration-line: none;
}
#ad {
	position : relative;
	width : 200px;
	height : 200px;
	right : 185px;
	bottom : 470px; 
	text-align : center;
	vertical-align : middle;
}
#alarmpage {
	position :absolute;
	border: solid #BDBDBD 1px;
	border-radius: 20px;
	width : 230px;
	height : 300px;
	left : 1230px;
	padding : 10px;
	overflow-y : auto;
}
#alarmcount {
	position : relative;
	width : 30px;
	height : 20px;
	left : 380px;
	top : 10px; 
	border-radius: 10px;
	text-align : center;
	vertical-align : middle;
}
#alarmcount > span {
	position :relative;
	color : white;
	bottom : 3px;
	left : 1700px;
	top : 200px;
	width : 300px;
	height : 400px;
}
</style>
</head>
<body>
	<div class="container">
		<header class="py-3">
			<div class="row justify-content-center">
				<div class="col-6 pt-2">
					<a href="/main" class="link-secondary"> 
					<img src="/img/logo.png" width="220" height="100"></a>
					<!--  <a class="link-secondary" href="#">Subscribe</a> -->
				</div>

				<div class="col-6 d-flex-column-reverse justify-content-end align-items-center">
					<!-- justify-content 자식요소 정렬  -->
													
					<c:choose>
						<c:when test="${member.id eq null}">
							<div style="float:right;">
								<a class="btn btn-sm btn-outline-success" href="/loginView">로그인</a> 
								<a class="btn btn-sm btn-outline-success" href="/joinView">회원가입</a>
							</div>	
						</c:when>
						<c:otherwise>
							<div id="login" style="text-align:right;margin-bottom:10px;"><div id="alarmcount"></div><img style="cursor:pointer;"src="/img/alarm1.png"
							width="30" height="30" onclick="ring(${member.memnum})">
							</div>
							<div style="float:right;"><img src="${member.memphoto}" width="45" height="30">${member.name}(${member.id})님 환영합니다!! <a class="btn btn-sm btn-outline-success" href="/logout">로그아웃</a></div>
						</c:otherwise>						
					</c:choose>
				</div>
			</div>

			<div class="menubar py-1 mb-2">
				<nav class="nav d-flex justify-content-center border-top border-bottom">
					<a class="p-2  link-success" href="/pageIntro">페이지 소개</a> 
					<a class="p-2 link-success" href="/getChargeList">충전소 현황</a> 
					<a class="p-2 link-success" href="/benefit">기대효과</a> 
					<a class="p-2 link-success" href="/getFreeBoardList">자유게시판</a> 
					<a class="p-2 link-success" href="/ay/getBoardList">공지사항</a> 
					<a class="p-2 link-success" href="/qnaList">Q&A</a>
				</nav>
			</div>
		</header>
	</div>

	<main>
		<div class="container">
			<div class="row">
    			<div class="col">
     				 <div class="">
     				 	<div class="w-100 input-group">
     				 		<span class="input-group-text"> 
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
									<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
								</svg>
							</span>
							<input type="text" class="form-control" id="search1" placeholder="충전소명을 입력하세요">
						</div>
						<div id="map" class="m-3" style="width: 800px; height: 400px;"></div>
     				 </div>
   			 	</div>
   			 
     			<div id="ad" class="">
     				<div id="carouselExampleIndicators2" class="carousel slide" data-bs-ride="carousel">
						<div class="carousel-indicators">
							<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
							<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>			
						</div>
						<div class="carousel-inner">
							<div class="carousel-item active">
								<img src="https://image.newsis.com/2021/09/13/NISI20210913_0000827465_web.jpg?rnd=20210913090332" class="d-block w-100" alt="...">
							</div>
							<div class="carousel-item">
								<img src="http://img.electimes.com/upimages/gisaimg/202101/211792.jpg" class="d-block w-100" alt="...">
							</div>		
						</div>
						<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators2" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators2" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span> <span class="visually-hidden">Next</span>
						</button>
					</div>
	
					<div class="col">
     					<div class="">
     						<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
								<div class="carousel-indicators">
									<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
									<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>		
								</div>
								<div class="carousel-inner">
									<div class="carousel-item active">
										<img src="/img/recom1.png" class="d-block w-100" alt="...">
									</div>
									<div class="carousel-item">
										<img src="/img/recom2.png" class="d-block w-100" alt="...">
									</div>			
								</div>
								<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
									<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span class="visually-hidden">Previous</span>
								</button>
								<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
									<span class="carousel-control-next-icon" aria-hidden="true"></span> <span class="visually-hidden">Next</span>
								</button>
							</div>
     					</div>
    				</div>
   				</div>   			 
  			</div>
		</div>		
	</main>

	<footer class="container-fluid my-3 d-flex justify-content-center align-items-center border-top fixed-bottom" style="height: 100px;">
		<div class="row">
			<div class="col-12 pt-3">
				<p>Project built for <a href="#">Portfolio</a> by <a href="#">Team2</a>.</p>
				<p>Copyright @ 2021 EvStation</p>
			</div>
		</div>
	</footer>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<jsp:include page="/WEB-INF/kwboard/openMap.jsp" />
	
<!-- 	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1b85cb3c2a7f14edb22d60f2c53b0e10"></script>
	<script>
		var container = document.getElementById('map');
		var options = { center: new kakao.maps.LatLng(33.450701, 126.570667), level: 3};
		var map = new kakao.maps.Map(container, options);
	</script> -->
	<script>
		$(function(){
			$.ajax({
				type : "get",
				url : "/countAlarm",
				data : { "memnum" : ${member.memnum}},
				dataType : "text"
			}).done(function(data){
				//alert(data)
				if(data != ""){
					$('#alarmcount').css('background','#41FF3A')
					$('#alarmcount').html('<span>'+data+'</span>');
				}
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
				data : {"memnum" : ${member.memnum}},
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
			let memnum = '${member.memnum}'
			$.ajax({
				type : "get",
				url : "/delAlarm",
				data : {"alanum" : alanum , "memnum" : memnum},
				dataType : "text"
			}).done(function(data){
				//alert(data)
				$('#'+alanum).remove();
				$('#alarmcount').html('<span>'+data+'</span>');
				
				if (data == "" ){
					$('#alarmcount').css('background','white')
				}
			}).fail(function(e){
				alert("실패")
				alert(e.responseText);
			})
		}
		function checkAlarm(x){
			let alanum = x;
			$.ajax({
				type : "get",
				url : "/checkAlarm",
				data : {"alanum" : alanum},
				dataType : "text"
			}).done(function(data){
				alert(data)
				//$('#'+alanum).children().eq(1).children().eq(0).css("color","red");
			}).fail(function(e){
				alert("실패")
				alert(e.responseText)
			})
		}
		
		</script>
</body>

</html>