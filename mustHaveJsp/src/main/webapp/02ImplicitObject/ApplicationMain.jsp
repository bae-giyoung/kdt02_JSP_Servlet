<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장 객체 - application</title>
</head>
<body>
	<h2>web.xml에 설정한 내용 읽어오기</h2>
	초기화 매개변수: <%= application.getInitParameter("INIT_PARAM") %> <!-- 매우 중요! -->
	
	<h2>서버의 물리적 경로 얻어오기</h2>
	application 내장 객체: <%= application.getRealPath("/02ImplicitObject") %>
	
	<h2>선언부에서 application 내장 객체 사용하기</h2>
	<%!
	public String useImplicitObject() {
		return this.getServletContext().getRealPath("/02ImplicitObject"); // this가 pageContext라는 객체
	}
	public String useImplicitObject(ServletContext app) {
		return app.getRealPath("/02ImplicitObject");
	}
	%>
	<ul>
		<li>this 사용: <%= useImplicitObject() %></li>
		<li>내장 객체를 인수로 사용: <%= useImplicitObject(application) %></li>
	</ul>
</body>
</html>