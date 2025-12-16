<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> <!-- page directive -->

<%
// 응답되는 페이지가 아니므로 디자인 코드는 넣지 않는다.

// 0. 업무 처리한 결과를 view 페이지로 전달하기 위해서 request 객체에 속성으로 설정
String[] names = {"tim berners lee", "james gosling", "민병조"};
String[] infos = {"Web의 아버지", "Java의 아버지", "아버지가 될 사람!"};
request.setAttribute("names", names);
request.setAttribute("infos", infos);

// 1. 이동할 페이지의 URI를 설정하여 RequestDispatcher를 얻기
RequestDispatcher rd = request.getRequestDispatcher("forward_b.jsp");

// 2. 이동
rd.forward(request, response);

%>
