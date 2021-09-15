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
					<label for="memphone" class="col-form-label">휴대전화</label>
					<input type="text" id="memphone" name="memphone" class="form-control" maxlength="20" placeholder="-없이 입력해주세요. ex) 01011112222">
					<div id="phone_msg" class="form-text"></div>
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
					<input style="width: 200px;" type="submit" id="bnt_submit" class="btn btn-success" value="가입" />
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
				if ($("#mempw").val() != $("#pw2").val() && $("#pw2").val() != "") {
					$("#pw_msg2").text("비밀번호가 일치하지않습니다.");
					return false;
				}
				if (!$("#mempw").val()) {
					$("#pw_msg").text("비밀번호를 입력해주세요.");
					return false;
				}
				if (!$("#mempw").val()) {
					$("#pw_msg").text("비밀번호를 입력해주세요.");
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
					$("#pw_msg2").text("비밀번호가 일치하지않습니다.");
					return false;
				} 
				if (!$("#pw2").val()) {
					$("#pw_msg2").text("비밀번호 확인을 입력해주세요.");
					return false;
				}
				if ($("#mempw").val() == $("#pw2").val() && $("#mempw").val() != "" && $("#pw2").val() != "") {
					$("#pw_msg").text("");
					$("#pw_msg2").text("");
				} 
			});
			
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
			
			let email = null;
			$("#mail_ck").on("click", function() {
				//let email = $("#mememail").val();
				email = $("#mememail1").val()+"@"+$("#mememail2").val();
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
				});
			})
			
			let email2 = null;
			//인증번호 입력완료
			$("#num_ck").on("click", function() {
				let num_in = $("#num_in").val();
				//let email = $("#mememail").val();
				email2 = $("#mememail1").val()+"@"+$("#mememail2").val();
						
				if (num_in == num) {
					//$("#mememail").attr("readonly", true);
					if(email != email2){
						$("#num_msg").text("인증 실패했습니다.");
					}
					else{
						$("#mememail1").attr("readonly", true);
						$("#num_in").attr("readonly", true);
						$("#num_msg").text("인증완료");
						$("#num_msg").append("<input type='hidden' id='ck' value='1'>");
						$("#num_msg").append("<input type='hidden' name='mememail' value='"+email+"'>");
					}			
				} else {				
					$("#num_msg").text("인증 실패했습니다.");
				}
			})
			
			//주소
			$("#bnt_address").on("click",function() {
				new daum.Postcode({
					oncomplete : function(data) {
					//document.getElementById('zipcode').value = data.zonecode;
					document.getElementById("memaddress").value = data.address;
					}
				}).open();	
			})
			
				
			// 생년월일	birthJ 유효성 검사
			$("#membirth").blur(function(){
				
			// 생일 유효성 검사
			let birthJ = false;			
			let dateStr = $("#membirth").val();		
	    	let year = Number(dateStr.substr(0,4)); // 입력한 값의 0~4자리까지 (연)
	   	 	let month = Number(dateStr.substr(4,2)); // 입력한 값의 4번째 자리부터 2자리 숫자 (월)
	    	let day = Number(dateStr.substr(6,2)); // 입력한 값 6번째 자리부터 2자리 숫자 (일)
	    	let today = new Date(); // 날짜 변수 선언
	    	let yearNow = today.getFullYear(); // 올해 연도 가져옴
		
	    	if (dateStr.length <=8) {
			// 연도의 경우 1900 보다 작거나 yearNow 보다 크다면 false를 반환합니다.
		    if (1900 > year || year > yearNow){		    	
		    	$('#birth_msg').text('생년월일을 확인해주세요.');
		    	return false;
		    	
		    }else if (month < 1 || month > 12) {		    		
		    	$('#birth_msg').text('생년월일을 확인해주세요.');
		    	return false;
		    
		    }else if (day < 1 || day > 31) {		    	
		    	$('#birth_msg').text('생년월일을 확인해주세요.');
		    	return false;
		    	
		    }else if ((month==4 || month==6 || month==9 || month==11) && day==31) {
		    	$('#birth_msg').text('생년월일을 확인해주세요.');
		    	return false;
		    	 
		    }else if (month == 2) {
		    	 
		       	var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
		       	
		     	if (day>29 || (day==29 && !isleap)) {		     		
		     		$('#birth_msg').text('생년월일을 확인해주세요.');
		     		return false;
		    	
				}else{
					$('#birth_msg').text('');
					birthJ = true;
				}//end of if (day>29 || (day==29 && !isleap))
		     	
		    }else{		    	
		    	$('#birth_msg').text(''); 
				birthJ = true;
			}//end of if
			
			}else{
				//1.입력된 생년월일이 8자 초과할때 :  auth:false
				$('#birth_msg').text('생년월일을 확인해주세요.');
				return false;
			}
		});
			
			//휴대폰번호
			$("#memphone").blur(function(){
				let phone_ck = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
				
				let phone = $("#memphone").val();
				
				if(!$("#memphone").val()){
					$('#phone_msg').text("");
					return true;
				}
				
				if(!phone_ck.test(phone)){
					$('#phone_msg').text("번호를 확인해주세요.");
					return false;
				}else {
					$('#phone_msg').text("");
				}			
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
				if(!$("#pw2").val()){
					console.log('비밀번호 빈칸');
					$("#pw_msg2").text("새 비밀번호를 입력주세요.")
					return false;
				}
				if(!$("#name").val()){
					console.log("이름 빈칸")
					$("#name_msg").text("이름를 입력주세요.")
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
				
/* 				let form = $("#member").serialize();
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
