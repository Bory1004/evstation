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
	#center {
		width: 800px;
		margin-left: auto;
		margin-right: auto;
	}
</style>
</head>
<script type="text/javascript">
function resize(img){
	// 원본 이미지 사이즈 저장
	let width = img.width;
	let height = img.height;

	// 가로, 세로 최대 사이즈 설정
	let maxWidth = 180;   // 원하는대로 설정. 픽셀로 하려면 maxWidth = 100  이런 식으로 입력
	let maxHeight = 180;   // 원래 사이즈 * 0.5 = 50%

	let resizeHeight = null; 
	let resizeWidth = null;
	
	// 가로나 세로의 길이가 최대 사이즈보다 크면 실행  
	if(width > maxWidth || height > maxHeight){
		// 가로가 세로보다 크면 가로는 최대사이즈로, 세로는 비율 맞춰 리사이즈
		if(width > height){
			resizeWidth = maxWidth;
			resizeHeight = Math.round((height * resizeWidth) / width);
			// 세로가 가로보다 크면 세로는 최대사이즈로, 가로는 비율 맞춰 리사이즈
		}else{
			resizeHeight = maxHeight;
			resizeWidth = Math.round((width * resizeHeight) / height);
		}
	 // 최대사이즈보다 작으면 원본 그대로
	 }else{
		 resizeWidth = width;
		 resizeHeight = height;
		}
		// 리사이즈한 크기로 이미지 크기 다시 지정
		img.width = resizeWidth;
		img.height = resizeHeight;
}
  
</script>
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
		<div id="center" style="width: 400px;">			
			<form action="/mypage" method="post">
				<table class="table table-borderless border">								
					<tr><td align="center"><img style = "border-radius:70%;" src="${member.memphoto}" onload="resize(this)"></td></tr>
					<tr><td align="center"><h4>${member.id} 님</h4></td></tr>
					<tr><td align="center">소중한 개인정보를 위해 비밀번호를 확인해주세요!</td></tr>
					<tr><td align="center" ><input type="hidden" id="id" name="id" class="form-control" value="${member.id}"></td></tr>
					<tr><td align="center"><input type="password" id="mempw" name="mempw" class="form-control" maxlength="20" aria-describedby="pw_msg" placeholder="비밀번호를 입력해주세요."></td></tr>
					<tr><td><div id="pw_msg" class="form-text"></div></td></tr>
					<tr><td align="center"><input type="submit" id="bnt_submit" class="btn btn-success" value="비밀번호 확인" /></td></tr>				
				</table>
			</form>
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
			if (!$("#mempw").val()) {
				$("#pw_msg").text("비밀번호를 입력해주세요.");
				return false;
			}			
		});
		
		$("#bnt_submit").on("click",function(){
			if(!$("#mempw").val()){
				$("#pw_msg").text("비밀번호를 입력해주세요.")
				$("#mempw").focus();
				return false;
			}
			
			let pw = "${member.mempw}";
			if($("#mempw").val() != pw){
				alert("비밀번호를 확인해주세요.");
				$("#mempw").focus();
				return false;
			}
			
		});
	});
	</script>	
</body>
</html>