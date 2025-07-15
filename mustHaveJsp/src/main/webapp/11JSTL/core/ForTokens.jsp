<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - forTokens</title>
</head>
<body>
	<%
	String rgba = "Red,Green,Blue,Black";
	%>
	<h4>JSTL의 forTokens 태그 사용</h4>
	<c:forTokens items="<%= rgba %>" delims="," var="color">
		<span style="color:${color};">${ color }</span> <br />
	</c:forTokens>
	
	<%
	String rgba2 = "Red.Green,Blue&Black";
	%>
	<h4>JSTL의 forTokens 태그 사용 - 구분자 여러개</h4>
	<c:forTokens items="<%= rgba2 %>" delims=",&." var="color2">
		<span style="color:${color2};">${ color2 }</span> <br />
	</c:forTokens>
	
	<%
	String rgba3 = "Red  Green,Blue&Black";
	%>
	<h4>JSTL의 forTokens 태그 사용 - 구분자 여러개 중 공백</h4>
	<c:forTokens items="<%= rgba3 %>" delims=", &" var="color3">
		<span style="color:${color3};">${ color3 }</span> <br />
	</c:forTokens>
</body>
</html>