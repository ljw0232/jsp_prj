<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function result(num1, num2) {
	alert(num1 + " X " + num2 + " = " + (num1 * num2));
}
</script>
</head>
<body>
<% // scriptlet => JSP가 Java로 변환될 때 _jspService() 안에 코드가 생성된다.
String name = "민병조";
%>
안녕하세요? <span><%= name %></span>님<br>
<!-- 테이블에 구구단 2단을 출력 -->
<table border = "1" cellpadding = "5" cellspacing = "0">
<tr>
<%
for(int i = 1; i < 10; i++) {
%>
<td onclick = "result(2, <%= i %>)">2 X <%= i %></td>
<%
} // end for
%>
</tr>
</table>
<div>
<% for(int i = 1; i < 7; i++) { %>
<h<%= i %>>안녕하세요?</h<%= i %>>
<% } // end for %>
</div>

<div>
<!-- 구구단 모든 단을 테이블로 출력 -->
<table border = "1" cellpadding = "5">
<%
for(int i = 1; i < 10; i++) {
%>
<tr>
<%
	for(int j = 2; j < 10; j++) {
%>
		<td><%= j %> X <%= i %> = <%= j * i %></td>
<%
} // end for
%>
</tr>
<%
} // end for
%>
</table>
</div>

</body>
</html>