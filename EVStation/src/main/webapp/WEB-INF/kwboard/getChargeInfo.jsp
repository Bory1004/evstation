<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>충전소목록</title>
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
		width: 940px
	}
}
#center {
	width: 800px;
	margin-left: auto;
	margin-right: auto;
}
a {
	text-decoration-line: none;
}
#page {
	text-align: center;
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

				<div class="col-6 d-flex justify-content-end align-items-center">
					<!-- justify-content 자식요소 정렬  -->
													
					<c:choose>
						<c:when test="${member.id eq null}">
							<div>
								<a class="btn btn-sm btn-outline-success" href="/loginView">로그인</a> 
								<a class="btn btn-sm btn-outline-success" href="/joinView">회원가입</a>
							</div>	
						</c:when>
						<c:otherwise>
							${member.id}님 환영합니다!! <a class="btn btn-sm btn-outline-success" href="logout">로그아웃</a>
						</c:otherwise>						
					</c:choose>
				</div>
			</div>

			<div class="menubar py-1 mb-2">
				<nav class="nav d-flex justify-content-center border-top border-bottom">
					<a class="p-2  link-success" href="#">페이지 소개</a> 
					<a class="p-2 bg-success text-white" href="/getChargeList">충전소 현황</a> 
					<a class="p-2 link-success" href="#">기대효과</a> 
					<a class="p-2 link-success" href="/getFreeBoardList">자유게시판</a> 
					<a class="p-2 link-success" href="#">공지사항</a> 
					<a class="p-2 link-success" href="#">Q&A</a>
				</nav>
			</div>
		</header>
	</div>


<body>
<div class="container">
	<div class="col-xs-12 col-md-12 mb-2" style="text-align: left;">
	
				<h1>${charge.stname }
				<c:if test= "${member.id == null}">
					<img id="h" src="/img/star11.png" width="30px" height="30px" title="nolog">
				</c:if>
					<c:if test= "${member.id != null}">
						<c:if test="${result == 0}">
							<img id="h" src="/img/star11.png" width="30px" height="30px" title="full">
						</c:if>
						<c:if test="${result != 0}">
							<img id="h" src="/img/star22.png" width="30px" height="30px" title="empty">
						</c:if>
					</c:if>	
					</h1>
				</div>
				
	 <div class="row">
	 	<div class="col-md-7"> 
	 		
	 	
	 	<table class="table table-bordered border-secondary" style="width: 500px; margin-right:auto;">
	<%-- <tr><td class="table-secondary text-center">충전소이름</td><td>${charge.st_name }</td></tr> --%>
	<tr><td class="table-secondary text-center">주소(도로명)</td><td>${charge.staddress1 }</td></tr>
	<tr><td class="table-secondary text-center">주소(지번)</td><td>${charge.staddress2 }</td></tr>
	<tr><td class="table-secondary text-center">휴무일</td><td>${charge.stclosedday }</td></tr>
	<tr><td class="table-secondary text-center">완속충전</td><td>${charge.stslowcharge }</td></tr>
	<tr><td class="table-secondary text-center">완속충전대수</td><td>${charge.stslowcharge_num }</td></tr>
	<tr><td class="table-secondary text-center">급속충전</td><td>${charge.stfastcharge }</td></tr>
	<tr><td class="table-secondary text-center">급속충전대수</td><td>${charge.stfastcharge_num}</td></tr>
	<tr><td class="table-secondary text-center">충전타입</td><td>${charge.stfastcharge_type }</td></tr>
	<tr><td class="table-secondary text-center">오픈</td><td>${charge.sttime }</td></tr>
	<tr><td class="table-secondary text-center">마감</td><td>${charge.stclosetime }</td></tr>
	<tr><td class="table-secondary text-center">주차료</td><td>${charge.stpark }</td></tr>
	<tr><td class="table-secondary text-center">재공기관</td><td>${charge.stagency }</td></tr>
</table>
<c:if test="${member.getId()=='admin' }"> 
	<a href="/deleteCharge/${charge.stnum}"><button type="button" class="btn btn-outline-secondary btn-sm">삭제</button></a>
	<a href="/updateCharge/${charge.stnum}/${charge.stname}"><button type="button" class="btn btn-outline-secondary btn-sm">수정</button></a>
</c:if>	 	
	 	</div>
		<div class="col-5 col-md-5" id="map" style="width:200; height:300;">" "</div>
		<div class="col-5 col-md-5">&nbsp;</div>
		
	</div>
</div>
		
