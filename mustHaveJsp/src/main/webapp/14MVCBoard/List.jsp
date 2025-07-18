<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<style>a{text-decoration:none;}</style>
</head>
<body>
	<h2>파일 첨부형 게시판 - 목록 보기(List)</h2>
	
	<!-- 검색 폼 -->
	<form method="get">
		<table border="1" width="90%">
			<tr>
				<td align="center">
					<select name="searchField">
						<option value="title" <c:if test="${ param.searchField == 'title' }">selected</c:if>>제목</option>
						<option value="content" <c:if test="${ param.searchField == 'content' }">selected</c:if>>내용</option>
					</select>
					<input type="text" name="searchWord" value="${ param.searchWord }" />
					<input type="submit" value="검색하기" />
				</td>
			</tr>
		</table>
	</form>
	
	<!-- 목록 테이블 -->
	<table border="1" width="90%">
		<colgroup>
			<col width="10%" />
			<col width="*" />
			<col width="15%" />
			<col width="10%" />
			<col width="15%" />
			<col width="8%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">조회수</th>
				<th scope="col">작성일</th>
				<th scope="col">첨부</th>
			</tr>
		</thead>
		<tbody>
		<c:choose>
		<c:when test="${ empty boardLists }">
			<tr>
				<td colspan="6" align="center">등록된 게시물이 없습니다^^*</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${ boardLists }" var="row" varStatus="loop">
			<tr>
				<td align="left"><!-- 번호 -->
					${ map.totalCount - (((map.pageNum - 1)*map.pageSize) + loop.index) }
				</td>
				<td align="left"><!-- 제목(링크) -->
					<a href="../mvcboard/view.do?idx=${ row.getIdx() }&pageNum=${map.pageNum}">${ row.getTitle() }</a>
				</td>
				<td align="left"><!-- 작성자 -->
					${ row.getName() }
				</td>
				<td align="left"><!-- 조회수 -->
					${ row.getVisitcount() }
				</td>
				<td align="left"><!-- 작성일 -->
					${ row.getPostdate() }
				</td>
				<td align="left"><!-- 첨부 파일 -->
				<c:if test="${ not empty row.getOfile() }">
					<a href="../mvcboard/download.do?ofile=${ row.getOfile() }&sfile=${row.getSfile()}&idx=${row.getIdx()}">[Down]</a>
				</c:if>
				</td>
			</tr>
			</c:forEach>
		</c:otherwise>
		</c:choose>
		</tbody>
	</table>
	
	<!-- 하단 메뉴 (바로가기, 글쓰기) -->
	<table border="1" width="90%">
		<tr align="center">
			<td>
				${ map.pagingImg }
			</td>
			<td width="100">
				<button type="button" onclick="location.href='../mvcboard/write.do'">글쓰기</button>
			</td>
		</tr>
	</table>
</body>
</html>