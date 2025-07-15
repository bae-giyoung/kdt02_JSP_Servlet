package edu.pnu.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/gugudan02")
public class gugudan02 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		PrintWriter out = res.getWriter();
		res.setContentType("text/html; charset=UTF-8");
		System.out.println(this.getInitParameter("num"));
		String sDir = req.getParameter("dir");
		String dir = "ver";
		if(sDir != null) {
			dir = sDir;
		}
		
		String dirCommand = "display:block;";
		if(dir.equals("hor"))
			dirCommand = "display:inline-block;";
			
		
		for(int i = 2; i <= 9; i++ ) {
			out.println("<ul style='"+dirCommand+"'>");
			for(int j = 1; j <= 9; j++) {
				out.println("<li>" +i+" * "+j+" = "+(i*j)+"</li>");
			}
			out.println("</ul>");
		}
	}
}
