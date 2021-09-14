<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>목록보기</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<style>

table {width: 700px;border-collapse: collapse;}
#page{text-align: center;}	

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
<body onload="init()">
	<div class="container">
		<header class="py-3">
			<div class="row justify-content-center  ">

				<div class="col-6 pt-2">
					<a href="/" class="link-secondary"> <img src="/img/logo.png"
						width="200" height="100">
					</a>
					<!--  <a class="link-secondary" href="#">Subscribe</a> -->
				</div>

				<div class="col-6 d-flex justify-content-end align-items-center">
					<!-- justify-content 자식요소 정렬  -->
					<c:choose>
						<c:when test="${member.id eq null}">
							<div>
								<a class="btn btn-sm btn-outline-success" href="../loginView">로그인</a> 
								<a class="btn btn-sm btn-outline-success" href="../joinView">회원가입</a>
							</div>	
						</c:when>
						<c:otherwise>
							${member.id}님 환영합니다!! <a class="btn btn-sm btn-outline-success" href="../logout">로그아웃</a>
						</c:otherwise>						
					</c:choose>
				</div>

			</div>
		</header>

		<div class="menubar py-1 mb-2">
			<nav
				class="nav d-flex justify-content-center border-top border-bottom">
				<a class="p-2  link-success" href="#">페이지 소개</a> <a
					class="p-2 link-success" href="../reviewList">충전소 현황</a> <a
					class="p-2 link-success" href="#">기대효과</a> <a
					class="p-2 link-success" href="/getFreeBoardList">자유게시판</a> <a
					class="p-2 bg-success text-white" href="/ay/getBoardList">공지사항</a> <a
					class="p-2 link-success" href="#">Q&A</a>
			</nav>
		</div>
	</div>
	
	
	
	<main>
		<div class="container  justify-content-center">

			<div class="w-100 input-group justify-content-center">
				<h1 class="mb-3 text-success text-center">공지사항 목록</h1>		
	
	<!--<a href="insertBoard">새글 등록</a>  -->
	<table class="table table-hover table-striped text-center">
	<tr class="table-dark"><th>No.</th><th>제목</th><th>작성자</th><th>작성일</th><th>조회수</th><th>추천수</th></tr>
	<c:forEach items="${blist}" var="board">
		<tr><td>${board.num}</td>
			<td><a href="/ay/content/${board.num}">${board.title}</a></td>
			<td>${board.writer}</td>
			<td><fmt:formatDate value="${board.createDate}" pattern="MM.dd"/> </td>
			<td>${board.cnt}</td>
			<td>${board.recom}</td>
		</tr>	
	</c:forEach>
</table>

<div id="page">
	<c:if test="${search == null }">
	<nav aria-label="Page navigation">
	<ul class="pagination">
		<c:if test="${begin > 5 }">
		<li class="page-item">
			<a class="page-link" aria-label="Previous" href="/ay/getBoardList?p=${begin-1}"><span aria-hidden="true">&laquo;</span></a></li>
		</c:if>
		<c:forEach begin="${begin }" end="${end}" var="i">
		<li class="page-item">
			<a class="page-link" href="/ay/getBoardList?p=${i}">${i}</a></li>
		</c:forEach>
		<c:if test="${end < totalPage }">
		<li class="page-item">
			<a class="page-link" aria-label="Next" href="/ay/getBoardList?p=${end+1}"><span aria-hidden="true">&raquo;</span></a></li>
		</c:if>
		</ul>
		</nav>
	</c:if>
	
	<c:if test="${search != null}">
	<nav aria-label="Page navigation">
						<ul class="pagination">
		<c:if test="${begin > 5}">
		<li class="page-item">
			<a class="page-link" aria-label="Previous" href="/ay/getBoardList?p=${begin-1}&search=${search}&searchn=${searchn}"><span aria-hidden="true">&laquo;</span></a></li>
		</c:if>
		
		
		<c:forEach begin="${begin}" end="${end }" var="i">
			<li class="page-item"><a class="page-link" href="/ay/getBoardList?p=${i}&search=${search}&searchn=${searchn}">${i}</a></li>
		</c:forEach>
		<c:if test="${end < totalPage }">
			<li class="page-item">
			<a class="page-link" aria-label="Next" href="/ay/getBoardList?p=${end+1}&search=${search}&searchn=${searchn}"><span aria-hidden="true">&raquo;</span></a></li>
		</c:if>
		</ul>
		</nav>
	</c:if>
	</div>
	</div>

	<c:if test="${total == 0}">
	검색 결과가 없습니다.
</c:if>

<div class="container row justify-content-center">
				
				<div class="col-6">


	<form>
	<div style="width: 400px;" class="input-group">
		<select style="width: 130px;" class="form-select" name="searchn">
			<option value="0">제목</option>
			<option value="1">내용</option>
		</select> 
			<input style="width: 200px;" type="text" class="form-control" name="search" size="15" maxlength="50" />
			<input style="width: 70px;" type="submit" class="btn-success" value="검색" />
		</div>
		<!--<a href="insertBoard">새글 등록</a>  -->
	</form>
</div>	
</div>
</div>
</main>
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

<script>
 function init() {
		let id = '${member.id}';
		sessionStorage.setItem("id",id);
	} 
</script>
</body>

</html>