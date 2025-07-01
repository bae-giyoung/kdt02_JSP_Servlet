<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="common.JDBConnect" %>
<%
String district = request.getParameter("district");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DBMission07</title>
</head>
<body>
	<h2>대한민국의 District를 입력 받아서 해당 지역에 있는 모든 도시를 검색해서 출력(예시: Kyonggi)</h2>
	<form action="DBMission07.jsp" name="dbmission07" method="post" onsubmit="return isValidForm(this);">
		District: <input type="text" name="district" value="" /><br />
		<input type="submit" value="확인" />
	</form>
	<script>
		function isValidForm(form) {
			if(form.district.value == "") {
				alert("District를 입력하세요.")
				return false;
			}
		}
	</script>
	<%
	if (district != null) {
		JDBConnect jdbc = new JDBConnect("com.mysql.cj.jdbc.Driver", "jdbc:mysql://localhost:3306/world", "root", "tiger");
		
		String sql = "select name from city where countrycode='KOR' and district=?";
		PreparedStatement psmt = jdbc.getCon().prepareStatement(sql);
		psmt.setString(1, district);
		
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