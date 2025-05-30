<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int col = 3;
String sVal = request.getParameter("val");

if (sVal != null && sVal != "") {
	col = Integer.parseInt(sVal);
}
%>
<%!
// [방법 1]: 주르륵 나열
public StringBuffer printGugudan1 (int col) {
	int c = 9/col;
	int start = 2;
	StringBuffer sb = new StringBuffer();
	for (int i=1; i<=c; i++) { // 3: 1 ~ 3
		int end = (col * i) + 1;
		
		// 단 제목 출력
		for (int j = start; j <= end && j <= 9; j++) { // 2 ~ 4, 5 ~ 7, 8 ~ 9
			sb.append("<span class='dTit'>" + j + "단\t</span>\t");
		}
		sb.append("<br />");
		
		// 단 내용 출력
		for (int k=1; k<=9; k++) { // 1 ~ 9
			for (int j = start; j <= end && j <= 9; j++) { // 2 ~ 4, 5 ~ 7, 8 ~ 9
				sb.append(j + "*" + k + "=" + (j*k) + "\t");
			}
			sb.append("<br/>");
		}
		sb.append("<br/>");
		start += c;
	}
	return sb;
}

// [방법2]: 각각 엘레먼트를 묶어서 해보기


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구구단4</title>
<style>
	.dTit {
		font-size: 30px;
		font-weight: 700;
	}
</style>
</head>
<body>
	<%= printGugudan1(col) %>
</body>
</html>