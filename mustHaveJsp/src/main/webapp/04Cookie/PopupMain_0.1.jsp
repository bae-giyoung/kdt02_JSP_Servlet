<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String popupMode = "on"; // 레이어 팝업 띄울 지 여부
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
div#popup {
	position:absolute;top:100px;left:50px;color:yellow;
	width:270px;height:100px;background-color:gray;
}
div#popup>div {
	position:relative;background-color:#ffffff;top:0;
	border:1px solid gray;padding:10px;color:black;
}
</style>
<script>
document.addEventListener("DOMContentLoaded", ()=>{
	document.querySelector("#closeBtn").addEventListener("click",()=>{
		document.querySelector("#popup").style.display = "none";	
	});
});
</script>
<title>쿠키를 이용한 팝업 관리 v 0.1</title>
</head>
<body>
<h2>팝업 메인 페이지(ver 0.1)</h2>
<%
for(int i=0; i<=10; i++) {
	out.println("현재 팝업창은 " + popupMode + " 상태입니다. <br/>");
}

if (popupMode.equals("on")) {
%>
<div id="popup">
	<h2 align="center">공지사항 팝업입니다.</h2>
	<div align="right">
		<form name="popFrm">
			<input type="checkbox" id="inactiveToday" value="1" />
			하루 동안 열지 않음
			<input type="button" id="closeBtn" value="닫기" />
		</form>
	</div>
</div>
<%
	}
%>
</body>
</html>