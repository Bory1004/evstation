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