<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="common.JDBConnect"%>
<%
request.setCharacterEncoding("UTF-8");
String col = request.getParameter("");

// 빈값 처리
if(false) {
	response.sendRedirect("./ExeUpdateFormBoard.jsp?updated=E&cnt=0");
}
else {
	JDBConnect jdbc = null;
	Connection con = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	try {
		
		
		
		
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if(rs != null) rs.close();
			if(psmt != null) psmt.close();
			if(con != null) jdbc.close();
		} catch(Exception e) {}
	}
	
	
	//response.sendRedirect("./ExeUpdateFormBoard.jsp?updated=Y&cnt="+cnt);
}
%>