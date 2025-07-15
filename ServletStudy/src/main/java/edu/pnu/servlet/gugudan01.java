package edu.pnu.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/gugudan01")
public class gugudan01 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		PrintWriter out = res.getWriter();
		res.setContentType("text/html; charset=UTF-8");
		System.out.println(this.getInitParameter("num"));
		String snum = req.getParameter("num");
		int num = 2;
		if(snum != null) {
			num = Integer.parseInt(snum);
		}
		
		out.println("<ul>");
		for(int i = 1; i <= 9; i++) {
			out.println("<li>" +num+" * "+i+" = "+(num*i)+"</li>");
		}
		out.println("</ul>");
	}
}
