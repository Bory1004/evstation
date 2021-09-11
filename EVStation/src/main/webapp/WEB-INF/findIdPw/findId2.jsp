<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
					<a href="/" class="link-secondary"> 
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
					<table>
						<c:forEach items="${mlist}" var="member">					
							<tr><td>아이디 : ${member.id}</td><td>가입일 : ${member.memdate}</td></tr><br>						
						</c:forEach>
					</table>		
				</div><br>
				<div class="row">
					<a style="width: 300px; margin: auto;" class="btn btn-success" href="loginView">로그인</a>
					<a style="width: 300px; margin: auto;" class="btn btn-success" href="findPw">비밀번호 찾기</a>					
				</div>
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
		
	</script>	
</body>
</html>