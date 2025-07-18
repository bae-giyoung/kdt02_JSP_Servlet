<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - fmt 2</title>
</head>
<body>
	<c:set var="today" value="<%= new java.util.Date() %>" />
	
	<h4>날짜 포맷</h4>
	full: <fmt:formatDate value="${today }" type="date" dateStyle="full"/> <br />
	short: <fmt:formatDate value="${today }" type="date" dateStyle="short"/> <br />
	long: <fmt:formatDate value="${today }" type="date" dateStyle="long"/> <br />
	default: <fmt:formatDate value="${today }" type="date" dateStyle="default"/> <br />
	
	
	<h4>시간 포맷</h4>
	full: <fmt:formatDate value="${today }" type="time" dateStyle="full"/> <br />
	short: <fmt:formatDate value="${today }" type="time" dateStyle="short"/> <br />
	long: <fmt:formatDate value="${today }" type="time" dateStyle="long"/> <br />
	default: <fmt:formatDate value="${today }" type="time" dateStyle="default"/> <br />
	
	
</body>
</html>