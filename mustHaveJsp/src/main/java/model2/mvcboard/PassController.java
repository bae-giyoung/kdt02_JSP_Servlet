package model2.mvcboard;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

@WebServlet("/mvcboard/pass.do")
public class PassController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("mode", req.getParameter("mode"));
		req.getRequestDispatcher("/14MVCBoard/Pass.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 매개변수 저장
		String idx = req.getParameter("idx");
		String mode = req.getParameter("mode");
		String pass = req.getParameter("pass");
		String pageNum = req.getParameter("pageNum");
		
		// 비밀번호 저장
		ServletContext application = req.getServletContext();
		MVCBoardDAO dao = new MVCBoardDAO(application);
		boolean confirmed = dao.confirmPassword(pass, idx);
		
		if(confirmed) { // 비밀번호 일치
			if(mode.equals("edit")) { // 수정 모드
				dao.close();
				HttpSession session = req.getSession();
				session.setAttribute("pass", pass);
				resp.sendRedirect("../mvcboard/edit.do?idx=" + idx + "&pageNum=" + pageNum);
			}
			else if(mode.equals("delete")) { // 삭제 모드
				MVCBoardDTO dto = dao.selectView(idx);
				int result = dao.deletePost(idx); // 게시물 삭제
				dao.close();
				
				if(result == 1) { // 게시물 삭제 성공 시 첨부 파일도 삭제
					String saveFileName = dto.getSfile();
					FileUtil.deleteFile(req, "/Uploads", saveFileName);
					JSFunction.alertLocation(resp, "삭제되었습니다.", "../mvcboard/list.do");
				} else { // 삭제 실패하면
					JSFunction.alertBack(resp, "삭제 실패");// 없던 코드인데 삭제할까? p.546			
				}
			}
		}
		else { // 비밀번호 불일치
			JSFunction.alertBack(resp, "비밀번호 검증에 실패하였습니다.");
		}
	}
}
