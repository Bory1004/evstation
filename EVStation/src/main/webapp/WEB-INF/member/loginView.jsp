<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<style>
a {
	text-decoration-line: none;
}
</style>
</head>
<body>
	<header class="py-5">
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
		<div class="container input-group d-flex justify-content-center">
			<form id="loginForm" action="login" method="post">
				<div class="input-group">
					<span class="input-group-text"> 
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
  							<path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" />
						</svg>
					</span> 
					<input class="form-control" name="id" id="id" type="text" placeholder="아이디">
				</div>
				<div class="input-group">
					<span class="input-group-text"> 
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lock" viewBox="0 0 16 16">
 	 						<path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2zM5 8h6a1 1 0 0 1 1 1v5a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V9a1 1 0 0 1 1-1z" />
						</svg>
					</span>
					<input class="form-control" id="mempw" name="mempw" type="password" placeholder="비밀번호">
				</div>
				<div class="form-check">
					<input class="form-check-input" type="checkbox" id="check_cookie"> 로그인 상태 유지
				</div>			
				<div style="color: red" id="login_msg">${msg}</div><br>
				<input style="width: 300px;" type="submit" class="btn btn-success justify-content-center" id="login_chk" value="로그인">
				<br>
				<div><a href="/findIdView">아이디 찾기</a> | <a href="/findPwView">비밀번호 찾기</a> | <a href="/joinView">회원가입</a></div>
			</form>
		</div>
	</main>
	<br><br>
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
		$("#login_chk").click(function() {
			let id = $("#id").val();
			let pw = $("#mempw").val();

			if (id == "") {
				$("#login_msg").html("아이디를 입력해주세요.")
				$("#id").focus();
				return false;
			}

			if (pw == "") {
				$("#login_msg").html("비밀번호를 입력해주세요.")
				$("#mempw").focus();
				return false;
			}

			if ($("#check_cookie").prop("checked")) {
				$("#login_msg").append("<input type='hidden' name='cookie' value='1'>");
			} else {
				$("#num_msg").append("<input type='hidden' name='cookie' value='0'>");
			}
		});
	});

	</script>
</body>
</html>