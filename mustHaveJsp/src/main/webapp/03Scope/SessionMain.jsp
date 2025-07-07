<%@ page import="java.util.ArrayList" %>
<%@ page import="common.Person" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    ArrayList<String> lists = new ArrayList<String>();
    ArrayList<Person> persons = new ArrayList<>(); 
    lists.add("리스트");
    lists.add("컬렉션");
    session.setAttribute("lists", lists);
    Person p = new Person("홍", 11);
    persons.add(p);
    persons.add(new Person("김", 20));
    persons.add(new Person("이", 40));
    persons.add(new Person("로", 30));
    session.setAttribute("Persons", persons);
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>session 영역</title>
</head>
<body>
<h2>페이지 이동 후 seesion 영역의 속성 읽기</h2>
	<a href="SessionLocation.jsp">SessionLocation.jsp 바로가기</a>

</body>
</html>