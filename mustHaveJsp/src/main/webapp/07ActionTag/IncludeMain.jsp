<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 포함할 파일의 경로
String outerPath1 = "./inc/OuterPage1.jsp";
String outerPath2 = "./inc/OuterPage2.jsp";

// page영역과 request영역에 속성 저장
pageContext.setAttribute("pAttr", "동명왕");
request.setAttribute("rAttr", "온조왕");

// 변수 접근 범위 확인
String v1 = "main의 변수에 접근 가능";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지시어와 액션 태그 동작 방식 비교</title>
</head>
<body>
	<h2>지시어와 액션 태그 동작 방식 비교</h2>
	<!-- 지서어 방식 -->
	<%@ include file="./inc/OuterPage1.jsp" %>
<%-- 	<%@ include file=outerPath1OuterPage1 %> --%>
	<p>외부 파일에 선언한 변수: <%=newVar1 %></p>
	
	<!-- 액션태그 방식 -->
	<jsp:include page="./inc/OuterPage2.jsp" />
	<jsp:include page="<%=outerPath2%>" />
	<p>외부 파일에 선언한 변수: <%--=newVar2 --%>접근 불가</p>
</body>
</html>