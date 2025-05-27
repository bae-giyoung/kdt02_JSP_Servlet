<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구구단 : 2단에서 9단까지 수직으로 출력</title>
</head>
<body>
<%! // 메서드로 작성
	public void printGuguDan(int dan, JspWriter out) throws Exception {
		for(int i = 1; i < 10; i++) { //1~9
			out.write(dan + "*" + i + "=" + (dan*i) + "<br/>");
		}
	}

	//표현식으로 작성
	public StringBuffer makeGuguDanString() {
		StringBuffer sf = new StringBuffer();
		// 2~9단
		for(int i = 2; i < 10; i++) {
			sf.append("<h2>" + i + "단</h2>");
	 		for(int j = 1; j < 10; j++) {
	 			sf.append(i + "*" + j + "=" + (i*j) + "<br/>");
	 		}
		}
		return sf;
	}
%>

<%
	// 코드로 작성 // 메서드로 작성
	out.write("<h1>[코드&메서드로 작성]</h1>");
	// 2~9단
	for(int i = 2; i < 10; i++) { // 2~9
		out.write("<h2>" + i + "단</h2>");
// 		for(int j = 1; j < 10; j++) { //1~9
// 			out.write(i + "*" + j + "=" + (i*j) + "<br/>");
// 		}
		// 메서드로 작성
		printGuguDan(i, out);
	}
	
	
%>

<h1>[표현식으로 작성1]</h1>
<%= makeGuguDanString() %>


<h1>[표현식으로 작성2] - 코드 영역에 어떻게 작성이 되었는지 꼭 확인하기!!</h1>
<% for(int i = 2; i < 10; i++) { %>
	<h2> <%= i %> 단</h2>
	<% for(int j = 1; j < 10; j++) { %>
		<%= i %> * <%= j %> = <%= i*j %> <br/>
	<% }%>
<% }%>


</body>
</html>