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
<title>식당 등록</title>

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
		var rest_name = $("#rest_name").val();
		var param = {
			rest_name: rest_name,
			menu: $("#menu").val(),
			info: $("#info").val(),
			lat: $("#lat").val(),
			lng: $("#lng").val()
		}
		$.ajax({
			url: "addMapProcess.jsp",
			type: "get",
			data: param,
			dataType: "JSON",
			error: function(xhr) {
				alert("식당 등록 실패!!");
				console.log(xhr.status);
			},
			success: function(jsonObj) {
				var msg = rest_name + "등록을 실패하였습니다."
				if(jsonObj.resultFlag) {
					msg = rest_name + "을 성공적으로 추가하였습니다.";
					$("#rest_name").val("");
					$("#menu").val("");
					$("#info").val("");
					$("#lat").val("");
					$("#lng").val("");
					
					$("#vLat").val("");
					$("#vLng").val("");
				} // end if
				alert(msg);
			}
		});
	});
}); // ready

</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f5b3e54574c9bac9487674055be164b"></script>
<script>
window.onload = function() {
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(37.504631601190916, 127.05318085017718), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
	
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	// 지도를 클릭한 위치에 표출할 마커입니다
	var marker = new kakao.maps.Marker({ 
	    // 지도 중심좌표에 마커를 생성합니다 
	    position: map.getCenter() 
	}); 
	// 지도에 마커를 표시합니다
	marker.setMap(map);
	
	// 지도에 클릭 이벤트를 등록합니다
	// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
	    
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng; 
	    
	    // 마커 위치를 클릭한 위치로 옮깁니다
	    marker.setPosition(latlng);
	    $("#vLat").text(latlng.getLat());
	    $("#vLng").text(latlng.getLng());
		$("#lat").val(latlng.getLat());
		$("#lng").val(latlng.getLng());
	    
	});
} // onload


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
				<h2>맛집 등록</h2>
				<div id="map" style="width:100%;height:350px;"></div>
				<table>
				<tr>
					<td>식당명</td>
					<td><input type = "text" name = "rest_name" id = "rest_name" style = "width: 350px"/></td>
				</tr>
				<tr>
					<td>대표메뉴</td>
					<td><input type = "text" name = "menu" id = "menu" style = "width: 350px"/></td>
				</tr>
				<tr>
					<td>상세정보</td>
					<td><textarea name = "info" id = "info" style = "width: 350px; height: 150px"></textarea></td>
				</tr>
				<tr>
					<td>위도 / 경도</td>
					<td>
					<span id = "vLat"></span> / <span id = "vLng"></span>
					<input type = "hidden" name = "lat" id = "lat"/>
					<input type = "hidden" name = "lng" id = "lng"/>
					</td>
				</tr>
				<tr>
					<td colspan = 2 style = "text-align: center">
					<input type = "button" value = "등록" id = "btnAdd" class = "btn btn-primary btn-sm"/>
					<a href = "mapList.jsp" class = "btn btn-info btn-sm">리스트</a>
					</td>
				</tr>
				</table>
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