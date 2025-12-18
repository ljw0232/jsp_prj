<%@page import="java.util.List"%>
<%@page import="kr.co.sist.map.RestaurantDTO"%>
<%@page import="kr.co.sist.map.RestaurantService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ include file = "../fragments/siteProperty.jsp" %>
<%@ include file = "../fragments/loginChk2.jsp" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<title>등록 위치보기</title>

<link rel="shortcut icon" href="${CommonURL}/common/images/favicon.ico">

<script src="${CommonURL}/common/js/color-modes.js"></script>
<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

<meta name="theme-color" content="#712cf9">
<link href="${CommonURL}/common/css/carousel.css" rel="stylesheet">
<jsp:include page = "../fragments/bootstrap_css.jsp"/>
<style type = "text/css">
#wrap{margin: 0px auto; width: 1200px; height: 1000px;}
#header{height: 150px;}
#container{height: 700px;}
#footer{height: 150px;}
</style>
<!-- jQuery CDN 시작 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	$("#btnAdd").click(function() {
		location.href = "addMap.jsp";
	});
}); // ready

</script>
<!-- 다음 지도 API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f5b3e54574c9bac9487674055be164b"></script>
<script>

var map = null;
var markerPosition = null;
var marker = null;
var infowindow = null;

window.onload = function() {
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.504631601190916, 127.05318085017718), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

	map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	//HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
	if (navigator.geolocation) {
	    
	    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
	    navigator.geolocation.getCurrentPosition(function(position) {
	        
	        var lat = position.coords.latitude, // 위도
	            lon = position.coords.longitude; // 경도
	        
	        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
	            message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다
	        
	        // 마커와 인포윈도우를 표시합니다
	        displayMarker(locPosition, message);
	            
	      });
	    
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
	    
	    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
	        message = 'geolocation을 사용할수 없어요..'
	        
	    displayMarker(locPosition, message);
	}

} // onload

function displayMarker(locPosition, message) {

    if(infowindow != null) {
    	infowindow.close();
    } // end if

    // 마커를 생성합니다
	marker = new kakao.maps.Marker({  
		map: map, 
		position: locPosition
    }); 
    
    var iwContent = message, // 인포윈도우에 표시할 내용
        iwRemoveable = true;

    // 인포윈도우를 생성합니다
    infowindow = new kakao.maps.InfoWindow({
        content : iwContent,
        removable : iwRemoveable
    });
    
    // 인포윈도우를 마커위에 표시합니다 
    infowindow.open(map, marker);
    
    // 지도 중심좌표를 접속위치로 변경합니다
    map.setCenter(locPosition);
}


function viewRestaurant(lat, lng, msg) {
	/* 
	setCenter(lat, lng); // 중심좌표의 이동
	panTo(lat, lng); // 부드럽게 이동
	setMarker(lat, lng);
	*/
	
    var locPosition = new kakao.maps.LatLng(lat, lng), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
    message = '<div style="padding:5px;">' + msg + '</div>'; // 인포윈도우에 표시될 내용입니다
    
    marker.setMap(null);
    
	// 마커와 인포윈도우를 표시합니다
	displayMarker(locPosition, message);
	
	
} // viewRestaurant

function setCenter(lat, lng) {            
	// 이동할 위도 경도 위치를 생성합니다 
	var moveLatLon = new kakao.maps.LatLng(lat, lng);
	
	// 지도 중심을 이동 시킵니다
	map.setCenter(moveLatLon);
}

function panTo(lat, lng) {
	// 이동할 위도 경도 위치를 생성합니다 
	var moveLatLon = new kakao.maps.LatLng(lat, lng);
	
	// 지도 중심을 부드럽게 이동시킵니다
	// 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
	map.panTo(moveLatLon);            
}

function setMarker(lat, lng) {
	// 마커가 표시될 위치입니다 
	markerPosition  = new kakao.maps.LatLng(lat, lng); 

	// 마커를 생성합니다
	marker = new kakao.maps.Marker({
	    position: markerPosition
	});

	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
}

</script>
</head>
<body>
	<header data-bs-theme="light">
		<jsp:include page = "../fragments/header.jsp"/>		
	</header>
	<main>
		<jsp:include page = "../fragments/carousel.jsp"/>
		<!-- Marketing messaging and featurettes
  ================================================== -->
		<!-- Wrap the rest of the page in another container to center all the content. -->
		<div class="container marketing">
			<!-- Three columns of text below the carousel -->
			<!-- /.row -->
			<!-- START THE FEATURETTES -->
			<hr class="featurette-divider">
			<div class="row featurette">
				<div>
				<h2>식당 리스트</h2>
				<input type = "button" value = "식당등록" class = "btn btn-info btn-sm" id = "btnAdd"/>
				<div id="map" style="width:100%;height:450px;"></div>
				<div>
				<%
				RestaurantService rs = RestaurantService.getInstance();
				String id = (String)session.getAttribute("userId");
				List<RestaurantDTO> list = rs.searchRestaurant(id);
				pageContext.setAttribute("restList", list);
				%>
				<table class = "table table-hover">
				<thead>
				<tr>
				<th>번호</th>
				<th>식당명</th>
				<th>주 메뉴</th>
				<th>입력일</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var = "rDTO" items = "${restList}" varStatus = "i">
				<tr>
				<td><c:out value = "${i.count}"/></td>
				<td><c:out value = "${rDTO.rest_name}"/></td>
				<td><c:out value = "${rDTO.menu}"/></td>
				<td><c:out value = "${rDTO.input_date}"/></td>
				<td><input type = "button" value = "보기" class = "btn btn-info btn-sm" onclick = "viewRestaurant(${rDTO.lat}, ${rDTO.lng}, '${rDTO.rest_name}')"/></td>
				</tr>
				</c:forEach>
				</tbody>
				</table>
				</div>
				
				</div>
			</div>
			<hr class="featurette-divider">
			<!-- /END THE FEATURETTES -->
		</div>
		<!-- /.container -->
		<!-- FOOTER -->
		<footer class="container">
			<jsp:include page = "../fragments/footer.jsp"/>	
		</footer>
	</main>
	
</body>
</html>