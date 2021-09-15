<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>회원가입 완료</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<style>
	a {text-decoration-line: none;}
</style>
</head>
<body>

	<header class="py-5">
		<div class="container"> 
			<div class="row justify-content-center">
				<div class="col-md-12 text-center">
					<a href="/main" class="link-secondary"> 
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
					<h2>${member.id}님 회원가입을 축하합니다!</h2>			
				</div><br>
				<div class="row">
					<a style="width: 300px; margin: auto;" class="btn btn-success" href="loginView">로그인</a>						
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
	
</body>
</html>