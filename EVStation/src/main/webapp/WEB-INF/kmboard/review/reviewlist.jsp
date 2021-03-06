<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>충전소현황</title>
<style>
@media ( min-width : 768px) {
	.container {
		width: 750px
	}
}

@media ( min-width : 992px) {
	.container {
		width: 940px
	}
}
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
	<%@ include file="/WEB-INF/DsBoard/DsLayout/dsHeaderNormal.jsp"%>

	<main>
	<!-- <div id="group-area" class="">
		아이디
	</div> -->
	<div id="center">
		<h4>리뷰 게시판</h4>
		<a href="/reviewList"><small class="text-muted">리뷰 게시판 전체 목록 ></small></a>
		
		<div id="search_msg"><h4>${search_msg}</h4></div>
		
		<c:if test="${total == 0}">검색 결과가 없습니다.</c:if>	
		<c:if test="${total != 0}">
			<table style="text-align: center;vertical-align:middle;" class="table table-hover caption-top">				
				<thead class="table-light">
				<tr>
					<th scope="col">번호</th>
					<th style="width: 300px;" scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">등록일</th>
					<th scope="col">조회수</th>
				</tr>
				</thead>
				<c:forEach items="${rList}" var="board">
					<tr>
						<td>${board.boardnum}</td>
						<td><a href="/content/2/${board.boardnum}"><c:if test="${board.boardthumbnail != null }"><img src="${board.boardthumbnail}" style="width:60px;height:60px;"></c:if> ${board.boardtitle}</a></td>
						<td>${board.member.id}</td>
						<td><fmt:formatDate value="${board.boarddate}" pattern="MM.dd"/></td>
						<td>${board.boardsee}</td>
					</tr>
				</c:forEach>
			</table>
			<div id="page">
				<c:if test="${search == null}">
					<c:if test="${begin > 2}">
						<a href="/reviewList?p=${begin-1}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin}" end="${end}" var="i">
						<a href="/reviewList?p=${i}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage}">
						<a href="/reviewList?p=${end+1}">[다음]</a>
					</c:if>
				</c:if>
				<c:if test="${search != null}">
					<c:if test="${begin > 2}">
						<a href="/reviewList?p=${begin-1}&search=${search}&searchn=${searchn}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin}" end="${end}" var="i">
						<a href="/reviewList?p=${i}&search=${search}&searchn=${searchn}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage}">
						<a href="/reviewList?p=${end+1}&search=${search}&searchn=${searchn}">[다음]</a>
					</c:if>
				</c:if>
			</div>
		</c:if>
		<div align="right">
			<a class="btn btn-outline-secondary btn-sm" href="reviewwrite?stnum=${stnum}">
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


	<!-- 푸터    -->
	<footer
		class="container-fluid my-3 d-flex justify-content-center align-items-center border-top"
		style="height: 100px;">

		<div class="row">
			<div class="col-12 pt-3">
				<p>
					Project built for <a href="#">Portfolio</a> by <a href="#">Team
						2</a>.
				</p>
				<p>Copyright @ 2021 EvStation</p>
			</div>
		</div>
		
	</footer>
</body>

</html>