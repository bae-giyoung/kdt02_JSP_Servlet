<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="common.Person" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현 언어(EL) - 컬렉션</title>
</head>
<body>
	<h2>List 컬렉션</h2>
	<%
	List<Object> aList = new ArrayList<Object>();
	aList.add("청해진");
	aList.add(new Person("장보고", 28));
	pageContext.setAttribute("Ocean", aList);
	%>
	<ul>
		<li>0번째 요소 : ${ Ocean[0] }</li>
		<li>1번째 요소 : ${ Ocean[1] }</li>
		<li>2번째 요소 : ${ Ocean[2] }</li><!-- 출력되지 않음 -->
	</ul>
	
	<h2>Map 컬렉션</h2>
	<%
	Map<String, String> map = new HashMap<String, String>();
	map.put("한글", "훈민정음");
	map.put("Eng", "English");
	pageContext.setAttribute("King", map);
	%>
	<ul>
		<li>영문 key : ${ King["Eng"] }, ${ King['Eng'] }, ${ King.Eng }</li>
		<li>한글 key : ${ King["한글"] }, ${ King['한글'] }, ${ King.한글 }</li><!-- 새로운 버전에서는 에러 안남! 기존엔 에러! -->
	</ul>
</body>
</html>