<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.time.LocalDate" %>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="false" %>
<%
request.setCharacterEncoding("UTF-8");

String name = request.getParameter("na");
String age = request.getParameter("age");

// JSONObject을 응답. 나이를 가지고 태어난 해를 구해서 응답.
int nowYear = LocalDate.now().getYear();
// int nowYear = Calendar.getInstance().get(Calendar.YEAR);
// 둘 다 가능하지만 이번 경우(현재 연도만 구하기)에는 LocalDate가 더 간결하다.

// 1. JSONObject를 생성(Map 기반)
JSONObject jsonObj = new JSONObject();

int intAge = 0;
if(age != null && !age.isEmpty()) {
	intAge = Integer.parseInt(age);
} // end if


// 2. JSONObject에 응답할 값 설정
jsonObj.put("name", name + "님 안녕하세요?");
jsonObj.put("age", intAge);
jsonObj.put("birth", nowYear - intAge + 1);

// 3. JSONObject를 출력
out.print(jsonObj.toJSONString());



%>