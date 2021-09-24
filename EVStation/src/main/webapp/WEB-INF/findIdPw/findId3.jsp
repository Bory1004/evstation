<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>아이디 찾기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<style>
	div.form-text {color: red;}
	a {text-decoration-line: none;}
</style>
</head>
<body>

	<header class="py-4">
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
<br>
	<main>
		<div class="container d-flex justify-content-center align-items-center">
			<div id="content">
				<form class="row g-2" action="/findIdPw_newPw" method="post">				
					<div class="row mb-3 justify-content-center align-items-center">
					<div class="col-md-6">
						<h3>아이디 : ${id}</h3>
						<input type="hidden" id="id" name="id" class="form-control" value="${id}">
					</div>
					</div>
					<div class="row mb-3 justify-content-center align-items-center">
					<div class="col-md-6">
						<label for="mempw" class="col-form-label">새 비밀번호</label> 
						<input type="password" id="mempw" name="mempw" class="form-control" maxlength="20" aria-describedby="pw_msg">
						<div id="pw_msg" class="form-text"></div>
					</div>
					</div>

					<div class="row mb-3 justify-content-center align-items-center">
						<div class="col-md-6">
							<label for="pw2" class="col-form-label">새 비밀번호 확인</label> 
							<input type="password" id="pw2" name="pw2" class="form-control" maxlength="20" aria-describedby="pw_msg2">
							<div id="pw_msg2" class="form-text"></div>
						</div>
					</div>

					<div class="row mb-3 justify-content-center align-items-center">
						<div class="col-md-6" align="center">
							<input style="width: 200px;" type="submit" id="bnt_submit" class="btn btn-success" value="완료" />
						</div>
					</div>
				</form>
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
		$("#mempw").blur(function() {
			$("#pw_msg").text("");
			if ($("#mempw").val() != $("#pw2").val() && $("#pw2").val() != "") {
				$("#pw_msg2").text("새 비밀번호가 일치하지않습니다.");
				return false;
			}
			if (!$("#mempw").val()) {
				$("#pw_msg").text("새 비밀번호를 입력해주세요.");
				return false;
			}
			if (!$("#mempw").val()) {
				$("#pw_msg").text("새 비밀번호를 입력해주세요.");
				return false;
			}
			if ($("#mempw").val() == $("#pw2").val() && $("#mempw").val() != "" && $("#pw2").val() != "") {
				$("#pw_msg").text("");
				$("#pw_msg2").text("");
			}			
		});
		
		$("#pw2").blur(function() {
			$("#pw_msg2").text("");
			if ($("#mempw").val() != $("#pw2").val() && $("#pw2").val() != "") {
				$("#pw_msg2").text("새 비밀번호가 일치하지않습니다.");
				return false;
			} 
			if (!$("#pw2").val()) {
				$("#pw_msg2").text("새 비밀번호 확인을 입력해주세요.");
				return false;
			}
			if ($("#mempw").val() == $("#pw2").val() && $("#mempw").val() != "" && $("#pw2").val() != "") {
				$("#pw_msg").text("");
				$("#pw_msg2").text("");
			} 
		});
		
		$("#bnt_submit").on("click",function(){
			console.log("제출");
			if(!$("#mempw").val()){
				console.log('비밀번호 빈칸');
				$("#pw_msg").text("새 비밀번호를 입력주세요.")
				return false;
			}
			if(!$("#pw2").val()){
				console.log('비밀번호 빈칸');
				$("#pw_msg2").text("새 비밀번호 확인을 입력주세요.")
				return false;
			}
			alert("비밀번호 변경 완료!")
		})
	});
	</script>	
</body>
</html>