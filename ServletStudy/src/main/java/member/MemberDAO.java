package member;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import common.JDBConnect;
import jakarta.servlet.ServletContext;

public class MemberDAO extends JDBConnect {
	
	// 생성자
	public MemberDAO(ServletContext application) {
		super(application);
	}
	
	// 리스트 조회
	public List<MemberDTO> getAllList () {
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		Statement stmt = null;
		ResultSet rs = null;
		String query = "SELECT * FROM member LIMIT 1000";
		
		// db 조회 - select query
		// 조회 결과 result set의 모든 record를 순회하며 dto 객체 생성
		// dto 객체를 list에 순서대로 저장
		try  {
			stmt = getCon().createStatement();
			rs = stmt.executeQuery(query);
			
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setPass(rs.getString("pass"));
				dto.setRegidate(rs.getString("regidate"));
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
