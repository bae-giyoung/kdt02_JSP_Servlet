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
<title>ExeUpdateFormMember</title>
</head>
<body>
	<form action="ExeUpdateMember.jsp" method="post">
		아이디: <input type="text" name="id" value="" /><br />
		비밀번호: <input type="text" name="pass" value="" /><br />
		성명: <input type="text" name="name" value="" /><br />
		<input type="submit" value="확인" />
	</form>
	<div>
	<% 
	if (updated.compareTo("Y") == 0) {
		if(updateCnt != 0)
			out.print("<p>"+updateCnt+"행이 추가되었습니다.</p>");
		else
			out.print("<p>업데이트 실패: 아이디가 중복인지 확인하세요.</p>");
	} else if(updated.compareTo("E") == 0) {
		out.print("업데이트 실패: 빈값을 입력");
	}
	%>
	</div>
	
	<form action="ShowData.jsp" method="post">
		<input type="hidden" name="redirectUrl" value="ExeUpdateFormMember.jsp" />
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
			rs = st.executeQuery("SELECT ID, PASS, NAME FROM Member");
			
			out.print("<table><caption style='background-color:skyblue'>member db 조회</caption>");
			out.print("<tr>");
			out.print("<th style='border:1px solid gray'>title</th><th style='border:1px solid gray'>content</th><th style='border:1px solid gray'>id</th>");
			out.print("</tr>");
			while(rs.next()) {
				out.print("<tr>");
				String id = rs.getString("id");
				String pass = rs.getString("pass");
				String name = rs.getString("name");
				
				out.print(String.format("<td style='border:1px solid gray'>%s</td><td style='border:1px solid gray'>%s</td style='border:1px solid gray'><td style='border:1px solid gray'>%s</td>",id,pass,name));
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