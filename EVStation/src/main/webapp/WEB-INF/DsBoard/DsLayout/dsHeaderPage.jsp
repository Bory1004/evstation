<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session = "true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
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

a {
	text-decoration-line: none;
}

#alarmpage {
	position :absolute;
	border: solid #BDBDBD 1px;
	border-radius: 20px;
	width : 230px;
	height : 300px;
	left : 1230px;
	padding : 10px;
	overflow-y : auto;
}
#alarmcount {
	position : absolute;
	width : 30px;
	height : 20px;
	left : 1200px;
	top : 45px;
	border-radius: 10px;
	text-align : center;
	vertical-align : middle;
}
#alarmcount > span {
	position :relative;
	color : white;
	bottom : 3px;
}
</style>
</head>
<body>
	<div class="container">
		<header class="py-3">
			<div class="row justify-content-center">
				<c:if test="${member.getId() != null}">
			
				<div class="col-6 pt-2">
					<a href="/main" class="link-secondary"> 
					<img src="/img/logo.png" width="220" height="100"></a>
					<!--  <a class="link-secondary" href="#">Subscribe</a> -->
				</div>
		 </c:if>
		 <c:if test="${member.getId() == null}">
			
				<div class="col-6 pt-2">
					<a href="/" class="link-secondary"> 
					<img src="/img/logo.png" width="220" height="100"></a>
					<!--  <a class="link-secondary" href="#">Subscribe</a> -->
				</div>
		 </c:if>

				<div class="col-6 d-flex-column-reverse justify-content-end align-items-center">
					<!-- justify-content 자식요소 정렬  -->
					<%-- <div id="login" style="text-align:right;margin-bottom:10px;"><div id="alarmcount"></div><img style="cursor:pointer;"src="/img/alarm1.png"
						width="30" height="30" onclick="ring(${member.memnum})">
					</div>	 --%>					
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
							<div style="float:right;"><img src="${member.memphoto}" width="45" height="30">${member.name}(${member.id})님 환영합니다!!</br>
							
						<div id="btns" style="float: right;">
										<button class="btn btn-sm btn-outline-success dropdown-toggle"
											type="button" id="dropdownMenuButton1"
											data-bs-toggle="dropdown" aria-expanded="false">
										 마이페이지</button>
										<ul class="dropdown-menu"
											aria-labelledby="dropdownMenuButton1">
											<li><a class="dropdown-item" href="#">개인정보수정</a></li>
											<li><a class="dropdown-item" href="/myQnABoardList/${member.memnum}">내가 쓴 글</a></li>
											<li><a class="dropdown-item" href="#">즐겨찾기</a></li>
											<c:if test="${member.getId() == 'admin'}"> <!-- 관리자 전용 페이지 -->
											<li><a class="dropdown-item" href="/adminOnly">관리자페이지</a></li>
											</c:if>
										</ul>
									<a class="btn btn-sm btn-outline-success" href="/logout">로그아웃</a>
								</div>
							 </div>
						</c:otherwise>						
					</c:choose>
				</div>
			</div>
			
			<div class="menubar py-3 mb-12">
				<nav class="nav d-flex justify-content-center border-top border-bottom">


					<a class="p-2 bg-success text-white"  href="/pageIntro">페이지 소개</a> 
					<a class="p-2 link-success" href="/getChargeList">충전소 현황</a> 
					<a class="p-2 link-success" href="/benefit">기대효과</a> 
					<a class="p-2 link-success" href="/getFreeBoardList">자유게시판</a> 
					<a class="p-2 link-success" href="/ay/getBoardList">공지사항</a> 
					<a class="p-2 link-success" href="/qnaList">Q&A</a>

				</nav>
			</div>
		</header>

	
	</div>
			
</body>
</html>