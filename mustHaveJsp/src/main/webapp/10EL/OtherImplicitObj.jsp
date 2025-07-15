<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="utils.CookieManager" %>
<%
CookieManager.makeCookie(response, "ElCookie", "EL좋아요", 10);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현 언어(EL) - 그 외 내장 객체</title>
</head>
<body>
	<h3>쿠키값 읽기</h3>
	<ul><li>ELCookie값 : ${ cookie.ElCookie.value }</li></ul>
	
	<h3>HTTP 헤더 읽기</h3>
	<ul>
		
	</ul>
</body>
</html>