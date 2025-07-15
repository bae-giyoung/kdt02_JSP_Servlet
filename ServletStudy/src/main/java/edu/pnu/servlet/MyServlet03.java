package edu.pnu.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/myservlet03")
public class MyServlet03 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		System.out.println("MyServlet03");
		res.setContentType("text/html; charset=utf-8"); // 브라우저가 이 문서를 어떻게 해석해야 할지 알려줌! 헤더에 정보를 넣어서 response 객체를 전달함
		PrintWriter out = res.getWriter();
		out.println("<h2>이것은 서블릿에서 출력하는 문서입니다.</h2>");
		out.println("<h3>잘 보이면 성공</h3>");
		out.close();
	}
}
