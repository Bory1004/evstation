<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<title>회원가입</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<style>
	div.form-text {color: red;}
	#star {color: red;}
	a {text-decoration-line: none;}
</style>
</head>
<body>

	<header class="py-3">
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
	<br>
	
	<main>
		<div class="container d-flex justify-content-center align-items-center">		
		<div id="content">		
		<form class="row g-2" id="member" action="/join" method="post"><!-- action="/join" method="post" -->
			
			<div class="row mb-2 justify-content-center align-items-center">
				<div class="col-md-6">
					<label for="id" class="col-form-label"><span id="star">*</span>아이디</label>
					<input type="text" id="id" name="id" class="form-control" maxlength="20" aria-describedby="id_msg">
					<div id="id_msg" class="form-text"></div>
				</div>
			</div>
			
			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
					<label for="mempw" class="col-form-label"><span id="star">*</span>비밀번호</label>
					<input type="password" id="mempw" name="mempw" class="form-control" maxlength="20" aria-describedby="pw_msg">
					<div id="pw_msg" class="form-text"></div>
				</div>
			</div>
			
			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
					<label for="pw2" class="col-form-label"><span id="star">*</span>비밀번호 확인</label>
					<input type="password" id="pw2" name="pw2" class="form-control" maxlength="20" aria-describedby="pw_msg2">
					<div id="pw_msg2" class="form-text"></div>
				</div>
			</div>
			
			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
					<label for="name" class="col-form-label"><span id="star">*</span>이름</label>
					<input type="text" id="name" name="name" class="form-control" maxlength="20" aria-describedby="name_msg">
					<div id="name_msg" class="form-text"></div>
				</div>
			</div>
			
			<!-- 메일 인증 -->
			<!-- <div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
				<label for="mememail" class="col-form-label"><span id="star">*</span>이메일</label>
					<div class="input-group">
						<input type="text" id="mememail" name="mememail" class="form-control input-group-bnt" maxlength="20" aria-describedby="email_msg">
						<button type="button" id="mail_ck" class="btn btn-success justify-content-center">메일 인증</button>
					</div>
					<div id="email_msg" class="form-text"></div>
				</div>
			</div> -->
			
			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
				<label for="mememail" class="col-form-label"><span id="star">*</span>이메일</label>
					<div class="input-group">
					<input type="text" id="mememail" name="mememail" class="form-control" maxlength="30" aria-describedby="email_msg">
						<!-- <input type="text" id="mememail1" name="mememail1" class="form-control" maxlength="20" aria-describedby="email_msg">
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
						</select> -->

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
					<label for="memphone" class="col-form-label">휴대전화</label>
					<input type="text" id="memphone" name="memphone" class="form-control" maxlength="20" placeholder="010-0000-0000">
				</div>
			</div>

			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
				<label for="memaddress" class="col-form-label"><span id="star">*</span>주소</label>
					<div class="input-group">
						<input type="text" id="memaddress" name="memaddress" class="form-control" readonly aria-describedby="address_msg">
						<button type="button" id="bnt_address" class="btn btn-success justify-content-center">주소 검색</button>
					</div>
					<div id="address_msg" class="form-text"></div>
				</div>
			</div>
			
			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
					<input type="text" id="memaddressdetail" name="memaddressdetail" class="form-control" maxlength="20" placeholder="상세주소를 입력해주세요." aria-describedby="address_msg2">
				</div>
				<div id="address_msg2" class="form-text"></div>
			</div>
				
			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
					<label for="membirth" class="col-form-label"><span id="star">*</span>생년월일</label>
					<input type="text" id="membirth" name="membirth" class="form-control" maxlength="20" placeholder="ex) 20210101" aria-describedby="birth_msg">
					<div id="birth_msg" class="form-text"></div>
				</div>
			</div>
			
			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
				<label for="memphone" class="col-form-label">차종/충전타입</label>
				<div class="input-group">
					<select class="form-select" id="memcar" name="memcar">
						<option value="없음">없음</option>
						<option value="현대">현대</option>
						<option value="기아">기아</option>
						<option value="테슬라">테슬라</option>
					</select>
					<select class="form-select" id="memcharge" name="memcharge">
  						<option value="없음">없음</option>
						<option value="AC단상">AC단상</option>
						<option value="DC 콤보">DC 콤보</option>
					</select>
				</div>
				</div>
			</div>
			
			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
					<label for="check" class="col-form-label"><span id="star">*</span>개인정보수집동의</label>
					<input type="checkbox" id="check" name="check">
				</div>
				<div id="birth_msg" class="form-text"></div>
			</div>
			
			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
					<input style="width: 300px;" type="submit" id="bnt_submit" class="btn btn-success" value="가입" />
				</div>
			</div>		
		</form>
	</div>
	</div>
	</main>
	
	<footer class="container-fluid my-3 d-flex justify-content-center align-items-center border-top" style="height: 100px;">
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
				
				$.ajax({
					url : "/check",
					data : "id=" + id,
					dataType : "json",
					success : function(data) {
						console.log("1 = 중복o / 0 = 중복x : "+ data);							
						
						if (data == 1) {
								// 1 : 아이디가 중복되는 문구
								$("#id_msg").text("사용중인 아이디입니다.");
								//$("#bnt_submit").attr("disabled", true);
								return false;
							} else {							
								if(id_ck.test(id)){
									// 0 : 아이디 길이 / 문자열 검사
									$("#id_msg").text("사용가능한 아이디입니다.");
									//$("#id_msg").css("color", "green");
									//$("#bnt_submit").attr("disabled", false);
						 
								} else {									
									$('#id_msg').text("아이디는 소문자와 숫자만 가능합니다.");
									//$("#bnt_submit").attr("disabled", true);
									return false;
								}
								
							}
						}, error : function() {
								console.log("실패");
						}
					});
				});
			
			$("#mempw").blur(function() {
				$("#pw_msg").text("");
				if ($("#mempw").val() != $("#pw2").val()) {
					$("#pw_msg2").text("비밀번호가 일치하지않습니다.");
					return false;
				}
				if (!$("#mempw").val()) {
					$("#pw_msg").text("비밀번호를 입력해주세요.");
					return false;
				}
			});
			
			$("#pw2").blur(function() {
				$("#pw_msg2").text("");
				if ($("#mempw").val() != $("#pw2").val()) {
					$("#pw_msg2").text("비밀번호가 일치하지않습니다.");
					return false;
				} 
				if (!$("#pw2").val()) {
					$("#pw_msg2").text("비밀번호 확인을 입력해주세요.");
					return false;
				}
			});
			
