<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>리뷰리스트</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
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

a {
	text-decoration-line: none;
}
</style>
</head>
<body>
	<div class="container">
		<header class="py-3">
			<div class="row justify-content-center  ">

				<div class="col-6 pt-2">
					<a href="#" class="link-secondary"> <img src="./img/logo.png"
						width="200" height="100">
					</a>
					<!--  <a class="link-secondary" href="#">Subscribe</a> -->
				</div>

				<div class="col-6 d-flex justify-content-end align-items-center">
					<!-- justify-content 자식요소 정렬  -->
					<div>
						<a class="btn btn-sm btn-outline-success" href="#">로그인</a> <a
							class="btn btn-sm btn-outline-success" href="#">회원가입</a>
					</div>
				</div>

			</div>
		</header>

		<div class="menubar py-1 mb-2">
			<nav
				class="nav d-flex justify-content-center border-top border-bottom">
				<a class="p-2  link-success" href="#">페이지 소개</a> <a
					class="p-2 link-success" href="reviewList">충전소 현황</a> <a
					class="p-2 link-success" href="#">기대효과</a> <a
					class="p-2 link-success" href="#">자유게시판</a> <a
					class="p-2 link-success" href="#">공지사항</a> <a
					class="p-2 link-success" href="#">Q&A</a>
			</nav>
		</div>
	</div>


	<main>
		<div class="container input-group d-flex justify-content-center">

			<div class="w-100 input-group justify-content-center">
				<h1 class="mb-3 text-success">리뷰 게시판</h1>
				<c:if test="${ total != 0}">
					<table class="table table-hover table-striped text-center" >
						<tr>
							<th>No.</th>
							<th>작성글</th>
							<th>작성자</th>
							<th>날짜</th>
							<th>추천수</th>
							<th>조회수</th>
						</tr>
						<c:forEach items="${rList}" var="board">
							<tr>
								<td>${board.boardnum}</td>
								<td><a href="/content/${board.boardnum}" class="text-success">${board.boardtitle}</a></td>
								<td>${board.boardwriter}</td>
								<td><fmt:formatDate value="${board.boarddate}"
										pattern="MM.dd" /></td>
								<td>${board.boardsee}</td>
								<td>${board.boardrecom}</td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
				<c:if test="${total == 0}">
				검색 결과가 없습니다.
				</c:if>
			
			</div>
		

				<div id="page">
						<c:if test="${search == null }">
						<nav aria-label="Page navigation">
						<ul class="pagination">
							<c:if test="${begin > 5 }">
								<li class="page-item"><a class="page-link"  aria-label="Previous" class="page-link"  aria-label="Previous" href="/reviewList?p=${begin-1}"><span aria-hidden="true">&laquo;</span></a></li>
							</c:if>
							<c:forEach begin="${begin }" end="${end}" var="i">
								<li class="page-item"><a class="page-link" href="/reviewList?p=${i}">${i}</a></li>
							</c:forEach>
							<c:if test="${end < totalPage }">
								<li class="page-item"><a class="page-link"  aria-label="Next" class="page-link"  aria-label="Next" href="/reviewList?p=${end+1}"><span aria-hidden="true">&raquo;</span></a></li>
							</c:if>
						</ul>
						</nav>
						</c:if>

						<c:if test="${search != null }">
						<nav aria-label="Page navigation">
						<ul class="pagination">
							<c:if test="${begin > 5 }">
								<li class="page-item"><a class="page-link"  aria-label="Previous" href="/reviewList?p=${begin-1}&search=${search}&searchn=${searchn}"><span aria-hidden="true">&laquo;</span></a></li>
							</c:if>
							<c:forEach begin="${begin }" end="${end}" var="i">
								<li class="page-item"><a class="page-link" href="/reviewList?p=${i}&search=${search}&searchn=${searchn}">${i}</a></li>
							</c:forEach>
							<c:if test="${end < totalPage }">
								<li class="page-item"><a class="page-link"  aria-label="Next" href="/reviewList?p=${end+1}&search=${search}&searchn=${searchn}"><span aria-hidden="true">&raquo;</span></a></li>
							</c:if>
						</ul>
						</nav>
						</c:if>
					
				</div>
	
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
	<c:forEach items="${rlist}" var="board">
							<tr>
								<td>${board.board_num}</td>
								<td><a href="/content/${board.boardnum}">${board.boardtitle}</a></td>
								<td>${board.boardwriter}</td>
								<td><fmt:formatDate value="${board.boarddate}"
										pattern="MM.dd" /></td>
								<td>${board.boardsee}</td>
							</tr>
						</c:forEach>
	</footer>
				<c:forEach items="${rlist}" var="board">
							<tr>
								<td>${board.boardnum}</td>
								<td><a href="/content/${board.boardnum}">${board.boardtitle}</a></td>
								<td>${board.boardwriter}</td>
								<td><fmt:formatDate value="${board.boarddate}"
										pattern="MM.dd" /></td>
								<td>${board.boardsee}</td>
							</tr>
						</c:forEach>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>

</html>