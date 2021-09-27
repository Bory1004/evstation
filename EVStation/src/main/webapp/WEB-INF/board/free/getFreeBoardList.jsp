<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>자유 게시판 전체 목록</title>
<style>
#center {
	width: 800px;
	margin-left: auto;
	margin-right: auto;
}
a {
	text-decoration-line: none;
}
#page {
	text-align: center;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/layout/HeaderFree.jsp"%>
 
	<main>
		<div id="center">
			<h4>자유 게시판</h4>
			<a href="/getFreeBoardList"><small class="text-muted">자유 게시판 전체 목록 ></small></a>
			
			<div id="search_msg"><h4>${search_msg}</h4></div>
			
			<c:if test="${total == 0}">게시물이 없습니다.</c:if>	
	
			<c:if test="${total != 0}">
				<table style="text-align: center" class="table table-hover caption-top">				
					<thead class="table-light">
						<tr>
						<th scope="col">번호</th>
						<th style="width: 300px;" scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">등록일</th>
						<th scope="col">조회수</th>
					</tr>
					</thead>
					<c:forEach items="${blist}" var="board">
						<tr>
							<td>${board.boardnum}</td>
							<td>
								<c:if test="${member.id == null}">
									<a href="/loginView">${board.boardtitle}</a>
								</c:if>
								<c:if test="${member.id != null}">
									<a href="/content/1/${board.boardnum}">${board.boardtitle}</a>
								</c:if>
							</td>								
							<td>${board.member.id}</td>
							<td><fmt:formatDate value="${board.boarddate}" pattern="MM.dd"/></td>
							<td>${board.boardsee}</td>
						</tr>
					</c:forEach>
				</table>
				<div id="page">
				<c:if test="${search == null}">
					<c:if test="${begin > 2}">
						<a href="/getFreeBoardList?p=${begin-1}"><span class="badge bg-light text-dark">이전</span></a>
					</c:if>
					<c:forEach begin="${begin}" end="${end}" var="i">
						<c:if test="${pNum == i}">
							<a href="/getFreeBoardList?p=${i}"><span class="badge bg-secondary">${i}</span></a>
						</c:if>
						<c:if test="${pNum != i}">
							<a href="/getFreeBoardList?p=${i}"><span class="badge bg-light text-dark">${i}</span></a>
						</c:if>
					</c:forEach>
					<c:if test="${end < totalPage}">
						<a href="/getFreeBoardList?p=${end+1}"><span class="badge bg-light text-dark">다음</span></a>
					</c:if>
				</c:if>
				<c:if test="${search != null}">
					<c:if test="${begin > 2}">
						<a href="/getFreeBoardList?p=${begin-1}&search=${search}&searchn=${searchn}"><span class="badge bg-light text-dark">이전</span></a>
					</c:if>
					<c:forEach begin="${begin}" end="${end}" var="i">
						<c:if test="${pNum == i}">
							<a href="/getFreeBoardList?p=${i}&search=${search}&searchn=${searchn}"><span class="badge bg-secondary">${i}</span></a>
						</c:if>
						<c:if test="${pNum != i}">
							<a href="/getFreeBoardList?p=${i}&search=${search}&searchn=${searchn}"><span class="badge bg-light text-dark">${i}</span></a>
						</c:if>
					</c:forEach>
					<c:if test="${end < totalPage}">
						<a href="/getFreeBoardList?p=${end+1}&search=${search}&searchn=${searchn}"><span class="badge bg-light text-dark">다음</span></a>
					</c:if>
				</c:if>
			</div>
			</c:if>
				
			<div align="right">
				<a class="btn btn-outline-secondary btn-sm" href="/insertFreeBoard">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
	  				<path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/>
					</svg>글쓰기</a> 
			</div>			
			<br>		
			<form>
				<div style="width: 400px;" class="input-group">
					<select style="width: 130px;" class="form-select" name="searchn">
						<option value="0">제목</option>
						<option value="1">내용</option>
						<option value="2">작성자</option>
					</select> 
					<input style="width: 200px;" type="text" class="form-control" name="search" size="15" maxlength="50" />
					<input style="width: 70px;" type="submit" class="btn-success" value="검색" />
				</div>
			</form>
		</div>
	</main>
	
	<%@ include file="/WEB-INF/layout/Footer.jsp"%>
	
</body>
</html>




