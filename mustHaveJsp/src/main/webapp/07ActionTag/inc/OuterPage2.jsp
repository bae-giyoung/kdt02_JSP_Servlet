<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OuterPage</title>
</head>
<body>
	<h2>외부 파일2</h2>
	<%
	String newVar2 = "백제 온조왕";
	%>
	<ul>
		<li>page 영역 속성: <%= pageContext.getAttribute("pAttr") %></li>
		<li>request 영역 속성: <%= request.getAttribute("rAttr") %></li>
		<li>변수 접근 범위 확인: 접근 불가</li>
	</ul>
</body>
</html>