<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
table {
	border:1px solid;
	border-collaps: collaps;
}
td, tr {
	border:1px solid;
	padding: 4px 10px;
}
.title {
	text-align: center;
	background-color: lightgray;
}
</style>
<title>구구단2</title>
</head>
<body>
	<table>
		<tr> 
		<%
		for(int i=2; i<=9; i++) { 
		%>
			<td><%= i %>단</td>	
		<%
		}
		%>
		</tr>
		
	<% for(int i=1; i<=9; i++) { %>
		<tr> 
		<%
		for(int j=2; j<=9; j++) { 
		%>
			<td><%= j + "*" + i + "=" + (i*j) %></td>	
		<%
		}
		%>
		</tr>
	<%
	}
	%>
	</table>
</body>
</html>