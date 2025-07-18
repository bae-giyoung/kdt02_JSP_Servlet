<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현 언어(EL) - 객체 매개 변수</title>
</head>
<body>
	<h2>영역을 통해 전달된 객체 읽기</h2>
	<ul>
		<li>Person 객체 => 이름 : ${ personObj.name }, 나이 : ${ personObj.age }</li>
		<li>Person 객체 => 이름 : ${ requestScope.stringObj }</li>
		<li>Person 객체 => 이름 : ${ integerObj }</li>
	</ul>
	
	<h2>매개변수로 전달된 값 읽기</h2>
	<ul>
		<li>${ param.firstNum + param['secondNum']}</li><!-- 독특한 부분 -->
		<li>${ param.firstNum } + ${ param["secondNum"] }</li>
	</ul>
</body>
</html>