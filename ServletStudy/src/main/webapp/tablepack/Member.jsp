<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.MemberDTO" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
// DB 연결 객체 생성
MemberDAO dao = new MemberDAO(application);

// 게시판 리스트 가져와서 저장하기
List<MemberDTO> list = dao.getAllList();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member</title>
</head>
<body>
	<h2>Member List</h2>
	<table border="1">
		<thead>
			<tr>
				<th scope="col">id</th>
				<th scope="col">pass</th>
				<th scope="col">name</th>
				<th scope="col">regidate</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="<%= list %>" var="l" varStatus="loop">
			<tr>
				<td>${ l.getId() }</td>
				<td>${ l.getPass() }</td>
				<td>${ l.getName() }</td>
				<td>${ l.getRegidate() }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>