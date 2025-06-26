<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="common.JDBConnect"%>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");

// DB에 연결
JDBConnect jdbc = new JDBConnect();
	
// 쿼리문 생성
String sql = "INSERT INTO member VALUES(?,?,?, curdate())";
PreparedStatement psmt = jdbc.getCon().prepareStatement(sql);

psmt.setString(1,id);
psmt.setString(2,pass);
psmt.setString(3,name);

int cnt = psmt.executeUpdate();

psmt.close();

response.sendRedirect("./ExeUpdateFormMember.jsp?updated=Y&cnt="+cnt);
%>