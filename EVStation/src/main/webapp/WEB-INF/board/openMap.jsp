<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>마커 표시</title>
    
</head>
<body>
<div id="map" style="width:80%;height:700px;"></div>


<%-- <c:forEach items="${list}" var="list">

<tr>
<td>${list.st_longitude }</td>
<td>${list.st_latitude}</td>
<tr>

</c:forEach> --%>

<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e00d4827b1574ccee07113854385eb3f"></script>
 -->
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
        center: new kakao.maps.LatLng(37.566658, 126.978368), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
 

// 마커를 표시할 위치와 title 객체 배열입니다 
var positions = [

	 <c:forEach items="${list}" var="list">
    {
        title: '${list.st_name}',
        latlng: new kakao.maps.LatLng(${list.st_longitude},${list.st_latitude})
    },

    </c:forEach> 
/*     {
        title: '롯데캐슬블루오션아파트',
        latlng: new kakao.maps.LatLng(35.07284629, 129.073734)
    } */
 /*     {
        title: '생태연못', 
        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
    },
    {
        title: '텃밭', 
        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
    },
     */
];

// 마커 이미지의 이미지 주소입니다
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
    
for (var i = 0; i < positions.length; i ++) {
    
    // 마커 이미지의 이미지 크기 입니다
    var imageSize = new kakao.maps.Size(24, 35); 
    
    // 마커 이미지를 생성합니다    
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
    
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: positions[i].latlng, // 마커를 표시할 위치
        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        image : markerImage // 마커 이미지 
 
    });
    
}

</script>
</body>
</html>