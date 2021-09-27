<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="/WEB-INF/layout/HeaderCharge.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style>
#center {
	width: 880px;
	margin-left: auto;
	margin-right: auto;
}
a {
	text-decoration-line: none;
}

</style>
<meta charset="UTF-8">
<title>충전소 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

<div id="center">
	 	<h2>${stname}(수정페이지)</h2>
	 	<a class="text-muted" href="/getChargeList">>>충전소 전체 목록 이동 </a>
	 	
	 <div class="row" >
	 		 	<div class="col-md-7" > 
	 	
	 			<form action="/updateChargeComplete" method="post" >
	 				<input type="hidden" name="stnum" value="${stnum}">
	 				<input type="hidden" name="stname" value="${stname}">
	 				<input type="hidden" name="stlatitude" value="${stlatitude}">
	 				<input type="hidden" name="stlongitude" value="${stlongitude}">
	 				
	 	
	 	<table class="table table-bordered border-secondary"   style="width: 500px;" >
	<%-- <tr><td class="table-secondary text-center">충전소이름</td><td>${charge.st_name }</td></tr> --%>
	<tr><td class="table-secondary text-center">주소(도로명)</td><td><input class="form-control" name="staddress1" id="staddress1" value="${staddress1}" ></td></tr>
	<tr><td class="table-secondary text-center">주소(지번)</td><td><input class="form-control" name="staddress2" id="staddress2" value="${staddress2}" ></td></tr>
	<tr><td class="table-secondary text-center">휴무일</td><td><input class="form-control" name="stclosedday" id="stclosedday" value="${stclosedday}" ></td></tr>
	<tr><td class="table-secondary text-center">완속충전</td><td><input class="form-control" name="stslowcharge" id="stslowcharge" value="${stslowcharge}" ></td></tr>
	<tr><td class="table-secondary text-center">완속충전대수</td><td><input class="form-control" name="stslowcharge_num" id="stslowcharge_num" value="${stslowcharge_num}" ></td></tr>
	<tr><td class="table-secondary text-center">급속충전</td><td><input class="form-control" name="stfastcharge" id="stfastcharge" value="${stfastcharge}" ></td></tr>
	<tr><td class="table-secondary text-center">급속충전대수</td><td><input class="form-control" name="stfastcharge_num" id="stfastcharge_num" value="${stfastcharge_num}" ></td></tr>
	<tr><td class="table-secondary text-center">충전타입</td><td><input class="form-control" name="stfastcharge_type" id="stfastcharge_type" value="${stfastcharge_type}" ></td></tr>
	<tr><td class="table-secondary text-center">오픈</td><td><input class="form-control" name="sttime" id="sttime" value="${sttime}" ></td></tr>
	<tr><td class="table-secondary text-center">마감</td><td><input class="form-control" name="stclosetime" id="stclosetime" value="${stclosetime}" ></td></tr>
	<tr><td class="table-secondary text-center">주차료</td><td><input class="form-control" name="stpark" id="stpark" value="${stpark}" ></td></tr>
	<tr><td class="table-secondary text-center">재공기관</td><td><input class="form-control" name="stagency" id="stagency" value="${stagency}" ></td></tr>
</table>
<div style="text-align:center;">
<input class="btn btn-outline-secondary" type="submit" id="savebutton" value="수정완료">
</div>
	</form>
		 	</div>
	
		<div class="col-5 col-md-5" id="map" style="width:200; height:300;">" "</div>
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
        center: new kakao.maps.LatLng(${stlongitude}, ${stlatitude}), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 

var markerPosition  = new kakao.maps.LatLng(${stlongitude}, ${stlatitude}); 

var marker = new kakao.maps.Marker({
    position: markerPosition
});

marker.setMap(map);
</script>
<%@ include file="/WEB-INF/layout/Footer.jsp"%>
</body>
</html>