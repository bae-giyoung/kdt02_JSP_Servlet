package edu.pnu.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/musthave")
public class MyServletTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println(req.getParameter("table"));
		String tableName = req.getParameter("table");
		
		if (tableName == null) {
			System.out.println("table query string을 포함한 url로 다시 요청해주세요. ( ?table=member 또는 ?table=board )");
			return;
		}
		
		if (tableName.equals("board")) {
			req.setAttribute("table", tableName);
			req.getRequestDispatcher("/tablepack/Board.jsp").forward(req, resp);
			
		} else if (tableName.equals("member")) {
			req.setAttribute("table", tableName);
			req.getRequestDispatcher("/tablepack/Member.jsp").forward(req, resp);
			
		} else {
			System.out.println("table query string을 포함한 url로 다시 요청해주세요. ( ?table=member 또는 ?table=board )");
		}
	}
}
