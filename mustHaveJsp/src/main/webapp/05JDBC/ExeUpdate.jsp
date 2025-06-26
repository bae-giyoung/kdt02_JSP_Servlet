<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="common.JDBConnect"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JDBC</title>
</head>
<body>
	<h2>회원 추가 테스트(executeUpdate() 사용)</h2>
	<%
	// DB에 연결
	JDBConnect jdbc = new JDBConnect();
	
	// 테스트용 입력값 준비
	String id = "test4";
	String pass = "4444";
	String name = "테스트4 회원";
	
	// 쿼리문 생성
	String sql = "INSERT INTO member VALUES (?,?,?,curdate())";
	PreparedStatement psmt = jdbc.getCon().prepareStatement(sql);
	//jdbc.psmt = jdbc.con.prepareStatement(sql); -> Connection객체 외에는 필드로 사용하는 것보다는 로컬에서 사용하고 닫는 것이 좋다!
	psmt.setString(1, id);
	psmt.setString(2, pass);
	psmt.setString(3, name);
	
	// 쿼리 수행
	int inResult = psmt.executeUpdate();
	out.println(inResult + "행이 입력되었습니다.");
	
	// 연결 닫기
	psmt.close();
	jdbc.close();
	%>
</body>
</html>