<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="common.JDBConnect" %>
<%
String nameStr = request.getParameter("nameOrCode");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DBMission04</title>
</head>
<body>
	<h2>국가 코드 또는 국가 명의 일부를 입력 받아서 해당 국가의 도시의 이름과 인구를 검색해서 출력</h2>
	<form action="DBMission04.jsp" name="dbmission04" method="post" onsubmit="return isValidForm(this);">
		국가명 또는 국가코드: <input type="text" name="nameOrCode" value="" /><br />
		<input type="submit" value="확인" />
	</form>
	<script>
		function isValidForm(form) {
			if(form.nameOrCode.value == "") {
				alert("국가명 또는 국가코드를 입력하세요.")
				return false;
			}
		}
	</script>
	<%
	if (nameStr != null) {
		JDBConnect jdbc = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		ResultSetMetaData meta = null;
		
		String sql = "select city.name, city.population from country, city where country.code=city.countrycode and (country.name like ? or country.code=?)";
		
		try {
			jdbc = new JDBConnect("com.mysql.cj.jdbc.Driver", "jdbc:mysql://localhost:3306/world", "root", "tiger");
			psmt = jdbc.getCon().prepareStatement(sql);
			psmt.setString(1, "%"+nameStr+"%");
			psmt.setString(2, nameStr);
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