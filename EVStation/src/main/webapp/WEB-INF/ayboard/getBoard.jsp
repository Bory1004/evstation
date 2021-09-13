<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>글 상세보기</title>
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

textarea {
	width: 100%;
}
</style>
</head>
<body>
	<div class="container">
		<header class="py-3">
			<div class="row justify-content-center">

				<div class="col-6 pt-2">
					<a href="/" class="link-secondary"> <img src="/img/logo.png" width="200" height="100">
					</a>
					
				</div>

				<div class="col-6 d-flex justify-content-end align-items-center">
					<!-- justify-content 자식요소 정렬  -->
													
					<c:choose>
						<c:when test="${member.id eq null}">
							<div>
								<a class="btn btn-sm btn-outline-success" href="loginView">로그인</a> 
								<a class="btn btn-sm btn-outline-success" href="joinView">회원가입</a>
							</div>	
						</c:when>
						<c:otherwise>
							${member.id}님 환영합니다!! <a class="btn btn-sm btn-outline-success" href="logout">로그아웃</a>
						</c:otherwise>						
					</c:choose>
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
			<h1>${board.title}</h1>
			<div class="w-100 row">
				<div class="col-xs-12 col-md-12 mb-2" style="text-align: right;">
			
			<c:if test= "${member.id == null}">
					<img id="h" src="/img/empty.png" width="20px" title="123">
				</c:if>
			<!-- 로그인 안된 상태 , 빈 하트 보이게-->
					<c:if test= "${member.id != null}">
						<c:if test="${result == 0}">
							<img id="h" src="/img/empty.png" width="20px">
						</c:if>
						<c:if test="${result != 0}">
							<img id="h" src="/img/full.png" width="20px">
						</c:if>
					</c:if>	
				
					${result }${member.id }추천수<span id="recom_div">${board.recom}</span> 조회수 ${board.cnt}
				</div>
				<div class="col-xs-12 col-md-12">
					<div class="table table-responsive">
						<table class="table" style="text-align: center">
							<tr>
								<th class="table-success">글번호</th>
								<td id="boardnum">${board.num}</td>
							</tr>
							<tr>
								<th class="table-success">작성일</th>
								<td><fmt:formatDate value="${board.createDate }"
										pattern="MM.dd HH:mm" /></td>
							</tr>
							<tr>
								<th class="table-success" colspan="1">내용</th>
								<td colspan="3">${board.content}</td>
							</tr>
						</table>
						
							<a class="btn btn-sm btn-outline-success" href="/ay/updateForm/${board.num }">수정</a>
							<a class="btn btn-sm btn-outline-success" href="/ay/delete/${board.num }">삭제</a>
							 <a class="btn btn-sm btn-outline-success" href="/ay/getBoardList">목록으로</a>
					</div>

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
	<script>
		$(function() {
			$("#h").click(function() {
				
								let num = ${board.num};
								let id = sessionStorage.getItem('id');
								let url = "/upRecom/" + num + "/" + id;
								
								$.ajax({
											url : url
										})	
										.done(
												function(data) {
													//history.go(0);
													//alert(data)
													if (document.getElementById("h").getAttribute('src') == '/img/empty.png') {
														document.getElementById("h").src = "/img/full.png";
													} else {
														document.getElementById("h").src = "/img/empty.png";//.src는 속성값 변경
													}
													$("#recom_div").text(data);//매개변수가 있으니까 변경된 값 가져옴
												}).fail(
												function(jqXHR, textStatus,errorThrown) {
													console.log("error");
												}); 
							
										})//2
		});                 
		
	</script>

</body>
</html>