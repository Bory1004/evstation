<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
         <div class="row justify-content-center">
            <div class="col-6 pt-2">
               <a href="/main" class="link-secondary"> 
               <img src="/img/logo.png" width="220" height="100"></a>
               <!--  <a class="link-secondary" href="#">Subscribe</a> -->
            </div>

            <div class="col-6 d-flex-column-reverse justify-content-end align-items-center">
               <!-- justify-content 자식요소 정렬  -->
                                       
               <c:choose>
                  <c:when test="${member.id eq null}">
                     <div style="float:right;">
                        <a class="btn btn-sm btn-outline-success" href="/loginView">로그인</a> 
                        <a class="btn btn-sm btn-outline-success" href="/joinView">회원가입</a>
                     </div>   
                  </c:when>
                  <c:otherwise>
                     <div id="login" style="text-align:right;margin-bottom:10px;"><div id="alarmcount"></div><img style="cursor:pointer;"src="/img/alarm1.png"
                     width="30" height="30" onclick="ring(${member.memnum})">
                     </div>
                     <div style="float:right;"><img src="${member.memphoto}" width="45" height="30">${member.name}(${member.id})님 환영합니다!!
                      			<div id="btns" style="float: right;">
										<button class="btn btn-sm btn-outline-success dropdown-toggle"
											type="button" id="dropdownMenuButton1"
											data-bs-toggle="dropdown" aria-expanded="false">
										 마이페이지</button>
										<ul class="dropdown-menu"
											aria-labelledby="dropdownMenuButton1">
											<li><a class="dropdown-item" href="/check_mypage">개인정보수정</a></li>
											<li><a class="dropdown-item" href="/myQnABoardList/${member.memnum}">내가 쓴 글</a></li>
											<li><a class="dropdown-item" href="#">즐겨찾기</a></li>
											<c:if test="${member.getId() == 'admin'}"> <!-- 관리자 전용 페이지 -->
											<li><a class="dropdown-item" href="/adminQnAOnly">관리자페이지</a></li>
											</c:if>
										</ul>
									<a class="btn btn-sm btn-outline-success" href="/logout">로그아웃</a>
								</div>
                   </div>
                  </c:otherwise>                  
               </c:choose>
            </div>
         </div>

			<div class="menubar py-1 mb-2">
				<nav
					class="nav d-flex justify-content-center border-top border-bottom">

					<a class="p-2  link-success" href="/pageIntro">페이지 소개</a> <a
						class="p-2 link-success" href="/reviewList">충전소 현황</a> <a
						class="p-2 link-success" href="/benefit">기대효과</a> <a
						class="p-2 link-success" href="/getFreeBoardList">자유게시판</a> <a
						class="p-2 link-success" href="/ay/getBoardList">공지사항</a> <a
						class="p-2 link-success" href="/qnaList">Q&A</a>
				</nav>
			</div>
		</header>
	</div>
	

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