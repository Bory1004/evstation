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
<div id="map" style="width:90%;height:700px;"></div>


<script>
window.kakao=window.kakao||{},window.kakao.maps=window.kakao.maps||{},window.daum&&window.daum.maps?window.kakao.maps=window.daum.maps:(window.daum=window.daum||{},window.daum.maps=window.kakao.maps),function(){function a(){if(E.length){t(I[E.shift()],a).start()}else e()}function t(a,t){var e=document.createElement("script");return e.charset="utf-8",e.onload=t,e.onreadystatechange=function(){/loaded|complete/.test(this.readyState)&&t()},{start:function(){e.src=a||"",
	document.getElementsByTagName("head")[0].appendChild(e),e=null}}}function e(){for(;c[0];)c.shift()();o.readyState=2}var o=kakao.maps=kakao.maps||{};if(void 0===o.readyState)o.onloadcallbacks=[],o.readyState=0;else if(2===o.readyState)return;o.VERSION={ROADMAP:"2106wof",ROADMAP_SUFFIX:"",HYBRID:"2106wof",SR:"3.00",ROADVIEW:"7.00",ROADVIEW_FLASH:"200402",BICYCLE:"6.00",USE_DISTRICT:"2106wof",
	SKYVIEW_VERSION:"160114",SKYVIEW_HD_VERSION:"160107"},o.RESOURCE_PATH={ROADVIEW_AJAX:"//t1.daumcdn.net/roadviewjscore/core/css3d/200204/standard/1580795088957/roadview.js",ROADVIEW_CSS:"//t1.daumcdn.net/roadviewjscore/core/openapi/standard/210729/roadview.js"};for(var n,r="https:"==location.protocol?"https:":"http:",s="",i=document.getElementsByTagName("script"),d=i.length;n=i[--d];)if(/\/(beta-)?dapi\.kakao\.com\/v2\/maps\/sdk\.js\b/.test(n.src)){s=n.src;break}i=null;var c=o.onloadcallbacks,E=["v3"],S="",I={v3:r+"//t1.daumcdn.net/mapjsapi/js/main/4.4.1/kakao.js",services:r+"//t1.daumcdn.net/mapjsapi/js/libs/services/1.0.2/services.js",
	drawing:r+"//t1.daumcdn.net/mapjsapi/js/libs/drawing/1.2.6/drawing.js",clusterer:r+"//t1.daumcdn.net/mapjsapi/js/libs/clusterer/1.0.9/clusterer.js"},_=function(a){var t={};return a.replace(/[?&]+([^=&]+)=([^&]*)/gi,function(a,e,o){t[e]=o}),t}(s);S=_.appkey,S&&(o.apikey=S),o.version="4.4.1";var R=_.libraries;if(R&&(E=E.concat(R.split(","))),"false"!==_.autoload){for(var d=0,l=E.length;d<l;d++)!function(a){a&&document.write('<script charset="UTF-8" src="'+a+'"><\/script>')}(I[E[d]]);o.readyState=2}o.load=function(t){switch(c.push(t),o.readyState){case 0:o.readyState=1,a();break
	;case 2:e()}}}();
</script>
 
<script>

if (navigator.geolocation) { //GPS 허용 승인하면
	navigator.geolocation.getCurrentPosition((position) => {
		  getLocation(position.coords.latitude, position.coords.longitude);
	});
} else {
	alert('GPS를 지원하지 않습니다');
}
let latitude = null;
let longitude = null;
let map = null;

function getLocation(x, y){
	latitude = x;
	longitude = y;
	console.log(latitude+","+longitude);
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	mapOption = { 
		center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
		level: 3 // 지도의 확대 레벨
	};
	map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다	
	
	var positions = [

		 <c:forEach items="${list}" var="list">
	    {
	    	number: '${list.stnum}',
	        title: '${list.stname}', 
	        latlng: new kakao.maps.LatLng(${list.stlongitude},${list.stlatitude})
	    },

	    </c:forEach> 

	];

	// 마커 이미지의 이미지 주소입니다
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
	    
	for (var i = 0; i < positions.length; i ++) {
		
		  var marker = new kakao.maps.Marker({ 
			  map: map, // 마커를 표시할 지도
		      position: positions[i].latlng

		    });
		  
		marker.setMap(map);
		  
		var iwContent = positions[i].title;
		
		var num = positions[i].number;
		
	    var iwRemoveable = true;
	    
	    // 마커에 표시할 인포윈도우를 생성합니다 
	    var infowindow = new kakao.maps.InfoWindow({
	    	position: positions[i].latlng, 
	        content : '<a href="http://localhost:8088/list/'+num +'" style="text-decoration:none; color:black;" target="_blank">'+iwContent +'</a>',   
	    	removable : iwRemoveable
	    });

		// 마커 클릭이벤트
	    kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker, infowindow));
	    
		// 인포윈도우 생성
	    function makeOverListener(map, marker, infowindow) {
		return function() {
	 	   infowindow.open(map, marker);
			};
		} 

		//인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow) {
		    return function() {
			       infowindow.close();
		   		};
			} 
	    
	}  
}

/* var map;
if (navigator.geolocation) { //GPS 허용 승인하면
	navigator.geolocation.getCurrentPosition(function(position) {
		let latitude = position.coords.latitude;
		let longitude = position.coords.longitude;
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
		mapOption = { 
			center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
			level: 3 // 지도의 확대 레벨
		};
		map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		
		}, function(error) { //GPS 허용을 거부하면 서울 시청 출력
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
		    mapOption = { 
			center: new kakao.maps.LatLng(37.566658, 126.978368), // 지도의 중심좌표
			level: 3 // 지도의 확대 레벨
			};
			map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		//console.error(error);
		}, {
			enableHighAccuracy: false, //배터리를 더 소모해서 더 정확한 위치를 찾음
			maximumAge: 0, //한 번 찾은 위치 정보를 해당 초만큼 캐싱
			timeout: Infinity //주어진 초 안에 찾지 못하면 에러 발생
		});
} else {
	alert('GPS를 지원하지 않습니다');
}
console.log(map); */

// 마커를 표시할 위치와 title 객체 배열입니다 

    
    
</script>
</body>
</html>