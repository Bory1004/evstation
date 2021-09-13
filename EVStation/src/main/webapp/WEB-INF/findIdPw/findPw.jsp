<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>비밀번호 찾기</title>
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
	
	<main>
		<div class="container d-flex justify-content-center align-items-center">		
		<div id="content">	
			
		<form id="form" class="row g-2" action="/findPw" method="post">
			<div class="row mb-3 justify-content-center align-items-center">
			</div>	
			
			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
					<label for="name" class="col-form-label">이름</label>
					<input type="text" id="name" name="name" class="form-control" maxlength="20" aria-describedby="name_msg">
					<div id="name_msg" class="form-text"></div>
				</div>
			</div>
			
			<div class="row mb-2 justify-content-center align-items-center">
				<div class="col-md-6">
					<label for="id" class="col-form-label">아이디</label>
					<input type="text" id="id" name="id" class="form-control" maxlength="20" aria-describedby="id_msg">
					<div id="id_msg" class="form-text"></div>
				</div>
			</div>
			
			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
				<label for="mememail" class="col-form-label">이메일</label>
					<div class="input-group">
						<input type="text" id="mememail1" name="mememail1" class="form-control" maxlength="20" aria-describedby="email_msg">
						@<input type="text" id="mememail2" name="mememail2" class="form-control" disabled value="naver.com">
						<select name="selectEmail" id="selectEmail" class="form-select"> 
							<option value="1">직접입력</option> 
							<option value="naver.com" selected>naver.com</option> 
							<option value="hanmail.net">hanmail.net</option> 
							<option value="hotmail.com">hotmail.com</option> 
							<option value="nate.com">nate.com</option> 
							<option value="yahoo.co.kr">yahoo.co.kr</option> 
							<option value="empas.com">empas.com</option> 
							<option value="dreamwiz.com">dreamwiz.com</option> 
							<option value="freechal.com">freechal.com</option> 
							<option value="lycos.co.kr">lycos.co.kr</option> 
							<option value="korea.com">korea.com</option> 
							<option value="gmail.com">gmail.com</option> 
							<option value="hanmir.com">hanmir.com</option> 
							<option value="paran.com">paran.com</option> 
						</select>

						<button type="button" id="mail_ck" class="btn btn-success">메일 인증</button>
					</div>
					<div id="email_msg" class="form-text"></div>
				</div>
			</div>
			
			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
					<div class="input-group">
						<input type="text" id="num_in" class="form-control" placeholder="인증번호를 입력해주세요." disabled="disabled" aria-describedby="num_msg">
						<button type="button" id="num_ck" class="btn btn-success justify-content-center" disabled>인증 확인</button>
					</div>
					<div id="num_msg" class="form-text"></div>
				</div>
			</div>			
			
			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
					<input style="width: 200px;" type="submit" id="bnt_submit" class="btn btn-success" value="비밀번호 찾기" />
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
			
			$("#id").blur(function() {
				let id = $('#id').val();
				let id_ck = /^[a-zA-Z0-9]*$/;
				
				if(!$("#id").val()){									
					$("#id_msg").text("아이디를 입력해주세요.");
					//$("#bnt_submit").attr("disabled", true);
					return false;
				}
			})
		
			//이름
			$("#name").blur(function() {
				let name = $("#name").val();
				let name_ck = /^[가-힣]{2,6}$/;
				
				$("#name_msg").text("");
				if(!$("#name").val()){
					console.log("이름 빈칸");
					$("#name_msg").text("이름을 입력해주세요.");
					return false;
				}
				if (!name_ck.test(name)) {
					$("#name_msg").text("2~6글자의 한글만 입력가능합니다.");
					return false;
				} else {
					$("#name_msg").text("");
				}
			});
					
			// 이메일 인증
			$("#selectEmail").change(function(){ 
				$("#selectEmail option:selected").each(function (){ 
					if($(this).val()== '1'){//직접입력일 경우 
						$("#mememail2").val(""); //값 초기화 
						$("#mememail2").attr("disabled",false); //활성화 
					}else{ //직접입력이 아닐경우 
						$("#mememail2").val($(this).text());//선택값 입력 
						$("#mememail2").attr("disabled",true); //비활성화 
					} 
				}); 
			});
			
			$("#mail_ck").on("click", function() {
				let name = $("#name").val();
				let email = $("#mememail1").val()+"@"+$("#mememail2").val();
				
				//let param = {"name":name, "mememail":email};
				
				console.log(email);
				let email_ck =/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
				
				if (!email) {
					$("#email_msg").text("메일 주소를 입력하세요.");
					return false;
					
				} else{
					$("#email_msg").text("");
				}
				
				if(email_ck.test(email) == false ){
					$("#email_msg").text("메일 형식을 확인해주세요.");
					return false;
				}
				
				$.ajax({
					url : "/find_name_email",
					data : {name:name, mememail:email}
					//dataType : "text",
					
					}).done(function(data){
						
						//일치하는 정보가 있으면
						if(data=="success"){
							console.log(data);
							$.ajax({
								url : "/join_mail",
								data : "emailAddress=" + email,
								dataType : "json"
							}).done(function(data) {
								if (eval(data[1])) {
									num = data[0];
									alert("메일이 전송되었습니다. 인증번호를 입력하세요.");
									$("#num_in").attr("disabled", false);
									$("#num_ck").attr("disabled", false);
								}
							}); //ajax
						}
						
						//일지하는 정보가 없으면
						else{						
							console.log(data);
							$("#email_msg").text("존재하지 않는 회원정보입니다.");
						}
					})
				});
					
			//인증번호 입력
			$("#num_ck").on("click", function() {
				let num_in = $("#num_in").val();
				let email = $("#mememail1").val()+"@"+$("#mememail2").val();
						
				if (num_in == num) {
					$("#name").attr("readonly", true);
					$("#mememail1").attr("readonly", true);
					$("#num_in").attr("readonly", true);
					$("#num_msg").text("인증완료");
					$("#num_msg").append("<input type='hidden' id='ck' value='1'>");
					$("#num_msg").append("<input type='hidden' name='mememail' value='"+email+"'>");
				} else {
					$("#num_msg").text("인증 실패했습니다.");
				}
			})
			
			$("#form").submit(function(){
			//$("#bnt_submit").on("click",function(){
				console.log("제출");
				if(!$("#name").val()){
					console.log("이름 빈칸")
					$("#name_msg").text("이름를 입력주세요.")
					return false;
				}
				if(!$("#id").val()){
					console.log('아이디 빈칸');
					$("#id_msg").text("아이디를 입력주세요.")
					return false;
				}
				if(!$("#mememail1").val()){
					$("#email_msg").text("이메일을 입력주세요.")
					return false;
				}
				if(!$("#mememail2").val()){
					$("#email_msg").text("이메일을 입력주세요.")
					return false;
				}
				if($("#ck").val() != 1){
					$("#email_msg").text("이메일 인증해주세요.")
					return false;
				}
			})
		});
	</script>	
</body>
</html>