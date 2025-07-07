package model1.board;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.JDBConnect;
import jakarta.servlet.ServletContext;

public class BoardDAO extends JDBConnect {
	public BoardDAO(ServletContext application) {
		super(application);
	}
	
	// 검색 조건에 맞는 게시물의 개수를 반환한다.
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;// 결과(게시물 수)를 담을 변수
		Statement stmt = null;
		ResultSet rs = null;
		
		// 게시물 수를 얻어오는 쿼리문 작성
		String query = "SELECT COUNT(*) FROM board";
		if(map.get("searchWord") != null) {
			query += "WHERE " + map.get("searchField") + " " + "LIKE '%" + map.get("searchWord") + "%'";
		}
		
		try {
			stmt = this.getCon().createStatement(); // 쿼리문 생성 // 왜 con필드는 부모 영역 인스턴스 레벨의 필드인데 그냥 con으로는 접근이 안되는가? 부모영역의 private 필드는 자식 클래스에서도 접근이 안되는 것인가? 
			rs = stmt.executeQuery(query); // 쿼리문 실행
			rs.next(); // 커서를 첫 번째 행으로 이동
			totalCount = rs.getInt(1); // 첫 번째 컬럼 값을 가져옴
		} catch (Exception e) {
			System.out.println("게시물 수를 구하는 중 예외 발생");
			e.printStackTrace();
		} finally {
				try {
					if(rs != null) rs.close();
					if(stmt != null) stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		
		return totalCount;
	}
	
	// 게시물 목록 가져오기
	public List<BoardDTO> selectList(Map<String, Object> map) {
		List<BoardDTO> bbs = new Vector<BoardDTO>(); // Vector에 대해 더 알아보기! // 결과 (게시물 목록)을 담을 변수
		Statement stmt = null;
		ResultSet rs = null;
		
		String query = "SELECT * FROM board";
		if(map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " " + "LIKE '%" + map.get("searchWorld") + "%'";
		}
		query += " ORDER BY num DESC";
		
		try {
			stmt = getCon().createStatement();
			rs = stmt.executeQuery(query);
			
			while (rs.next()) {// ResultSet 결과를 순회하며
				// 한 행(게시물 하나)의 내용을 DTO에 저장
				BoardDTO dto = new BoardDTO();
				
				dto.setNum(rs.getString("num")); // 일련번호
				dto.setTitle(rs.getString("title")); // 제목
				dto.setContent(rs.getString("content")); // 내용
				dto.setPostdate(rs.getDate("postdate")); // 작성일
				dto.setId(rs.getString("id")); // 작성자 아이디
				dto.setVisitcount(rs.getString("visitCount")); // 조회수
				
				bbs.add(dto); // 결과 목록에 저장
			}
			
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
			} catch (Exception e) {e.printStackTrace();}
		}
		
		return bbs;
	}
}
