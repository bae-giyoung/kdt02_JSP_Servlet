package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.ServletContext;

public class JDBConnect {
	private Connection con;
	//public Statement stmt; -> Connection 외에는 필드로 사용하는 것보다는 로컬에서 사용하고 닫는 것이 좋다!
	//public PreparedStatement psmt;
	//public ResultSet rs;
	
	// 기본 생성자
	public JDBConnect() {
		try {
			// JDBC 드리이버 로드
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			// DB에 연결
			String url = "jdbc:mysql://localhost:3306/musthave";
			String id = "musthave";
			String pwd = "tiger";
			con  = DriverManager.getConnection(url, id, pwd);
			
			System.out.println("DB에 연결 성공(기본 생성자)");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 생성자 오버로딩
	public JDBConnect(String driver, String url, String id, String pwd) {
		try {
			// JDBC 드리이버 로드
			Class.forName(driver);
			
			// DB에 연결
			con  = DriverManager.getConnection(url, id, pwd);
			
			System.out.println("DB에 연결 성공(인수 생성자 1)");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 생성자 오버로딩
	public JDBConnect(ServletContext application) {
		try {
			String driver = application.getInitParameter("MySQLDriver");
			String url = application.getInitParameter("MySQLURL");
			String id = application.getInitParameter("MySQLID");
			String pwd = application.getInitParameter("MySQLPwd");
			
			// JDBC 드리이버 로드
			Class.forName(driver);
			
			// DB에 연결
			con  = DriverManager.getConnection(url, id, pwd);
			
			System.out.println("DB에 연결 성공(인수 생성자 2)");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public Connection getCon() {
		return con;
	}
	
	// 연결 해제(자원 반납)
	public void close() {
		try {
			//if (rs != null) rs.close();
			//if (stmt != null) stmt.close();
			//if (psmt != null) psmt.close();
			if (con != null) con.close();
			
			System.out.println("JDBC 자원 해제");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
