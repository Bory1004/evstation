<%@ page contentType="text/html; charset=UTF-8" %>
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
					<a href="/" class="link-secondary"> <img src="./img/logo.png"
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
				<a class="p-2  link-success" href="pageIntro">페이지 소개</a> <a
					class="p-2 link-success" href="/reviewList">충전소 현황</a> <a
					class="p-2 link-success" href="benefit">기대효과</a> <a
					class="p-2 link-success" href="getBoardList">자유게시판</a> <a
					class="p-2 link-success" href="#">공지사항</a> <a
					class="p-2 link-success" href="qnaList">Q&A</a>
			</nav>
		</div>
		</header>
	</div>
	

	<main>
		<div class="container" >
		<div class="mb-5" style="text-align:center;"><h1>글 작성하기</h1></div>
		<form method="post">
		
		<input type="hidden" name="boardmemnum" value="${boardmemnum}"> <!-- 세션에있는 회원번호 -->
		<input type="hidden" name="boardtype" value="2"> <!-- 리뷰글이므로 타입2 -->
		<input type="hidden" name="boardstnum" value="${stnum}"> <!-- 리뷰하고있는 충전소번호 -->
		<div class="row">
			<div class="col-md-3">
				<label for="user_id" class="form-label">아이디</label>
			</div>
			<div class="col-md-3">
				<input type="text" id="user_id" name="boardwriter"class="form-control" value="idexample1" readonly>
			</div>	
			<div class="col-md-3">
				<label for="user_name" class="form-label">이름</label>
			</div>
			<div class="col-md-3">
				<input type="text" id="user_name" class="form-control" value="여기에 세션에 저장된 멤버 이름" readonly>
			</div>
		
			<div class="col-md-12 my-3">
				<input type="text" class="form-control" name="boardtitle" placeholder="제목을 입력해주세요">
			</div>
		
			<div class="col-md-12">
				<textarea class="form-control" rows="10" name="boardcontent" placeholder="내용을 입력해주세요"></textarea>
			</div>
		
			<div class="w-100" style="text-align:right;margin-top:10px">
			<input type="submit" class="btn btn-sm btn-outline-success" value="작성">
			<a class="btn btn-sm btn-outline-success" href="reviewList">목록</a>
		</div>
		
		</div>
		</form>
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