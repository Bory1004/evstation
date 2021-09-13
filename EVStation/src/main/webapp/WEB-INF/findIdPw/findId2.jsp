<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>아이디 찾기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<style>
	a {text-decoration-line: none;}
</style>
</head>
<body>

	<header class="py-4">
		<div class="container"> 
			<div class="row justify-content-center">
				<div class="col-md-12 text-center">
					<a href="main" class="link-secondary"> 
					<img src="/img/logo.png" width="220" height="100">
					</a>
				</div>
			</div>
		</div>
	</header>
	
	<main>
		<div class="container d-flex justify-content-center align-items-center">		
			<div id="content">
				<div class="row">
					<h3>아이디 찾기</h3>	
					<h3>고객님의 정보와 일치하는 아이디 목록입니다.</h3>			
				</div>
				<div class="row">
				<form class="row g-2" id="form" class="row g-2" action="/findIdPw" method="post"> <!-- id="form" class="row g-2" action="/findIdPw" method="post" -->
					<table>
						<c:forEach items="${mlist}" var="member">										
							<tr>
								<td><input class="form-check-input" type="radio" name="findId_ck" id="findId_ck" value="${member.id}">	
									아이디 : ${member.id}</td>
								<td>가입일 : <fmt:formatDate value="${member.memdate}" pattern="MM.dd" /></td>
							</tr><br>					
						</c:forEach>
					</table>
					<div class="row">
						<span id="ch_id"></span>
					</div><br>
					<div class="row">
					<a style="width: 300px; margin: auto;" class="btn btn-success" href="loginView">로그인</a>
					<button type="submit" id="findIdPw" style="width: 300px; margin: auto;" class="btn btn-success">비밀번호 찾기</button>					
					</div>
				</form>	
				</div><br>

			</div>			
		</div>
	</main>

	<br>
	<br>	
		<footer class="container-fluid my-3 d-flex justify-content-center align-items-center" style="height: 100px;">
		<div class="row">
			<div class="col-12 pt-3">
				<p>
					Project built for <a href="#">Portfolio</a> by <a href="#">Team2</a>.
				</p>
				<p>Copyright @ 2021 EvStation</p>
			</div>
		</div>
	</footer>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>		
		$(function() {
			$("#findIdPw").on('click', function() {
			//$("#form").submit(function(){
				let findId_ck = document.getElementsByName("findId_ck");
				let findId = null;
				for (var i = 0; i < findId_ck.length; i++) {
					//만약 라디오 버튼이 체크가 되어있다면 true
					if (findId_ck[i].checked == true) {
						findId = findId_ck[i].value;
					}
				}
				if(findId == null){
					alert("아이디를 선택해주세요.");
					return false;
				
				}else{
					$("#ch_id").append("<input type='hidden' id='findId' name='findId' value='"+findId+"'>");
				}
				
			})
		});
	</script>	
</body>
</html>