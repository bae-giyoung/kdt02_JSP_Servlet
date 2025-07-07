<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String pValue = "방랑시인";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>액션 태그 - param</title>
</head>
<body>
<!-- get방식 param에 공백 못들어감 -->
<!-- 경기도 양주 => 경기도%d양주 -->
<!-- param9= 나이&생일 이렇게 공백문자나 특수기호 전송하고 싶을 때! URLEncoder => %_%_ 보낼때 -> 받을때 디코딩 되어 출력 -->
	<jsp:useBean id="person" class="common.Person" scope="request"/>
	<jsp:setProperty name="person" property="name" value="김삿갓" />
	<jsp:setProperty name="person" property="age" value="56" />
	<jsp:forward page="ParamForward.jsp?param1=김병연">
		<jsp:param name="param2" value="경기도 양주" />
		<jsp:param name="param3" value="<%=pValue %>" />
	</jsp:forward>
</body>
</html>