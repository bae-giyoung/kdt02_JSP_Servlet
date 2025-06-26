<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="common.JDBConnect" %>
<%
// 폼1
String updated = request.getParameter("updated");
String cnt = request.getParameter("cnt");
int updateCnt;

if(updated == null) updated = "";

if(cnt != null)
	updateCnt = Integer.parseInt(cnt);
else
	updateCnt = 0;

// 폼2
String show = request.getParameter("show");
if(show == null) show = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ExeUpdateFormBoard</title>
</head>
<body>
	<form action="ExeUpdateBoard.jsp" method="post">
		타이틀: <input type="text" name="title" value="" /><br />
		컨텐트: <input type="text" name="content" value="" /><br />
		아이디: <input type="text" name="id" value="" /><br />
		<input type="submit" value="확인" />
	</form>
	<div>
	<% 
	if (updated.compareTo("Y") == 0) {
		if(updateCnt != 0)
			out.print("<p>"+updateCnt+"행이 추가되었습니다.</p>");
		else
			out.print("<p>업데이트 실패</p>");
	}
	%>
	</div>
	
	<form action="ShowData.jsp" method="post">
		<input type="hidden" name="redirectUrl" value="ExeUpdateFormBoard.jsp" />
		<input type="hidden" name="cnt" value="<%=updateCnt%>" />
		<input type="hidden" name="updated" value="<%=updated%>" />
		<input type="submit" value="데이터 조회" />
	</form>
	<%
	if (show.compareTo("Y") == 0) {
		JDBConnect jdbc = new JDBConnect();
		Connection con = jdbc.getCon();
		Statement st = null;
		ResultSet rs = null;
		try {
			st = con.createStatement();
			rs = st.executeQuery("SELECT TITLE,CONTENT,ID FROM BOARD");
			
			out.print("<table><caption style='background-color:skyblue'>board db 조회</caption>");
			out.print("<tr>");
			out.print("<th style='border:1px solid gray'>title</th><th style='border:1px solid gray'>content</th><th style='border:1px solid gray'>id</th>");
			out.print("</tr>");
			while(rs.next()) {
				out.print("<tr>");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String id = rs.getString("id");
				
				out.print(String.format("<td style='border:1px solid gray'>%s</td><td style='border:1px solid gray'>%s</td style='border:1px solid gray'><td style='border:1px solid gray'>%s</td>",title,content,id));
				out.print("</tr>");
			}
			out.print("</table>");
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(st != null) st.close();
			} catch(Exception e) {}
		}
	}
	%>
</body>
</html>