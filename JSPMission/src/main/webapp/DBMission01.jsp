<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="common.JDBConnect" %>
<%
String popStr = request.getParameter("population");
int population = 0;
if(popStr != null) population = Integer.parseInt(popStr);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DBMission01</title>
</head>
<body>
	<h2>인구 수를 입력 받아서 그보다 많은 인구를 가진 도시 출력</h2>
	<form action="DBMission01.jsp" name="dbmission01" method="post" onsubmit="return isValidForm(this);">
		인구수: <input type="text" name="population" value="" /><br />
		<input type="submit" value="확인" />
	</form>
	<script>
		function isValidForm(form) {
			if(form.population.value == "") {
				alert("인구수를 입력하세요.")
				return false;
			}
		}
	</script>
	<%
	if (population != 0) {
		JDBConnect jdbc = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		ResultSetMetaData meta = null;
		
		String sql = "select name from city where population>=?";
		
		try {
			jdbc = new JDBConnect("com.mysql.cj.jdbc.Driver", "jdbc:mysql://localhost:3306/world", "root", "tiger");
			psmt = jdbc.getCon().prepareStatement(sql);
			psmt.setInt(1, population);
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