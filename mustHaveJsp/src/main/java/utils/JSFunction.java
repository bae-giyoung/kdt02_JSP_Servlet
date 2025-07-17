package utils;

import java.io.PrintWriter;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.jsp.JspWriter;

public class JSFunction {
	// 메시지 알림창을 띄운 후 명시한 URL로 이동합니다.
	public static void alertLocation(String msg, String url, JspWriter out) {
		try {
			String script = ""
						  + "<script>"
						  + "	alert('"+ msg + "');"
						  + "	location.href='"+ url +"';" // 네트워크 보고 싶어서 일단 주석처리!
						  + "</script>";
			out.println(script);
		}
		catch (Exception e) {}
	}
	
	// 메시지 알림창을 띄운 후 명시한 URL로 이동합니다.
	public static void alertLocation(HttpServletResponse resp, String msg, String url) {
		try {
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = resp.getWriter();
			String script = ""
						  + "<script>"
						  + "	alert('"+ msg + "');"
						  + "	location.href='"+ url +"';" // 네트워크 보고 싶어서 일단 주석처리!
						  + "</script>";
			writer.println(script);
		}
		catch (Exception e) {}
	}
	
	
	// 메시지 알림창을 띄운 후 이전 페이지로 돌아갑니다.
	public static void alertBack(String msg, JspWriter out) {
		try {
			String script = ""
						  + "<script>"
						  + "	alert('"+msg+"');"
						  + "	history.back();"
						  + "</script>";
			out.println(script);
		}
		catch (Exception e) {}
	}
	
	// 메시지 알림창을 띄운 후 이전 페이지로 돌아갑니다.
	public static void alertBack(HttpServletResponse resp, String msg) {
		try {
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = resp.getWriter();
			String script = ""
					+ "<script>"
					+ "	alert('"+ msg + "');"
					+ "	history.back();"
					+ "</script>";
			writer.println(script);
		}
		catch (Exception e) {}
	}
	
}
