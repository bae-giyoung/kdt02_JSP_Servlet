<%@page import="java.util.ArrayList"%>
<%@page import="common.Person" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Session 영역</title>
</head>
<body>
	<h2>페이지 이동 후 session 영역의 속성 읽기</h2>
	<%
	ArrayList<String> lists = (ArrayList<String>)session.getAttribute("lists");
	for(String str : lists)
		out.print(str + "<br/>");
	//ArrayList<Person> persons = (ArrayList<Person>)session.getAttribute("persons");
	//for(Person str : persons)
		//out.print(str.getName() + "<br/>");
	
	%>

</body>
</html>