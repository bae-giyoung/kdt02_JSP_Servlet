package model2.mvcboard;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.JDBConnect;
import jakarta.servlet.ServletContext;

public class MVCBoardDAO extends JDBConnect {
	public MVCBoardDAO() {
		super();
	}
	
	public MVCBoardDAO(ServletContext application) {
		super(application);
	}
	
	// 검색 조건에 맞는 게시물 개수를 반환
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		// 쿼리문 준비
		String query = "SELECT COUNT(*) FROM mvcboard";
		
		// 검색 조건이 있다면 WHERE절 추가
		if(map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%'";
		}
		
		try {
			stmt = getCon().createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			totalCount = rs.getInt(1); // 검색된 게시물 개수 저장
			
		} catch (Exception e) {
			System.out.println("게시물 카운트 중 예외 발생");
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
			} catch (Exception e) {}
		}
		
		return totalCount; // 게시물 개수를 서블릿으로 반환
	}
	
	// 검색 조건에 맞는 게시물 목록을 반환 (페이징 기능 지원)
	public List<MVCBoardDTO> selectListPage(Map<String,Object> map) {
		List<MVCBoardDTO> board = new Vector<MVCBoardDTO>();
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		// 쿼리문 준비
		String query = "SELECT * FROM mvcboard ";
		
		// 검색 조건이 있다면
		if(map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%' ";
		}
		
		query += " ORDER BY idx DESC limit ?, ? ";
		
		try {
			psmt = getCon().prepareStatement(query); // 동적 쿼리문 생성
			psmt.setInt(1, (int)map.get("start")); // 데이터 타입 반드시 지킬것! -> setString으로 했을 때 오류 났던것 한번 더 살펴보기!
			psmt.setInt(2, (int)map.get("pageSize"));
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				MVCBoardDTO dto = new MVCBoardDTO();
				
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));
				dto.setPass(rs.getString(9));
				dto.setVisitcount(rs.getInt(10));
				
				board.add(dto);
			}
			
		} catch (Exception e) {
			System.out.println("게시물 카운트 중 예외 발생");
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(psmt != null) psmt.close();
			} catch (Exception e) {}
		}
		
		return board; // 목록 반환
	}
	
	// 게시글 데이터를 받아 DB에 추가(파일 업로드 지원)
	public int insertWrite(MVCBoardDTO dto) {
		int result = 0;
		PreparedStatement psmt = null;
		String query = "INSERT INTO mvcboard ( name, title, content, ofile, sfile, pass) "
				+ " VALUES (?, ?, ?, ?, ?, ?)";
		
		try {
			psmt = getCon().prepareStatement(query);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getPass());
			
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		} finally {
			try {
				if(psmt != null) psmt.close();
			} catch (Exception e) {}
		}
		
		return result;
	}
	
	// 주어진 일련번호에 해당하는 게시물을 DTO에 담아 반환
	public MVCBoardDTO selectView(String idx) {
		MVCBoardDTO dto = new MVCBoardDTO(); // DTO 객체 생성
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String query = "SELECT * FROM mvcboard WHERE idx=?";
		
		try {
			psmt = getCon().prepareStatement(query);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
			
			while(rs.next()) { // 결과를 dto 객체에 저장
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));
				dto.setPass(rs.getString(9));
				dto.setVisitcount(rs.getInt(10));
			}
			
		} catch (Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(psmt != null) psmt.close();
			} catch (Exception e) {}
		}
		
		return dto; // 결과 반환
	}
	
	// 주어진 일련번호에 해당하는 게시물의 조회수를 1 증가시킴
	public void updateVisitCount(String idx) {
		PreparedStatement psmt = null;
		String query = "UPDATE mvcboard SET "
				+ " visitcount=visitcount+1 "
				+ " WHERE idx=?";
		
		try {
			psmt = getCon().prepareStatement(query);
			psmt.setString(1, idx);
			psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		} finally {
			try {
				if(psmt != null) psmt.close();
			} catch (Exception e) {}
		}
	}
	
	// 다운로드 횟수를 1 증가
	public void downCountPlus(String idx) {
		PreparedStatement psmt = null;
		String query = "UPDATE mvcboard SET "
				+ " downcount=downcount+1 "
				+ " WHERE idx=?";
		
		try {
			psmt = getCon().prepareStatement(query);
			psmt.setString(1, idx);
			psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("다운로드수 증가 중 예외 발생");
			e.printStackTrace();
		} finally {
			try {
				if(psmt != null) psmt.close();
			} catch (Exception e) {}
		}
	}
}
