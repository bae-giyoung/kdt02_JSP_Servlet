package model1.board;

import java.sql.PreparedStatement;
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
			query += " WHERE " + map.get("searchField") + " " + "LIKE '%" + map.get("searchWord") + "%'";
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
			query += " WHERE " + map.get("searchField") + " " + "LIKE '%" + map.get("searchWord") + "%'";
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
	
	// 검색 조건에 맞는 게시물 목록을 반환 (페이징 기능 지원)
	public List<BoardDTO> selectListPage(Map<String, Object> map) {
		List<BoardDTO> bbs = new Vector<BoardDTO>(); // 결과(게시물 목록)을 담을 변수
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		// 쿼리문 템플릿
		String query = "SELECT * FROM board";
		
		// 검색 조건 추가 -> 검색 조건이 있다면!
		if(map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%' ";
		}
		
		query += " ORDER BY num DESC limit ?, ?";
		
		try {
			// 쿼리문 완성
			psmt = getCon().prepareStatement(query);
			psmt.setInt(1, (int)map.get("start"));
			psmt.setInt(2, (int)map.get("pageSize"));
			
			// 쿼리문 실행
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				// 한 행(게시물 하나)의 데이터를 DTO에 저장
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getString("num")); // 일련번호
				dto.setTitle(rs.getString("title")); // 제목
				dto.setContent(rs.getString("content")); // 내용
				dto.setPostdate(rs.getDate("postdate")); // 작성일
				dto.setId(rs.getString("id")); // 작성자 아이디
				dto.setVisitcount(rs.getString("visitCount")); // 조회수
				
				// 반환할 결과 목록에 게시물 추가
				bbs.add(dto);
			}
			
		} catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(psmt != null) psmt.close();
			} catch(Exception e) {}
		}
		
		return bbs;
	}
	
	// 게시글 데이터를 받아 DB에 추가
	public int insertWrite(BoardDTO dto) {
		int result = 0;
		PreparedStatement psmt = null;
		
		try {
			// INSERT 쿼리문 작성
			String query = "INSERT INTO board ("
						+ " title, content, id, visitcount)"
						+ " VALUES ("
						+ " ?, ?, ?, 0)";
			
			psmt = getCon().prepareStatement(query); // 동적 쿼리
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			
			result = psmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		} finally {
			try {
				if(psmt != null) psmt.close();
			} catch(Exception e) {}
		}
		
		return result;
	}
	
	// 지정한 게시물을 찾아 내용을 반환
	public BoardDTO selectView(String num) {
		BoardDTO dto = new BoardDTO();
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		// 쿼리문 준비
		String query = "SELECT B.*, M.name"
					+ " FROM member M INNER JOIN board B"
					+ " ON M.id=B.id"
					+ " WHERE num=?";
		
		try {
			psmt = getCon().prepareStatement(query);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			
			// 결과 처리
			if(rs.next()) {
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				dto.setName(rs.getString("name"));
			}
			
		} catch(Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(psmt != null) psmt.close();
			} catch(Exception e) {}
		}
		
		return dto;
	}
	
	// 지정한 게시물의 조회수를 1 증가시키는 메서드
	public void updateVisitCount(String num) {
		PreparedStatement psmt = null;
		
		// 쿼리문 준비
		String query = "UPDATE board SET"
					+ " visitcount=visitcount+1"
					+ " WHERE num=?";
		
		try {
			psmt = getCon().prepareStatement(query);
			psmt.setString(1, num); // 인파라미터를 일련번호로 설정
			psmt.executeUpdate(); // 쿼리 실행 <= 여기를 교재에서는 업데이트한 행의 개수를 알 필요가 없다면 executeQuery()를 사용해도 무방하다고 했는데, 오류남. 오라클db와 mysql의 차이일까?
		} catch(Exception e) {
			System.out.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		} finally {
			try {
				if(psmt != null) psmt.close();
			} catch(Exception e) {}
		}
	}
	
	// 지정한 게시물 수정
	public int updateEdit(BoardDTO dto) {
		int result = 0;
		PreparedStatement psmt = null;
		
		try {
			// 쿼리문 템플릿
			String query = "UPDATE board SET"
						+ " title=?, content=?"
						+ " WHERE num=?";
			
			// 쿼리문 완성
			psmt = getCon().prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getNum());
			
			// 쿼리문 실행
			result = psmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("게시물 수정 중 실패");
			e.printStackTrace();
		} finally {
			try {
				if(psmt != null) psmt.close();
			} catch(Exception e) {}
		}
		
		return result; // 결과 반환 (count of affected rows)
	}
	
	// 지정한 게시물 삭제
	public int deletePost(BoardDTO dto) {
		int result = 0;
		PreparedStatement psmt = null;
		
		// 쿼리문 템플릿
		String query = "DELETE FROM board WHERE num=?";
		
		try {
			// 쿼리문 완성
			psmt = getCon().prepareStatement(query);
			psmt.setString(1, dto.getNum());
			
			// 쿼리문 실행
			result = psmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("게시물 삭제 중 실패");
			e.printStackTrace();
		} finally {
			try {
				if(psmt != null) psmt.close();
			} catch(Exception e) {}
		}
		
		
		return result; // 결과 반환
	}
}
