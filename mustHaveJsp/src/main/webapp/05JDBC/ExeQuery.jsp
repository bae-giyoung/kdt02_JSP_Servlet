<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="common.JDBConnect"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JDBC(executeQuery() 사용)</title>
</head>
<body>
	<h2>회원 목록 조회</h2>
	<%
	// DB에 연결
	JDBConnect jdbc = new JDBConnect();
	
	// 쿼리문 생성
	String sql = "SELECT id, pass, name, regidate FROM member";
	Statement stmt = jdbc.getCon().createStatement();
	
	// 쿼리 수행
	ResultSet rs = stmt.executeQuery(sql);
	
	// 결과 확인
	while(rs.next()) {
		String id = rs.getString("id");
		String pw = rs.getString("pass");
		String name = rs.getString("name");
		Date regidate = rs.getDate("regidate");
		
		out.println(String.format("%s %s %s %s", id, pw, name, regidate) + "<br />");
	}
	
	// 연결 닫기
	rs.close();
	stmt.close();
	jdbc.close();
	%>
</body>
</html>