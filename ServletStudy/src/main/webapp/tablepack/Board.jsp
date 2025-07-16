<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDTO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
// DB 연결 객체 생성
BoardDAO dao = new BoardDAO(application);

// 게시판 리스트 가져와서 저장하기
List<BoardDTO> list = dao.getAllList();

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
				<th scope="col">num</th>
				<th scope="col">title</th>
				<th scope="col">content</th>
				<th scope="col">id</th>
				<th scope="col">postdate</th>
				<th scope="col">visitcount</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="<%= list %>" var="l" varStatus="loop">
			<tr>
				<td>${ l.getNum() }</td>
				<td>${ l.getTitle() }</td>
				<td>${ l.getContent() }</td>
				<td>${ l.getId() }</td>
				<td>${ l.getPostdate() }</td>
				<td>${ l.getVisitcount() }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>