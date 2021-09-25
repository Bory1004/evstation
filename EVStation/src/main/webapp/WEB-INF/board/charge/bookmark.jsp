<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>

<title> 즐겨찾기</title>
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
					<a class="p-2  link-success" href="pageIntro">페이지 소개</a> 
					<a class="p-2 link-success" href="reviewList">충전소 현황</a> 
					<a class="p-2 link-success" href="benefit">기대효과</a> 
					<a class="p-2 link-success" href="getchargeList">자유게시판</a> 
					<a class="p-2 link-success" href="#">공지사항</a> 
					<a class="p-2 link-success" href="qnaList">Q&A</a>
				</nav>
			</div>
		</header>
	</div>
	
	
		
	<table class="table table-bordered table-hover" style="width: 800px; margin-left:auto; margin-right:auto;" >
		<thead class="table-secondary text-center">
			<tr>
				<th>번호</th>
				<th>충전소이름</th>
				<th>주소</th>
				<th>휴무일</th>
			</tr>
		</thead>
		
		<tbody class="text-center">
			
			<c:forEach items="${blist}" var="charge">
				<tr>
					<td style="width: 8%">${charge.stnum}</td>
					<td style="width: 30%"><a href="/list/${charge.stnum}">${charge.stname}</a></td>
					<td style="width: 50%">${charge.staddress1}</td>
					<td style="width: 12%">${charge.stclosedday}</td>
				</tr>	
			</c:forEach>
				
		</tbody>	
	</table>
	
	
	
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