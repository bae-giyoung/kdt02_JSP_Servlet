package board;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import common.JDBConnect;
import jakarta.servlet.ServletContext;

public class BoardDAO extends JDBConnect {
	
	public BoardDAO(ServletContext application) {
		super(application);
	}
	
	public List<BoardDTO> getAllList() {
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		Statement stmt = null;
		ResultSet rs = null;
		String query = "SELECT * FROM board LIMIT 1000";
		
		try {
			// 목록 조회 후, 각 레코드를 dto객체로 저장, list에 순서대로 저장
			stmt = getCon().createStatement();
			rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setId(rs.getString("id"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				list.add(dto);
			}
			
		} catch (Exception e) {
			System.out.println("테이블 조회: SELECT 에서 오류 발생");
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (stmt != null) stmt.close();
			} catch (Exception e) {}
		}
		
		
		return list;
	}
}
