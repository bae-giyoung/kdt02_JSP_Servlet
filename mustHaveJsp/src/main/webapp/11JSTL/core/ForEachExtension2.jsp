<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="common.Person" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - forEach3</title>
</head>
<body>
	<h4>List 컬렉션 사용하기</h4>
	<%
	LinkedList<Person> lists = new LinkedList<Person>();
	lists.add(new Person("맹사성", 34));
	lists.add(new Person("장영실", 44));
	lists.add(new Person("신숙주", 54));
	%>
	<c:set var="lists" value="<%= lists %>" /> <!-- 매우 중요! -->
	<c:forEach items="${ lists }" var="list">
		이름 : ${ list.name }, 나이 : ${ list.age }
	</c:forEach>
	
	<h4>Map 컬렉션 사용하기</h4>
	<%
	Map<String, Person> maps = new HashMap<String, Person>();
	maps.put("1st", new Person("맹사성", 34));
	maps.put("2nd", new Person("장영실", 44));
	maps.put("3rd", new Person("신숙주", 54));
	%>
	<c:set var="maps" value="<%= maps %>" />
	<c:forEach items="${ maps }" var="map">
		Key => ${ map.key } <br />
		Value => 이름 : ${ map.value.name }, 나이 : ${ map.value.age } <br />
	</c:forEach>

</body>
</html>