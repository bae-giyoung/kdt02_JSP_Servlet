<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="common.JDBConnect" %>
<%
String surface = request.getParameter("surface");
int surfaceInt = 0;
if (surface != null && surface.compareTo("") != 0) surfaceInt = Integer.parseInt(surface);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DBMission06</title>
</head>
<body>
	<h2>넓이(10,0002 km)를 입력 받아서 입력 값보다 작은 면적을 가진 국가의 이름과 면적을 면적 오름차순으로 검색해서 출력</h2>
	<form action="DBMission06.jsp" name="dbmission06" method="post" onsubmit="return isValidForm(this);">
		넓이: <input type="text" name="surface" value="" /><br />
		<input type="submit" value="확인" />
	</form>
	<script>
		function isValidForm(form) {
			if(form.surface.value == "") {
				alert("surface를 입력하세요.")
				return false;
			}
		}
	</script>
	<%
	if (surface != null) {
		JDBConnect jdbc = new JDBConnect("com.mysql.cj.jdbc.Driver", "jdbc:mysql://localhost:3306/world", "root", "tiger");

		String sql = "select name, surfacearea from country where surfacearea < ? order by surfacearea asc";
		PreparedStatement psmt = jdbc.getCon().prepareStatement(sql);
		psmt.setInt(1, surfaceInt);
		
		ResultSet rs = null;
		ResultSetMetaData meta = null;
		
		try {
			rs = psmt.executeQuery();
			meta = rs.getMetaData();
			int colNums = meta.getColumnCount();
			
			out.print("<table><caption style='background-color:skyblue'>데이터 조회</caption>");
			out.print("<tr>");
			for(int i=1; i<=colNums; i++) {				
				out.print("<th style='border:1px solid gray'>"+meta.getColumnName(i)+"</th>");
			}
			out.print("</tr>");
			while(rs.next()) {
				out.print("<tr>");
				for(int i=1; i<=colNums; i++) {	
					String col = rs.getString(i);
					out.print(String.format("<td style='border:1px solid gray'>%s</td>",col));
				}
				out.print("</tr>");
			}
			out.print("</table>");
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(meta != null) meta = null;
				if(rs != null) rs.close();
				if(psmt != null) psmt.close();
				if(jdbc.getCon() != null) jdbc.close();
			} catch(Exception e) {}
		}
	}
	%>
</body>
</html>