<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>리뷰 상세보기</title>
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
					<a href="/" class="link-secondary"> <img src="/img/logo.png"
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
		

		<div class="menubar py-1 mb-2">
			<nav
				class="nav d-flex justify-content-center border-top border-bottom">
				<a class="p-2  link-success" href="#">페이지 소개</a> <a
					class="p-2 link-success" href="../reviewList">충전소 현황</a> <a
					class="p-2 link-success" href="#">기대효과</a> <a
					class="p-2 link-success" href="#">자유게시판</a> <a
					class="p-2 link-success" href="#">공지사항</a> <a
					class="p-2 link-success" href="#">Q&A</a>
			</nav>
		</div>
		</header>
	</div>
	

	<main>
		<div class="container input-group d-flex justify-content-center">
			
			
		<h1>${review.boardtitle }</h1>
		<div class="w-100 row">
			<div class="col-xs-12 col-md-12 mb-2" style="text-align:right;">추천수 ${review.boardrecom } 조회수 ${review.boardsee}</div>		
			<div class="col-xs-12 col-md-12">
			<div class="table table-responsive">
				<table class="table" style="text-align:center">
				<tr>
					<th class="table-success">글번호</th>
					<td>${review.boardnum}</td>
					<th class="table-success">(프로필사진)작성자</th>
					<td> 작성자 닉네임 예시1 </td>
				</tr>
				<tr>
					<th class="table-success">ID</th>
					<td>${review.boardwriter}</td>
					<th class="table-success">작성일</th>
					<td>${review.boarddate}</td>
				</tr>
				<tr>
					<th class="table-success" colspan="1" >내용</th>
					<td colspan="3"><textarea rows="10" style="width:100%;border:none;">${review.boardcontent}</textarea></td>
				</tr>
				</table>
			</div>
			
			(프로필사진) <a href="">${review.boardwriter}님의 게시글 더보기 ></a>
			<hr>
			댓글기능 구현
			
				
			</div>
				<div class="col-md-12 d-flex justify-content-end" >
					<span><a class="btn btn-md btn-outline-success" href="../reviewList?p=${pNum}&search=${search}&searchn=${searchn}" style="margin:5px">목록</a></span>
					<span><a class="btn btn-md btn-outline-success" href="#" style="margin:5px">TOP</a></span>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>