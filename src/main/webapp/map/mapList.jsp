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

<link rel="shortcut icon" href="http://192.168.10.70/jsp_prj/common/images/favicon.ico">

<script src="http://192.168.10.70/jsp_prj/common/js/color-modes.js"></script>
<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

<meta name="theme-color" content="#712cf9">
<link href="http://192.168.10.70/jsp_prj/common/css/carousel.css" rel="stylesheet">
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
	
}); // ready

</script>
<!-- 다음 지도 API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f5b3e54574c9bac9487674055be164b"></script>
<script>

var map = null;
var markerPosition = null;
var marker = null;

window.onload = function() {
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.504631601190916, 127.05318085017718), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 마커가 표시될 위치입니다 
markerPosition  = new kakao.maps.LatLng(37.504631601190916, 127.05318085017718); 

// 마커를 생성합니다
marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
// marker.setMap(null);    
} // onload

function viewRestaurant(lat, lng) {
	setCenter(lat, lng); // 중심좌표의 이동
	panTo(lat, lng); // 부드럽게 이동
	setMarker(lat, lng);
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
				<td><input type = "button" value = "보기" class = "btn btn-info btn-sm" onclick = "viewRestaurant(${rDTO.lat}, ${rDTO.lng})"/></td>
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