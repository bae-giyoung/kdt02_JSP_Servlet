<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="common.JDBConnect"%>
<%
request.setCharacterEncoding("UTF-8");
String title = request.getParameter("title");
String content = request.getParameter("content");
String id = request.getParameter("id");

// 빈값 처리
if(title == "" || content == "" || id == "") {
	response.sendRedirect("./ExeUpdateFormBoard.jsp?updated=E&cnt=0");
}
else {
	// DB에 연결
	JDBConnect jdbc = new JDBConnect();
		
	// 쿼리문 생성
	String sql = "INSERT INTO board(title, content, id, postdate) VALUES(?,?,?, curdate())";
	PreparedStatement psmt = jdbc.getCon().prepareStatement(sql);
	
	psmt.setString(1,title);
	psmt.setString(2,content);
	psmt.setString(3,id);
	
	int cnt = psmt.executeUpdate();
	
	psmt.close();
	
	response.sendRedirect("./ExeUpdateFormBoard.jsp?updated=Y&cnt="+cnt);
}
%>