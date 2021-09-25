<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>리뷰 상세보기</title>
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
<%@ include file="/WEB-INF/DsBoard/DsLayout/dsHeaderNormal.jsp"%>

	<main>
		<div class="container" >
		<div class="mb-5" style="text-align:center;"><h1>글 작성하기</h1></div>
		<form method="post" enctype="multipart/form-data">
		
		<input type="hidden" name="boardmemnum" value="${member.memnum}"> <!-- 세션에있는 회원번호 -->
		<input type="hidden" name="boardtype" value="2"> <!-- 리뷰글이므로 타입2 -->
		<input type="hidden" name="boardstnum" value="${stnum}"> <!-- 리뷰하고있는 충전소번호 -->
		<div class="row">
			<div class="col-md-3">
				<label for="user_id" class="form-label">아이디</label>
			</div>
			<div class="col-md-3">
				<input type="text" id="user_id" name="boardwriter"class="form-control" value="${member.id}" readonly>
			</div>	
			<div class="col-md-3">
				<label for="user_name" class="form-label">이름</label>
			</div>
			<div class="col-md-3">
				<input type="text" id="user_name" class="form-control" value="${member.name}" readonly>
			</div>
		
			<div class="col-md-12 my-3">
				<input type="text" class="form-control" name="boardtitle" placeholder="제목을 입력해주세요">
			</div>
			<input type="file" multiple="multiple" name="files" >
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