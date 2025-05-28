<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%
  String sval = request.getParameter("val"); // 무조건 String으로 가져온다!
  int dan = 2;
  if (sval != null && sval != "") {
 		dan = Integer.parseInt(sval); // 반드시 정수로 변환해주기!
  }
  
  StringBuffer sb = new StringBuffer();
  for (int i = 1; i < 10; i++) {
   sb.append( dan + "*" + i + "=" + dan*i + "<br />");
  }
  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구구단</title>
</head>
<body>
	<!-- 구구단 request객체를 통해 출력해보기! -->
	<!-- 파라미터가 없으면 디폴트로 2단 출력 -->
	<h2><%= dan %>단입니다.</h2>
	<%= sb %>
</body>
</html>