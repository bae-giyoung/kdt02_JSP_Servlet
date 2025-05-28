<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장 객체 - response</title>
</head>
<body>
<%
String id = request.getParameter("user_id");
String pwd = request.getParameter("user_pwd");
if(id.equalsIgnoreCase("must") && pwd.equalsIgnoreCase("1234")){
	response.sendRedirect("ResponseWelcome.jsp"); // 두 번 왕복, 페이지 url 바뀜
}
else{
	request.getRequestDispatcher("ResponseMain.jsp?loginErr=1").forward(request, response); // 같은 페이지, 내부적으로 처리됨
}
%>
</body>
</html>