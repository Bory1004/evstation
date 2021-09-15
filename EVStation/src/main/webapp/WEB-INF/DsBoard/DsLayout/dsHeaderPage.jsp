<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EvStation</title>
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
					<a href="/main" class="link-secondary">
					 <img src="/img/logo.png" width="220" height="100"></a>
					<!--  <a class="link-secondary" href="#">Subscribe</a> -->
				</div>

				<div class="col-6 d-flex justify-content-end align-items-center">
					<!-- justify-content 자식요소 정렬  -->
				
					<c:if test="${member.id == null}"> <!-- 비로그인 상태 -->
						<div>
							<a class="btn btn-sm btn-outline-success" href="/loginView">로그인</a> <a
								class="btn btn-sm btn-outline-success" href="/joinView">회원가입</a>
						</div>
					</c:if>
					<c:if test="${member.id != null}"><!-- 로그인인 상태>-->
						<div>
							${member.id}님 환영합니다!! <a class="btn btn-sm btn-outline-success"
								href="logout">로그아웃</a>
						</div>
					</c:if>
					
				</div>
			</div>
		</header>

		<div class="menubar py-1 mb-2">
			<nav
				class="nav d-flex justify-content-center border-top border-bottom">
				<a class="p-2 bg-success text-white" href="/pageIntro">페이지 소개</a>
				<a	class="p-2 link-success" href="/reviewList">충전소 현황</a> 
				<a	class="p-2 link-success" href="/benefit">기대효과</a>
				<a	class="p-2 link-success" href="/getBoardList">자유게시판</a>
				<a class="p-2 link-success" href="#">공지사항</a> 
				<a class="p-2 link-success" href="/qnaList">Q&A</a>
			</nav>
		</div>
	</div>
</body>
</html>