<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> <!-- page directive -->

<%
//한글을 parameter로 전달할 때에는 encoding하여 넘겨야 한다.
request.setCharacterEncoding("UTF-8");
// 업무처리할 결과 > List
// => web parameter로 전달될 수 없다.
List<String> names = new ArrayList<String>();
names.add("루피");
names.add("쵸파");
names.add("샹디");
names.add("조로");

//scope 객체에 데이터를 할당 > scope 객체 사용해서 값 받기
request.setAttribute("names", names);

String name = "민병조"; // scope 객체에 넘겨도 되지만 parameter로 넘기고 싶다
int age = 20;

%>

<!-- parameter가 없는 경우 -->
<%-- <jsp:forward page = "forward_action_b.jsp"/> --%>

<!-- parameter가 있는 경우 -->
<jsp:forward page = "forward_action_b.jsp">
<jsp:param value = "<%= name %>" name = "name"/>
<jsp:param value = "<%= age %>" name = "age"/>
</jsp:forward>
