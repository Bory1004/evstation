<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>충전소현황</title>
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

#alarmpage {
	position :absolute;
	border: solid black 1px;
	width : 210px;
	height : 300px;
	left : 1230px;
	overflow-y : auto;
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
					<div id="login" style="text-align:right;margin-bottom:10px;"><img style="cursor:pointer;"src="/img/alarm1.png"
						width="30" height="30" onclick="ring(${member.memnum})">
					</div>						
					<c:choose>
						<c:when test="${member.id eq null}">
							<div style="float:right;">
								<a class="btn btn-sm btn-outline-success" href="/loginView">로그인</a> 
								<a class="btn btn-sm btn-outline-success" href="/joinView">회원가입</a>
							</div>	
						</c:when>
						<c:otherwise>
							<div style="float:right;">${member.id}님 환영합니다!! <a class="btn btn-sm btn-outline-success" href="/logout">로그아웃</a></div>
						</c:otherwise>						
					</c:choose>
				</div>
			</div>

			<div class="menubar py-1 mb-2">
				<nav class="nav d-flex justify-content-center border-top border-bottom">
					<a class="p-2  link-success" href="#">페이지 소개</a> 
					<a class="p-2 link-success" href="/reviewList">충전소 현황</a> 
					<a class="p-2 link-success" href="#">기대효과</a> 
					<a class="p-2 link-success" href="/getBoardList">자유게시판</a> 
					<a class="p-2 link-success" href="#">공지사항</a> 
					<a class="p-2 link-success" href="#">Q&A</a>
				</nav>
			</div>
		</header>
	</div>


	<main>
		<div class="container  justify-content-center">

			<div class="w-100 input-group justify-content-center">
				<h1 class="mb-3 text-success text-center">리뷰 목록</h1>
				<c:if test="${ total != 0}">
					<table class="table table-hover table-striped text-center" style="vertical-align:middle;">
						<tr class="table-dark">
							<th>No.</th>
							<th>작성글</th>
							<th>작성자</th>
							<th>날짜</th>
							<th>조회수</th>
							<th>추천수</th>
						</tr>
						<c:forEach items="${rList}" var="board">
							<tr>
								<td>${board.boardnum}</td>
								<td><a href="/content/2/${board.boardnum}?p=${pNum}&search=${search}&searchn=${searchn}"
									class="text-success"><img src="${board.boardthumbnail}" style="width:60px;height:60px;">&nbsp;&nbsp;${board.boardtitle}</a></td>
								<td>${board.boardwriter}</td>
								<td><fmt:formatDate value="${board.boarddate}"
										pattern="MM.dd HH:mm" /></td>
								<td>${board.boardsee}</td>
								<td>${board.boardrecom}</td>
							</tr>
						</c:forEach>
					</table>
					<br>
				</c:if>
				<c:if test="${total == 0}">
				검색 결과가 없습니다.
				</c:if>
			
			<div class="w-100" style="text-align:right;"><a class="btn btn-sm btn-outline-success" href="reviewwrite?stnum=${stnum}">글쓰기</a></div>
			
			<div class="page">
				<c:if test="${search == null }">
					<nav aria-label="Page navigation">
						<ul class="pagination">
							<c:if test="${begin > 5 }"> <!-- 다음장으로 넘어가는경우 -->
								<li class="page-item"><a class="page-link"
									aria-label="Previous" class="page-link" aria-label="Previous"
									href="/reviewList?p=${begin-1}"><span aria-hidden="true">&laquo;</span></a></li>
							</c:if>
							<c:forEach begin="${begin }" end="${end}" var="i">
								<li class="page-item"><a class="page-link"
									href="/reviewList?p=${i}">${i}</a></li>
							</c:forEach>
							<c:if test="${end < totalPage }"> <!-- 페이지가 남아잇는경우 -->
								<li class="page-item"><a class="page-link"
									aria-label="Next" class="page-link" aria-label="Next"
									href="/reviewList?p=${end+1}"><span aria-hidden="true">&raquo;</span></a></li>
							</c:if>
						</ul>
					</nav>
				</c:if>

				<c:if test="${search != null }">
					<nav aria-label="Page navigation">
						<ul class="pagination">
							<c:if test="${begin > 5 }">
								<li class="page-item"><a class="page-link"
									aria-label="Previous"
									href="/reviewList?p=${begin-1}&search=${search}&searchn=${searchn}"><span
										aria-hidden="true">&laquo;</span></a></li>
							</c:if>
							<c:forEach begin="${begin }" end="${end}" var="i">
								<li class="page-item"><a class="page-link"
									href="/reviewList?p=${i}&search=${search}&searchn=${searchn}">${i}</a></li>
							</c:forEach>
							<c:if test="${end < totalPage }">
								<li class="page-item"><a class="page-link"
									aria-label="Next"
									href="/reviewList?p=${end+1}&search=${search}&searchn=${searchn}"><span
										aria-hidden="true">&raquo;</span></a></li>
							</c:if>
						</ul>
					</nav>
				</c:if>
			</div>
		</div>
		
			<!-- 여기서 검색창코딩 -->
				<div class="container row justify-content-center">
				
				<div class="col-6">
				<form>
					
				<select name="searchn" class="form-control" style="text-align-last:center;">
					<option value="0">제목</option>
					<option value="1">내용</option>
					<option value="2">작성자</option>
				</select>
				
				<input type="text" class="form-control" id="search" name="search"  />
				<input type="submit" class="form-control" value="검색" />
					
				</form>
				</div>
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
	</footer>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	$(function(){
		$.ajax({
			type : "get",
			url : "/countAlarm",
			data : { "memnum" : ${member.memnum}},
			dataType : "text"
		}).done(function(data){
			//alert(data)
			//$('#'+알람카운트부분).css("",data);
		}).fail(function(e){
			alert("실패")
			alert(e.responseText)				
		})
		
		
	})
	
	function ring(x){ //알람 창 열고 데이터 가져오는 함수
		//alert(${memnum})
		$.ajax({
			type : "get",
			url : "/getAlarm",
			data : {"memnum" : ${member.memnum}},
			dataType : "text"
		}).done(function(data){
			//alert("성공")
			if($('#alarmpage').html()){
				$('#alarmpage').remove();
			}else{
				$('#login').append("<div id='alarmpage'></div>"	);
				$('#alarmpage').html(data) //alarmpage에 따로만든 jsp파일넣기
			}
		}).fail(function(e){
			alert("실패")
			alert(e.responseText);
		})
	}
	function delAlarm(x){
		let alanum = x;
		$.ajax({
			type : "get",
			url : "/delAlarm",
			data : {"alanum" : alanum},
			dataType : "text"
		}).done(function(data){
			//alert(data)
			$('#'+alanum).remove();
		}).fail(function(e){
			alert("실패")
			alert(e.responseText);
		})
	}
	function checkAlarm(x){
		let alanum = x;
		$.ajax({
			type : "get",
			url : "/checkAlarm",
			data : {"alanum" : alanum},
			dataType : "text"
		}).done(function(data){
			alert(data)
			//$('#'+alanum).children().eq(1).children().eq(0).css("color","red");
		}).fail(function(e){
			alert("실패")
			alert(e.responseText)
		})
	}
	</script>
</body>

</html>