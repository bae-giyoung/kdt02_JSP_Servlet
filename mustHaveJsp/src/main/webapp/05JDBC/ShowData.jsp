<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String url = request.getParameter("redirectUrl");
String updated = request.getParameter("updated");
String cnt = request.getParameter("cnt");
response.sendRedirect(String.format("./%s?show=Y&updated=%s&cnt=%s", url, updated, cnt));
%>