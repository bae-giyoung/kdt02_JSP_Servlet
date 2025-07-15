package edu.pnu.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/myservlet05")
public class MyServlet05 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		PrintWriter out = res.getWriter();
		res.setContentType("text/html; charset=UTF-8");
		out.println("<table border='1'>");
		out.println("<thead>"
				+ "<tr>"
				+ "<th scope='col'>번호</th>"
				+ "<th scope='col'>나라</th>"
				+ "<th scope='col'>수도</th>"
				+ "<th scope='col'>인구</th>"
				+ "</tr>"
				+ "</thead>");
		out.println("<tbody>"
				+ "<tr>"
				+ "<td>1</td>"
				+ "<td>대한민국</td>"
				+ "<td>서울</td>"
				+ "<td>1000만</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td>2</td>"
				+ "<td>미국</td>"
				+ "<td>워싱턴</td>"
				+ "<td>70만</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td>2</td>"
				+ "<td>일본</td>"
				+ "<td>도쿄</td>"
				+ "<td>1400만</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td>4</td>"
				+ "<td>중국</td>"
				+ "<td>베이징</td>"
				+ "<td>2100만</td>"
				+ "</tr>"
				+ "</tbody>");
		out.println("</table>");
	}
}