<script>
window.kakao=window.kakao||{},window.kakao.maps=window.kakao.maps||{},window.daum&&window.daum.maps?window.kakao.maps=window.daum.maps:(window.daum=window.daum||{},window.daum.maps=window.kakao.maps),function(){function a(){if(E.length){t(I[E.shift()],a).start()}else e()}function t(a,t){var e=document.createElement("script");return e.charset="utf-8",e.onload=t,e.onreadystatechange=function(){/loaded|complete/.test(this.readyState)&&t()},{start:function(){e.src=a||"",
	document.getElementsByTagName("head")[0].appendChild(e),e=null}}}function e(){for(;c[0];)c.shift()();o.readyState=2}var o=kakao.maps=kakao.maps||{};if(void 0===o.readyState)o.onloadcallbacks=[],o.readyState=0;else if(2===o.readyState)return;o.VERSION={ROADMAP:"2106wof",ROADMAP_SUFFIX:"",HYBRID:"2106wof",SR:"3.00",ROADVIEW:"7.00",ROADVIEW_FLASH:"200402",BICYCLE:"6.00",USE_DISTRICT:"2106wof",
	SKYVIEW_VERSION:"160114",SKYVIEW_HD_VERSION:"160107"},o.RESOURCE_PATH={ROADVIEW_AJAX:"//t1.daumcdn.net/roadviewjscore/core/css3d/200204/standard/1580795088957/roadview.js",ROADVIEW_CSS:"//t1.daumcdn.net/roadviewjscore/core/openapi/standard/210729/roadview.js"};for(var n,r="https:"==location.protocol?"https:":"http:",s="",i=document.getElementsByTagName("script"),d=i.length;n=i[--d];)if(/\/(beta-)?dapi\.kakao\.com\/v2\/maps\/sdk\.js\b/.test(n.src)){s=n.src;break}i=null;var c=o.onloadcallbacks,E=["v3"],S="",I={v3:r+"//t1.daumcdn.net/mapjsapi/js/main/4.4.1/kakao.js",services:r+"//t1.daumcdn.net/mapjsapi/js/libs/services/1.0.2/services.js",
	drawing:r+"//t1.daumcdn.net/mapjsapi/js/libs/drawing/1.2.6/drawing.js",clusterer:r+"//t1.daumcdn.net/mapjsapi/js/libs/clusterer/1.0.9/clusterer.js"},_=function(a){var t={};return a.replace(/[?&]+([^=&]+)=([^&]*)/gi,function(a,e,o){t[e]=o}),t}(s);S=_.appkey,S&&(o.apikey=S),o.version="4.4.1";var R=_.libraries;if(R&&(E=E.concat(R.split(","))),"false"!==_.autoload){for(var d=0,l=E.length;d<l;d++)!function(a){a&&document.write('<script charset="UTF-8" src="'+a+'"><\/script>')}(I[E[d]]);o.readyState=2}o.load=function(t){switch(c.push(t),o.readyState){case 0:o.readyState=1,a();break
	;case 2:e()}}}();
</script>

<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(${charge.stlongitude}, ${charge.stlatitude}), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 

var markerPosition  = new kakao.maps.LatLng(${charge.stlongitude}, ${charge.stlatitude}); 

var marker = new kakao.maps.Marker({
    position: markerPosition
});

marker.setMap(map);
</script>

<div style="text-align:center;">
	<a href="/getChargeList"><button type="button" class="btn btn-primary">충전소 목록</button></a>


	<a href="/reviewlist?${charge.stnum }"><button type="button" class="btn btn-primary">리뷰 보기</button></a>
</div>


<footer class="container-fluid my-3 d-flex justify-content-center align-items-center border-top" style="height: 100px;">
		<div class="row">
			<div class="col-12 pt-3">
				<p>Project built for <a href="#">Portfolio</a> by <a href="#">Team2</a>.</p>
				<p>Copyright @ 2021 EvStation</p>
			</div>
		</div>
	</footer>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(function() {
			$("#h").click(function() {
							
								let num = ${charge.stnum};
								let id =  "${member.id}";
									console.log(id);
								let url = "/bookmark/" + num + "/" + id;
								
								$.ajax({
											url : url
										})	
										.done(
												function(data) {
													//history.go(0);
													//alert(data)
													if (document.getElementById("h").getAttribute('src') == '/img/star22.png') {
														document.getElementById("h").src = "/img/star11.png";
													} else {
														document.getElementById("h").src = "/img/star22.png";//.src는 속성값 변경
													}
													$("#recom_div").text(data);//매개변수가 있으니까 변경된 값 가져옴
												}).fail(
												function(jqXHR, textStatus,errorThrown) {
													console.log("error");
												}); 
							
										})//2
		}); 
		</script>
</body>
</html>