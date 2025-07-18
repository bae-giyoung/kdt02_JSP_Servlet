package model2.mvcboard;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.BoardPage;

public class ListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ServletContext application = getServletContext();
		
		// DAO 생성
//		MVCBoardDAO dao = new MVCBoardDAO();
		MVCBoardDAO dao = new MVCBoardDAO(application);
		
		// 뷰에 전달할 매개 변수 저장용 맵 생성
		Map<String, Object> map = new HashMap<String, Object>();
		
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		
		if(searchWord != null) {
			// 쿼리 스트링으로 전달받은 매개변수 중 검색어가 있다면 map에 저장
			map.put("searchField", searchField);
			map.put("searchWord", searchWord);
		}
		
		int totalCount = dao.selectCount(map); // 게지물 개수
		
		
		/* 페이지 처리 start */
		int pageSize =  Integer.parseInt(application.getInitParameter("POST_PER_PAGE"));
		int blockPage =  Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
		
		// 현재 페이지 확인
		int pageNum = 1; // 기본값
		String pageTemp = req.getParameter("pageNum");
		if(pageTemp != null && !pageTemp.equals(""))
			pageNum = Integer.parseInt(pageTemp); // 요청받은 페이지로 수정
		
		// 목록에 출력할 게시물 범위 확인
		int start = (pageNum - 1) * pageSize; // 첫 개시물 번호 - MySQL은 0부터 시작
		map.put("start", start);
		map.put("pageSize", pageSize);
		/* 페이지 처리 end */
		
		
		// 게시물 목록 받기
		List<MVCBoardDTO> boardLists = dao.selectListPage(map);		
		dao.close(); // DB 연결 닫기
		
		// 뷰에 전달할 매개변수 추가 // 바로가기 영역 HTML 문자열
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, "../mvcboard/list.do");
		map.put("pagingImg", pagingImg);
		map.put("totalCount", totalCount);
		map.put("pageSize", pageSize);
		map.put("pageNum", pageNum);
		
		// 전달된 데이터를 request 영역에 저장 후 List.jsp로 포워드
		req.setAttribute("boardLists", boardLists);
		req.setAttribute("map", map);
		req.getRequestDispatcher("/14MVCBoard/List.jsp").forward(req, resp);
		
	}
}
