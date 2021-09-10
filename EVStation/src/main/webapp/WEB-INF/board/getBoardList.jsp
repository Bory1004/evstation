<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>자유 게시판</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
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
	width: 700px;
	margin-left: auto;
	margin-right: auto;
}

table {
	width: 700px;
	border-collapse: collapse;
}

th {
	width: 150px;
}

a {
	margin: 10px auto;
}

#page {
	text-align: center;
}
</style>
</head>
<body>

	<div class="container">
		<header class="py-3">
			<div class="row justify-content-center">

				<div class="col-6 pt-2">
					<a href="/" class="link-secondary"> 
					<img src="/img/logo.png" width="200" height="100">
					</a>
					<!--  <a class="link-secondary" href="#">Subscribe</a> -->
				</div>

				<div class="col-6 d-flex justify-content-end align-items-center">
					<!-- justify-content 자식요소 정렬  -->
					<div> 
						${member.id}님 환영합니다!
						<a class="btn btn-sm btn-outline-success" href="logout">로그아웃</a>
					</div>
				</div>

			</div>

			<div class="menubar py-1 mb-2">
				<nav class="nav d-flex justify-content-center border-top border-bottom">
					<a class="p-2  link-success" href="#">페이지 소개</a> 
					<a class="p-2 link-success" href="reviewList">충전소 현황</a> 
					<a class="p-2 link-success" href="#">기대효과</a> 
					<a class="p-2 link-success" href="#">자유게시판</a> 
					<a class="p-2 link-success" href="#">공지사항</a> 
					<a class="p-2 link-success" href="#">Q&A</a>
				</nav>
			</div>
		</header>
	</div>


	<div id="center">
		<h1>게시글 목록</h1>
		<div align="right">
			<a href="updateForm">회원수정</a><a href="insertBoard">새글 등록</a> 
			<a href="getBoardList">전체 글 목록</a>
		</div>
		<c:if test="${board.boardnum == comment.boardnum}">
		<c:if test="${total != 0}">
			<table border="1">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
					<th>조회수</th>
				</tr>
				<c:forEach items="${blist}" var="board">
					<tr>
						<td>${board.boardnum}</td>
						<td><a href="/content/${board.boardnum}">${board.boardtitle}</a></td>
						<td>${board.boardwriter}</td>
						<td><fmt:formatDate value="${board.boarddate}" pattern="MM.dd" /></td>
						<td>${board.boardsee}</td>
					</tr>
				</c:forEach>
			</table>

			<div id="page">
				<c:if test="${search == null}">
					<c:if test="${begin > 2}">
						<a href="/getBoardList?p=${begin-1}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin}" end="${end}" var="i">
						<a href="/getBoardList?p=${i}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage}">
						<a href="/getBoardList?p=${end+1}">[다음]</a>
					</c:if>
				</c:if>
				<c:if test="${search != null}">
					<c:if test="${begin > 2}">
						<a href="/getBoardList?p=${begin-1}&search=${search}&searchn=${searchn}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin}" end="${end}" var="i">
						<a href="/getBoardList?p=${i}&search=${search}&searchn=${searchn}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage}">
						<a href="/getBoardList?p=${end+1}&search=${search}&searchn=${searchn}">[다음]</a>
					</c:if>
				</c:if>

			</div>
		</c:if>
		<c:if test="${total == 0}">검색 결과가 없습니다.</c:if>
		<form>
			<select name="searchn">
				<option value="0">제목</option>
				<option value="1">내용</option>
				<option value="2">작성자</option>
			</select> 
			<input type="text" name="search" size="15" maxlength="50" />
			<input type="submit" value="검색" />
		</form>
		</c:if>
	</div>
	
	<footer class="container-fluid my-3 d-flex justify-content-center align-items-center border-top" style="height: 100px;">
		<div class="row">
			<div class="col-12 pt-3">
				<p>Project built for <a href="#">Portfolio</a> by <a href="#">Team2</a>.</p>
				<p>Copyright @ 2021 EvStation</p>
			</div>
		</div>
	</footer>
	
</body>
</html>