/* 			$("#mempw").keyup(function() {
				$("#pw_msg").text("");
				if ($("#mempw").val() != $("#pw2").val()) {
					$("#pw_msg").text("비밀번호가 일치하지않습니다.");
				} else {
					$("#pw_msg").text("");
				}
			});
			
			$("#pw2").keyup(function() {
				if ($("#mempw").val() != $("#pw2").val()) {
					$("#pw_msg").text("비밀번호가 일치하지않습니다.");
				} else {
					$("#pw_msg").text("");
				}
			}); */
			
			$("#name").blur(function() {
				let name = $("#name").val();
				let name_ck = /^[가-힣]*$/;
				
				$("#name_msg").text("");
				if(!$("#name").val()){
					console.log("이름 빈칸");
					$("#name_msg").text("이름을 입력해주세요.");
					return false;
				}
				if (!name_ck.test(name)) {
					$("#name_msg").text("한글만 입력가능합니다.");
					return false;
				} else {
					$("#name_msg").text("");
				}
			});
					
			// 이메일 인증
			/* $("#selectEmail").change(function(){ 
				$("#selectEmail option:selected").each(function (){ 
					if($(this).val()== '1'){//직접입력일 경우 
						$("#mememail2").val(""); //값 초기화 
						$("#mememail2").attr("disabled",false); //활성화 
					}else{ //직접입력이 아닐경우 
						$("#mememail2").val($(this).text());//선택값 입력 
						$("#mememail2").attr("disabled",true); //비활성화 
					} 
				}); 
			}); */
			
			$("#mail_ck").on("click", function() {
				let email = $("#mememail").val();
				//let email = $("#mememail1").val()+"@"+$("#mememail2").val();
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
					url : "/send",
					data : "emailAddress=" + email,
					dataType : "json"
				}).done(function(data) {
					if (eval(data[1])) {
						num = data[0];
						alert("메일이 전송되었습니다. 인증번호를 입력하세요.");
						$("#num_in").attr("disabled", false);
						$("#num_ck").attr("disabled", false);
					}
				});
			})
		
			$("#num_ck").on("click", function() {
						let num_in = $("#num_in").val();
						let email = $("#mememail").val();
						//let email = $("#mememail1").val()+"@"+$("#mememail2").val();
						
						if (num_in == num) {
							$("#mememail").attr("readonly", true);
							//$("#mememail1").attr("readonly", true);
							$("#num_in").attr("readonly", true);
							$("#num_msg").text("인증완료");
							$("#num_msg").append("<input type='hidden' id='ck' value='1'>");
							//$("#num_msg").append("<input type='hidden' name='mememail' value='"+email+"'>");
						} else {
							$("#num_msg").text("인증 실패했습니다.");
						}
				})
				
			$("#bnt_address").on("click",function() {
					new daum.Postcode({
						oncomplete : function(data) {
							//document.getElementById('zipcode').value = data.zonecode;
							document.getElementById("memaddress").value = data.address;
						}
					}).open();	
			})
				
			$("#member").submit(function(){
			//$("#bnt_submit").on("click",function(){
				console.log("제출");
				if(!$("#id").val()){
					console.log('아이디 빈칸');
					$("#id_msg").text("아이디를 입력주세요.")
					return false;
				}
				if(!$("#mempw").val()){
					console.log('비밀번호 빈칸');
					$("#pw_msg").text("비밀번호를 입력주세요.")
					return false;
				}
				if(!$("#name").val()){
					console.log("이름 빈칸")
					$("#name_msg").text("이름를 입력주세요.")
					return false;
				}
				if(!$("#mememail").val()){
					$("#email_msg").text("이메일을 입력주세요.")
					return false;
				}
				/* if(!$("#mememail1").val()){
					$("#email_msg").text("이메일을 입력주세요.")
					return false;
				}
				if(!$("#mememail2").val()){
					$("#email_msg").text("이메일을 입력주세요.")
					return false;
				} */
				if($("#ck").val() != 1){
					$("#email_msg").text("이메일 인증해주세요.")
					return false;
				}
				if(!$("#memaddress").val()){
					$("#address_msg").text("주소를 입력주세요.")
					return false;
				}
				if(!$("#memaddressdetail").val()){
					$("#address_msg2").text("상세주소를 입력주세요.")
					return false;
				}
				if(!$("#membirth").val()){
					$("#birth_msg").text("생년월일을 입력주세요.")
					return false;
				}
				if(!$("#check").prop("checked")){
					$("#check_msg").text("개인정보수집 동의해주세요.")
					return false;
				}
				
				//let email = $("#mememail1").val()+"@"+$("#mememail2").val();
				/* let form = $("#member").serialize();
				$.ajax({
					type : "post",
					url : "/join",
					data : form,
					dataType : "json",
					 success: function () {
						 //location.href = "/join_success";
						 console.log("success");				 
							 
		            },
		                error: function (status, err) {
		                    console.log(status +"error:"+ err);
		            }
				
				}) //ajax */
			})
		});
	</script>
</body>

</html>
