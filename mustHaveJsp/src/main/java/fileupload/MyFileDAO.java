package fileupload;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import common.JDBConnect;

public class MyFileDAO extends JDBConnect {
	// 새로운 게시물을 입력합니다.
	public int insertFile(MyFileDTO dto) {
		int applyResult = 0;
		PreparedStatement psmt = null;
		
		try {
			
			String query = "INSERT INTO myfile ( "
					+ " title, cate, ofile, sfile) "
					+ " VALUES ( "
					+ " ?, ?, ?, ? );";
			
			psmt = getCon().prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getCate());
			psmt.setString(3, dto.getOfile());
			psmt.setString(4, dto.getSfile());
			
			applyResult = psmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("INSERT 중 에러 발생");
			e.printStackTrace();
		} finally {
			try {
				if(psmt != null) psmt.close();
			} catch(Exception e) {}
		}
		
		return applyResult;
	}
	
	// 파일 목록을 반환
	public List<MyFileDTO> myFileList() {
		List<MyFileDTO> fileList = new Vector<MyFileDTO>();
		Statement stmt = null;
		ResultSet rs = null;
		
		// 쿼리문 작성
		String query = "SELECT * FROM myfile ORDER BY idx DESC";
		try {
			stmt = getCon().createStatement();
			rs = stmt.executeQuery(query);
			
			while(rs.next()) {
				// DTO에 저장
				MyFileDTO dto = new MyFileDTO();
				dto.setIdx(rs.getString(1));
				dto.setTitle(rs.getString(2));
				dto.setCate(rs.getString(3));
				dto.setOfile(rs.getString(4));
				dto.setSfile(rs.getString(5));
				dto.setPostdate(rs.getString(6));
				
				fileList.add(dto); // 목록에 추가
				
			}
		} catch (Exception e) {
			System.out.println("SELECT 시 예외 발생");
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
			} catch(Exception e) {}
			
		}
		
		return fileList; // 목록 반환
	}
}
