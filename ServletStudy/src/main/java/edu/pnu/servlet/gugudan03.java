package edu.pnu.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/gugudan03")
public class gugudan03 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		PrintWriter out = res.getWriter();
		res.setContentType("text/html; charset=UTF-8");
		System.out.println(this.getInitParameter("num"));
		String sDan = req.getParameter("dan");
		int dan = 1;
		if(sDan != null) {
			dan = Integer.parseInt(sDan);
		}
		
		String gubunTag = "<br />";
		
		for(int i = 2; i <= 9; i++ ) {
			out.println("<ul style='display:inline-block;'>");
			for(int j = 1; j <= 9; j++) {
				out.println("<li>" +i+" * "+j+" =\t"+(i*j)+"</li>");
			}
			out.println("</ul>");
			out.print(gubunTag.repeat(dan%i));
		}
	}
}
