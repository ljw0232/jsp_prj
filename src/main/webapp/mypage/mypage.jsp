<%@page import="day1128.ParamDTO"%>
<%@page import="kr.co.sist.user.member.WebMemberService"%>
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
<title>회원 정보 수정</title>

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
	
	// 업로드 버튼 처리
	$("#btnUpload").click(function() {
		$("#upfile").click();
	}); // click
	
	$("#upfile").change(function(evt) {
		
		// 업로드 가능 확장자는 jpg, gif, png, bmp만 가능한 체크코드 작성
		/* 
		var blockExt = "gif,jpg,png,bmp".split(",");
		
		var file = $("#upfile").val();
		var ext = file.substring(file.lastIndexOf(".") + 1);
		
		var flag = false;
		for(var i = 0; i < blockExt.length; i++) {
			if(blockExt[i] == ext) {
				flag = true;	
			} // end if
		} // change
		
		if(!flag) {
			alert("파일 업로드는 gif,jpg,png,bpm만 가능합니다.");
			return;
		}
		*/
		
		// 미리보기
		// 1. HTML File Control 접근
		var file = evt.target.files[0]; // <input type = "file"
		
		// 2. 파일을 읽기 위한 스트림 생성
		var reader = new FileReader();
		
		// 3. File 객체의 onload 이벤트 핸들러를 설정하여 <img 태그에 src 속성에 파일명을 설정
		reader.onload = function(evt) {
			$("#preview").prop("src", evt.target.result);
		} 
		
		// 4. 스트림을 사용하여 <img 태그 이미지를 로딩
		reader.readAsDataURL(file);
		
	}); // change 
	
	$("#btn").click(function() {
		if(confirm("회원 정보를 수정하시겠습니까?")) {
			$("#modifyFrm").submit();
		}
	});
	
}); // ready

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
				<div class="col-md-7">
					<%
					String id = (String)session.getAttribute("userId");
					/* String id = "kim"; */
					// 개발 중 편의성 용도
					// 팀원의 개발 현황에 영향받지 않고 내 작업을 진행할 수 있다.
					
					WebMemberService wms = WebMemberService.getInstance();
					ParamDTO pDTO = wms.searchMember(id);
					
					String selectMail = pDTO.getEmail();
					String email = selectMail.substring(0, selectMail.indexOf("@"));
					String domain = selectMail.substring(selectMail.indexOf("@") + 1);
					
					pageContext.setAttribute("pDTO", pDTO);
					pageContext.setAttribute("email", email);
					pageContext.setAttribute("domain", domain);
					%>
					
					<h2>회원정보 수정</h2>
					<form name="modifyFrm" method="post" id="modifyFrm" action="mypageProcess.jsp" enctype = "multipart/form-data"> 
					<table id="modifyFrm">
						<tr>
							<td class="title"><label><span class="star">*</span>아이디</label></td>
							<td class = "input"><strong><c:out value = "${sessionScope.userId}"></c:out></strong></td>
							
						</tr>
						
						<tr>
							<td class="input" colspan = "2">
							<img src = "${CommonURL}/upload/${pDTO.profile}" id = "preview" style = "width: 100px; height: 100px; border-radius: 50px"><br>
							<input type = "file" accept = "image/*" name = "upfile" id = "upfile" style = "display:none"/><br>
							<input type = "button" value = "업로드" id = "btnUpload" class = "btn btn-success btn-sm"/><br>
							<input type = "hidden" value = "${pDTO.profile}" id = "profile" name = "profile"/><br>
							</td>
							
						</tr>
						
						<tr>
							<td class="title"><label><span class="star">*</span>이름</label></td>
							<td class="input"><strong><c:out value = "${pDTO.name}"></c:out></strong></td>
						</tr>
						
						<tr>
							<td class="title"><label><span class="star">*</span>이메일</label></td>
							<td class="input">
							<input type="text" name="mail" class="inputBox" value="${email}"/>@
							<select name = "domain" id = "domain">
							<option value = "google.com">google.com</option>
							<option value = "naver.com">naver.com</option>
							<option value = "daum.com">daum.com</option>
							<option value = "hotmail.com">hotmail.com</option>
							<option value = "test.com">test.com</option>
							</select>
							<script type = "text/javascript">
							$("#domain").val("${domain}")
							</script>
							</td>
						</tr>
					
						<tr>
							<td class="title"><label><span class="star">*</span>생일</label></td>
							<td class="input"><input type="date" name="birth" class="inputBox" value="${pDTO.birth}"/></td>
						</tr>
					
						<tr>
							<td class="title"><label><span class="star">*</span>소재지</label></td>
							<td class="input"><select name="loc" id = "loc" class="inputBox" style="width: 120px;height: 25px">
									<option value="N/A">선택해주세요</option>
									<option value="강원">강원</option>
									<option value="경기">경기</option>
									<option value="경남">경남</option>
									<option value="경북">경북</option>
									<option value="광주">광주</option>
									<option value="대구">대구</option>
									<option value="대전">대전</option>
									<option value="부산">부산</option>
									<option value="서울">서울</option>
									<option value="울산">울산</option>
									<option value="인천">인천</option>
									<option value="전남">전남</option>
									<option value="전북">전북</option>
									<option value="제주">제주</option>
									<option value="충남">충남</option>
									<option value="충북">충북</option>
									<option value="제주">제주</option>
									<option value="해외">해외</option>
							</select>
							<script type = "text/javascript">
								$("#loc").val("${pDTO.loc}")
							</script>
							</td>
						</tr>
						<tr>
						<td class="title">소개</td>
						<td><textarea name="intro" style="width: 400px;height: 100px"><c:out value = "${pDTO.intro}"/></textarea></td>
						</tr>
						<tr>
						</tr>
						<tr>
						<td colspan="2" style="text-align: center">
						<input type="hidden" name="code" value="U3881">
						<input type="button" value="변경" class="btn btn-success" id="btn"/>
						</td>
						</tr>
					</table>
					</form>
					
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