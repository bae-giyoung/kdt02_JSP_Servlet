package membership;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.JDBConnect;

public class MemberDAO extends JDBConnect {
	// 명시한 데이터베이스로의 연결이 완료된 MemberDAO 객체를 생성한다.
	public MemberDAO(String drv, String url, String id, String pw) {
		super(drv, url, id, pw);
	}
	
	// 명시한 아이디/패스워드와 일치하는 회원 정보를 반환한다.
	public MemberDTO getMemberDTO(String uid, String upass) {
		Connection con = super.getCon();
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDTO dto = new MemberDTO();
		String query = "SELECT * FROM member WHERE id=? AND pass=?";
		
		try {
			// 쿼리 실행
			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			rs = psmt.executeQuery();
			
			// 결과 처리
			if(rs.next()) {
				// 쿼리 결과로 얻은 회원 정보를 DTO객체에 저장
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString(3));
				dto.setRegidate(rs.getString(4));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
				try {
					if(rs != null) rs.close(); 
					if(psmt != null) psmt.close();
					if(con != null) con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		
		return dto;
	}

	public static void main(String[] args) {
		MemberDAO dao = new MemberDAO("com.mysql.cj.jdbc.Driver", "jdbc:mysql://localhost:3306/musthave", "root", "tiger");
		MemberDTO dto = dao.getMemberDTO("test1", "1111");
		System.out.println("dto 객체:\t" + dto);
		System.out.println("아이디:\t" + dto.getId());
		System.out.println("성명:\t" + dto.getName());
		System.out.println("비밀번호:\t" + dto.getPass());
		System.out.println("등록일:\t" + dto.getRegidate());
	}

}
