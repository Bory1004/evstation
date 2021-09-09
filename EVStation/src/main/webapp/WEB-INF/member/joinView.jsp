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
<script>
	function sample4_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				//document.getElementById('zipcode').value = data.zonecode;
				document.getElementById("memaddress").value = data.address;
			}
		}).open();
	}
	
</script>
<style>
	#error, #id_msg, #star {color: red;}
	#input , #result{ display: none;}
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
		<div class="container input-group d-flex justify-content-center">
		<div id="content">
		
		<form id="member" action="/join" method="post">
		<div id="star">* 필수입력 사항</div>
			
			<div class="row g-3 align-items-center">
  				<div class="col-auto">
    				<label for="id" class="col-form-label"><span id="star">*</span> 아이디</label>
  				</div>
  				<div class="col-auto">
  					<input type="text" id="id" name="id" class="form-control" maxlength="20"/>
  				</div>
  				<div class="col-auto">
    				<input type="button" id="id_check" class="btn btn-success justify-content-center" value="중복확인">
  				</div>
  				<div class="col-auto">
    				<span id="id_msg" class="form-text"></span>
  				</div>
			</div>
		
			<div class="row g-3 align-items-center">
  				<div class="col-auto">
    				<label for="mempw" class="col-form-label"><span id="star">*</span> 비밀번호</label>
  				</div>
  				<div class="col-auto">
  					<input type="password" id="mempw" name="mempw" class="form-control" maxlength="20">
  				</div>
  				<div class="col-auto">
    				<span id="pw_msg" class="form-text"></span>
  				</div>
			</div>
			
			<div class="row g-3 align-items-center">
  				<div class="col-auto">
    				<label for="pw2" class="col-form-label"><span id="star">*</span> 비밀번호 확인</label>
  				</div>
  				<div class="col-auto">
  					<input type="password" id="pw2" name="pw2" class="form-control" maxlength="20">
  				</div>
			</div>
				
			<div class="row g-3 align-items-center">
  				<div class="col-auto">
    				<label for="name" class="col-form-label"><span id="star">*</span> 이름</label>
  				</div>
  				<div class="col-auto">
  					<input type="text" id="name" name="name" class="form-control" maxlength="20">
  				</div>
  				<div class="col-auto">
    				<span id="name_msg" class="form-text"></span>
  				</div>
			</div>	

			<div class="row g-3 align-items-center">
  				<div class="col-auto">
    				<label for="mememail" class="col-form-label"><span id="star">*</span> 이메일</label>
  				</div>
  				<div class="col-auto">
  					<input type="text" id="mememail" name="mememail" class="form-control" maxlength="20">
  				</div>
  				<div class="col-auto">
  					<button id="mail_ck" class="btn btn-success justify-content-center">메일 인증</button>
  				</div>
  				<div id="input">
						<input id="ck_num"><input type="button" id="ck_b" value="인증 확인"></div>
				<div style="color: red" id="result"></div>
  				
  				<div class="col-auto">
    				<span id="emailresult" class="form-text"></span>
  				</div>
			</div>
			
				
					휴대폰
					<input id="memphone" size="20" maxlength="20" />
				
					<span id="star">*</span> 주소
					<input id="memaddress" name="memaddress" readonly>
					<button class="btn btn-success justify-content-center" onclick="sample4_execDaumPostcode()">주소 검색</button>
					<div style="color: red" id="address_msg"></div>
				
					<span id="star">*</span> 상세주소 <input type="text" id="memaddressdetail" name="memaddressdetail" size="50"/>
					
					<div style="color: red" id="address_msg"></div>
				
					<span id="star">*</span> 생년월일
					<input id="membirth" name="membirth" size="20" maxlength="20" placeholder="ex) 20210101" />
												
				
					<span>  </span>차종/충전타입
					<select id="memcar" name="memcar">
							<option value="없음">없음</option>
							<option value="현대">현대</option>
							<option value="기아">기아</option>
							<option value="테슬라">테슬라</option>
						</select>
						<select id="memcharge" name="memcharge">
							<option value="AC단상">AC단상</option>
							<option value="DC 콤보">DC 콤보</option>
						</select>
					
				
					<span id="star">*</span> 개인정보수집동의
					<input type="checkbox" id="check" name="check">동의
					<span style="color: red" id="check_msg"></span>
				
					<input type="submit" value="가입" />
				
			
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
			$("#id_check").click(function(){
				let id = $("#id").val();	
				if(!id){
					$("#id_msg").html("아이디를 입력하세요");
					return false;
				}
				$.ajax({
					url:"/check_id",
				 	data:"id="+id,
					dataType:"text"}
				).done(function(data){
					if(data == ""){
						$("#id_msg").html("사용할 수 있는 아이디 입니다.")
						$("#id_msg").append("<input type='hidden' id='id_ck' value='1'>");
					}else{
						$("#id_msg").html("이미 사용중인 아이디 입니다.")
					}
				})
			});
						
			$("#mempw").keyup(function() {
				$("#pwmsg").text('');
				if ($("#mempw").val() != $("#pw2").val()) {
					$("#pw_msg").text('');
					$("#pw_msg").html('비밀번호가 일치하지않습니다.');
				} else {
					$("#pw_msg").text('');
					$("#pw_msg").html('');
				}
			});
			
			$("#pw2").keyup(function() {
				if ($("#mempw").val() != $("#pw2").val()) {
					$("#pw_msg").text('');
					$("#pw_msg").html('비밀번호가 일치하지않습니다.');
				} else {
					$("#pw_msg").text('');
					$("#pw_msg").html('');
				}
			});

			$("#mail_ck").click(function() {
				let email = $("#mememail").val();
				let email_ck =/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
				
				if (!email) {
					$("#result").css("display", "block").html("메일 주소를 입력하세요");
					return false;
				}
				
				if(email_ck.test(email) == false ){
					$("#result").css("display", "block").html("메일 형식에 맞게 입력하세요");
					return false;
				}
				$.ajax({
					url : "/send",
					data : "emailAddress=" + email,
					dataType : "json"
				}).done(function(data) {
					if (eval(data[1])) {
						num = data[0];
						alert("메일이 전송되었습니다. 인증번호를 입력하세요.")
						$("#input, #result").css("display", "block");
					}
				});
			})
			$("#ck_b").click(
					function() {
						let ck_num = $("#ck_num").val();
						if (ck_num == num) {
							$("#result").html("인증이 확인되었습니다.")
							$("#result").append("<input type='hidden' id='ck' value='1'>");
						} else {
							$("#result").html("인증 실패했습니다. 다시 확인하세요.");
						}
				})
				
			$("#member").submit(function(){
				if(!$("#id").val()){
					$("#id_msg").html("아이디를 입력해야 합니다.")
					return false;
				}
				if(!$("#mempw").val()){
					$("#pw_msg").html("비밀번호를 입력해야 합니다.")
					return false;
				}
				if(!$("#name").val()){
					$("#name_msg").html("이름를 입력해야 합니다.")
					return false;
				}
				if(!$("#mememail").val()){
					$("#emailresult").html("이메일을 입력해야 합니다.")
					return false;
				}
				if(!$("#memaddress").val()){
					$("#address_msg1").html("주소를 입력해야 합니다.")
					return false;
				}
				if(!$("#memaddressdetail").val()){
					$("#address_msg2").html("상세주소를 입력해야 합니다.")
					return false;
				}
				if($("#id_ck").val() != 1){
					$("#id_msg").html("아이디 중복 체크 하셔야 합니다.")
					return false;
				}
				if($("#ck").val() != 1){
					$("#result").html("이메일 인증을 입력해야 합니다.")
					return false;
				}
				if(!$("#check").prop("checked")){
					$("#check_msg").html("개인정보수집 동의해야합니다.")
					return false;
				}
			})
		});
	</script>
</body>

</html>
