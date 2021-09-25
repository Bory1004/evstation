<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<title>마이페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<style>
@media ( min-width : 768px) {
	.container {
		width: 750px
	}
}

@media ( min-width : 992px) {
	.container {
		width: 840px
	}
}

#alarmpage {
   position :absolute;
   border: solid #BDBDBD 1px;
   border-radius: 20px;
   width : 230px;
   height : 300px;
   left : 1200px;
   padding : 10px;
   overflow-y : auto;
}
#alarmcount {
   position : relative;
   width : 30px;
   height : 20px;
   left : 380px;
   top : 10px;   
   border-radius: 10px;
   text-align : center;
   vertical-align : middle;
}
#alarmcount > span {
   position :relative;
   color : white;
   bottom : 3px;
}

div.form-text {
	color: red;
}

a {
	text-decoration-line: none;
}

#jb-container {
	width: 840px;
	margin: 0px auto;
	padding: 20px;
}

#jb-content {
	width: 580px;
	padding: 20px;
	margin-bottom: 20px;
	float: right;
	border: 1px solid #bcbcbc;
}

#jb-sidebar {
	width: 200px;
	padding: 20px;
	margin-bottom: 20px;
	float: left;
}
.box {
    width: 150px;
    height: 150px; 
    border-radius: 70%;
    overflow: hidden;
}
.profile {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
</style>
</head>
<body>
   <div class="container">
      <header class="py-3">
         <div class="row justify-content-center">
            <div class="col-6 pt-2">
               <a href="/main" class="link-secondary"> 
               <img src="/img/logo.png" width="220" height="100"></a>
               <!--  <a class="link-secondary" href="#">Subscribe</a> -->
            </div>

            <div class="col-6 d-flex-column-reverse justify-content-end align-items-center">
               <!-- justify-content 자식요소 정렬  -->
                                       
               <c:choose>
                  <c:when test="${member.id eq null}">
                     <div style="float:right;">
                        <a class="btn btn-sm btn-outline-success" href="/loginView">로그인</a> 
                        <a class="btn btn-sm btn-outline-success" href="/joinView">회원가입</a>
                     </div>   
                  </c:when>
                  <c:otherwise>
                     <div id="login" style="text-align:right;margin-bottom:10px;"><div id="alarmcount"></div><img style="cursor:pointer;"src="/img/alarm1.png" width="30" height="30" onclick="ring(${member.memnum})">
                     </div>
						<div style="float: right;">						
							<img id="main_profile" style = "border-radius:70%;" src="${member.memphoto}" width="40px" height="auto">${member.name}(${member.id})님 환영합니다!!							
								<div class="dropdown">
									<a class="btn btn-sm btn-outline-success dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">마이페이지</a>
									<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
										<li><a class="dropdown-item" href="/check_mypage">개인정보 수정</a></li>
										<li><a class="dropdown-item" href="/AllBoardList/${member.memnum}">내가 쓴 글</a></li>
										<li><a class="dropdown-item" href="#">즐겨찾기</a></li>
									</ul>
									<a class="btn btn-sm btn-outline-success" href="/logout">로그아웃</a>
								</div>
							</div>
						</c:otherwise>                  
               </c:choose>
            </div>
         </div>

         <div class="menubar py-1 mb-2">
            <nav class="nav d-flex justify-content-center border-top border-bottom">
               <a class="p-2  link-success" href="/pageIntro">페이지 소개</a> 
               <a class="p-2 link-success" href="/getChargeList">충전소 현황</a> 
               <a class="p-2 link-success" href="/benefit">기대효과</a> 
               <a class="p-2 link-success" href="/getFreeBoardList">자유게시판</a> 
               <a class="p-2 link-success" href="/ay/getBoardList">공지사항</a> 
               <a class="p-2 link-success" href="/qnaList">Q&A</a>
            </nav>
         </div>
      </header>
   </div>
	
	<main>
	
		<div id="jb-container">		
			<div id="jb-content">
				<h3>개인정보 수정</h3><br>
				
				<!-- 프로필 사진 변경 -->
				<form class="row" id="member" action="/update_photo" method="post" enctype="multipart/form-data">
					<div class="row mb-3">
						<div class="col" align="center">						
							<div id="preview" class="box">								
								<img id="profile_image" class="profile" src="${member.memphoto}">																			
							</div>
							
							<!-- <label for="file_photo" style="position:absolute;">bottom: 835px;
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-gear" viewBox="0 0 16 16">
	  								<path d="M8 4.754a3.246 3.246 0 1 0 0 6.492 3.246 3.246 0 0 0 0-6.492zM5.754 8a2.246 2.246 0 1 1 4.492 0 2.246 2.246 0 0 1-4.492 0z"/>
	  								<path d="M9.796 1.343c-.527-1.79-3.065-1.79-3.592 0l-.094.319a.873.873 0 0 1-1.255.52l-.292-.16c-1.64-.892-3.433.902-2.54 2.541l.159.292a.873.873 0 0 1-.52 1.255l-.319.094c-1.79.527-1.79 3.065 0 3.592l.319.094a.873.873 0 0 1 .52 1.255l-.16.292c-.892 1.64.901 3.434 2.541 2.54l.292-.159a.873.873 0 0 1 1.255.52l.094.319c.527 1.79 3.065 1.79 3.592 0l.094-.319a.873.873 0 0 1 1.255-.52l.292.16c1.64.893 3.434-.902 2.54-2.541l-.159-.292a.873.873 0 0 1 .52-1.255l.319-.094c1.79-.527 1.79-3.065 0-3.592l-.319-.094a.873.873 0 0 1-.52-1.255l.16-.292c.893-1.64-.902-3.433-2.541-2.54l-.292.159a.873.873 0 0 1-1.255-.52l-.094-.319zm-2.633.283c.246-.835 1.428-.835 1.674 0l.094.319a1.873 1.873 0 0 0 2.693 1.115l.291-.16c.764-.415 1.6.42 1.184 1.185l-.159.292a1.873 1.873 0 0 0 1.116 2.692l.318.094c.835.246.835 1.428 0 1.674l-.319.094a1.873 1.873 0 0 0-1.115 2.693l.16.291c.415.764-.42 1.6-1.185 1.184l-.291-.159a1.873 1.873 0 0 0-2.693 1.116l-.094.318c-.246.835-1.428.835-1.674 0l-.094-.319a1.873 1.873 0 0 0-2.692-1.115l-.292.16c-.764.415-1.6-.42-1.184-1.185l.159-.291A1.873 1.873 0 0 0 1.945 8.93l-.319-.094c-.835-.246-.835-1.428 0-1.674l.319-.094A1.873 1.873 0 0 0 3.06 4.377l-.16-.292c-.415-.764.42-1.6 1.185-1.184l.292.159a1.873 1.873 0 0 0 2.692-1.115l.094-.319z"/>
								</svg>
							</label> -->						
						</div>
					</div>
					<div class="row">
						<div class="col" align="right">
							<label class="btn btn-success" for="file_photo">
								사진변경
							</label>
							<input type="file" id="file_photo" name="file_photo" accept="image/*" onchange="previewImage(this)" style="display:none" />			
						</div>
						
						<div class="col" align="left">
							<input style="width: 80px;" type="submit" id="bnt_photo" class="btn btn-success" value="저장" />
						</div>	
					</div>
				</form>
				
				<form class="row" id="member" action="/update_mypage" method="post">
					<div class="row mb-3">
						<div class="col">
							<label for="id" class="col-form-label">아이디</label>
							<input type="text" id="id" name="id" class="form-control" maxlength="20" aria-describedby="id_msg" value="${member.id}" readonly>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col">
							<label for="mempw" class="col-form-label">새 비밀번호</label>
							<input type="password" id="mempw" name="mempw" class="form-control" maxlength="20" aria-describedby="pw_msg">
							<div id="pw_msg" class="form-text"></div>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col">
							<label for="pw2" class="col-form-label">새 비밀번호 확인</label> 
							<input type="password" id="pw2" name="pw2" class="form-control" maxlength="20" aria-describedby="pw_msg2">
							<div id="pw_msg2" class="form-text"></div>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col">
							<label for="name" class="col-form-label">이름</label>
							<input type="text" id="name" name="name" class="form-control" maxlength="20" aria-describedby="name_msg" value="${member.name}">
							<div id="name_msg" class="form-text"></div>
						</div>
					</div>

					<!-- 메일 인증 -->
					<div class="row mb-3">
						<div class="col">
							<label for="mememail" class="col-form-label">이메일 (이메일 변경 시 메일 인증을 해주세요.)</label>
							<div class="input-group">
								<input type="text" id="mememail1" name="mememail1" class="form-control" maxlength="20" aria-describedby="email_msg" value="${email1}"> 
								@<input type="text" id="mememail2" name="mememail2" class="form-control" disabled value="${email2}">
								<select name="selectEmail" id="selectEmail" class="form-select">
									<option value="1">직접입력</option>
									<option value="naver.com">naver.com</option>
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

					<div class="row mb-3">
						<div class="col">
							<div class="input-group">
								<input type="text" id="num_in" class="form-control" placeholder="인증번호를 입력해주세요." disabled="disabled" aria-describedby="num_msg">
								<button type="button" id="num_ck" class="btn btn-success justify-content-center" disabled>인증 확인</button>
							</div>
							<div id="num_msg" class="form-text"></div>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col">
							<label for="memphone" class="col-form-label">휴대전화</label> 
							<input type="text" id="memphone" name="memphone" class="form-control" maxlength="20" placeholder="-없이 입력해주세요. ex) 01011112222" value="${member.memphone}">
							<div id="phone_msg" class="form-text"></div>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col">
							<label for="memaddress" class="col-form-label">주소</label>
							<div class="input-group">
								<input type="text" id="memaddress" name="memaddress" class="form-control" readonly aria-describedby="address_msg" value="${member.memaddress}">
								<button type="button" id="bnt_address" class="btn btn-success justify-content-center">주소 검색</button>
							</div>
							<div id="address_msg" class="form-text"></div>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col">
							<input type="text" id="memaddressdetail" name="memaddressdetail" class="form-control" maxlength="20" placeholder="상세주소를 입력해주세요." aria-describedby="address_msg2" value="${member.memaddressdetail}">
						</div>
						<div id="address_msg2" class="form-text"></div>
					</div>

					<div class="row mb-3">
						<div class="col">
							<label for="membirth" class="col-form-label">생년월일</label> 
							<input type="text" id="membirth" name="membirth" class="form-control" maxlength="20" placeholder="ex) 20210101" aria-describedby="birth_msg" value="${birth}">
							<div id="birth_msg" class="form-text"></div>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col">
							<label for="memcar" class="col-form-label">차종/충전타입</label>
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
									<option value="DC콤보">DC콤보</option>
								</select>
							</div>
						</div>
					</div>
					
					<div class="col" align="center">	
						<input style="width: 200px;" type="submit" id="bnt_submit" class="btn btn-success" value="저장" />
					</div>				
				</form>
			</div>
			
			<div id="jb-sidebar">
				<div class="row g-3">
					
					<div><a style="width: 150px;" class="btn btn-outline-secondary" href="/mypage">개인정보 수정</a></div>
					<div><a style="width: 150px;" class="btn btn-secondary" href="/AllBoardList/${member.memnum}">내가 쓴 글</a></div>
					<div><a style="width: 150px;" class="btn btn-secondary" href="#">즐겨찾기</a></div>
					<div><a style="width: 150px;" class="btn btn-secondary" href="#" onclick="window.open('http://localhost:8088/withdrawForm','new','scrollbars=no,width=430,height=400,top=100,left=100')">회원탈퇴</a></div>					
				</div>
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
			$("#memcar").val("${member.memcar}").prop("selected", true);
			$("#memcharge").val("${member.memcharge}").prop("selected", true);
			        
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
							
			//$("#member").submit(function(){
			$("#bnt_submit").on("click",function(){
				if(!$("#mempw").val()){
					$("#pw_msg").text("비밀번호를 입력해주세요.")
					return false;
				}
				if(!$("#pw2").val()){
					$("#pw_msg2").text("새 비밀번호를 입력해주세요.")
					return false;
				}
				if(!$("#name").val()){
					$("#name_msg").text("이름를 입력해주세요.")
					return false;
				}
				if(!$("#mememail1").val()){
					$("#email_msg").text("이메일을 입력해주세요.")
					return false;
				}
				if(!$("#mememail2").val()){
					$("#email_msg").text("이메일을 입력해주세요.")
					return false;
				}
				
				if($("#ck").val() != 1){
					let email = $("#mememail1").val()+"@"+$("#mememail2").val();				
					if("${member.mememail}" == email){
						console.log("메일 같음");	
					
						$("#num_msg").append("<input type='hidden' id='ck' value='1'>");
						$("#num_msg").append("<input type='hidden' name='mememail' value='"+email+"'>");
					}else{
						$("#email_msg").text("이메일 인증해주세요.")
						return false;
					}					
				}
				
				if(!$("#memaddress").val()){
					$("#address_msg").text("주소를 입력해주세요.")
					return false;
				}
				if(!$("#memaddressdetail").val()){
					$("#address_msg2").text("상세주소를 입력해주세요.")
					return false;
				}
				if(!$("#membirth").val()){
					$("#birth_msg").text("생년월일을 입력해주세요.")
					return false;
				}
				
				if (confirm("수정하시겠습니까?") == true){    //확인
				    document.form.submit();
				}else{   //취소
				    return false;
				}			
			});
			
			//알림
			$.ajax({
	            type : "get",
	            url : "/countAlarm",
	            data : { "memnum" : '${member.memnum}'},
	            dataType : "text"
	         }).done(function(data){
	            //alert(data)
	            if(data != ""){
	               $('#alarmcount').css('background','#41FF3A')
	               $('#alarmcount').html('<span>'+data+'</span>');
	            }
	         }).fail(function(e){
	            alert("실패")
	            alert(e.responseText)            
	         }) //ajax
			
		});
			
		function ring(x){ //알람 창 열고 데이터 가져오는 함수
	         //alert(${memnum})
	         $.ajax({
	            type : "get",
	            url : "/getAlarm",
	            data : {"memnum" : '${member.memnum}'},
	            dataType : "text"
	         }).done(function(data){
	            //alert("성공")
	            if($('#alarmpage').html()){
	               $('#alarmpage').remove();
	            }else{
	               $('#login').append("<div id='alarmpage'></div>"   );
	               $('#alarmpage').html(data) //alarmpage에 따로만든 jsp파일넣기
	            }
	         }).fail(function(e){
	            alert("실패")
	            alert(e.responseText);
	         })
	      }
	      function delAlarm(x){
	         let alanum = x;
	         let memnum = '${member.memnum}'
	         $.ajax({
	            type : "get",
	            url : "/delAlarm",
	            data : {"alanum" : alanum , "memnum" : memnum},
	            dataType : "text"
	         }).done(function(data){
	            //alert(data)
	            $('#'+alanum).remove();
	            $('#alarmcount').html('<span>'+data+'</span>');
	            
	            if (data == "" ){
	               $('#alarmcount').css('background','white')
	            }
	         }).fail(function(e){
	            alert("실패")
	            alert(e.responseText);
	         })
	      }
	      function checkAlarm(x){
	         let alanum = x;
	         $.ajax({
	            type : "get",
	            url : "/checkAlarm",
	            data : {"alanum" : alanum},
	            dataType : "text"
	         }).done(function(data){
	            alert(data)
	            //$('#'+alanum).children().eq(1).children().eq(0).css("color","red");
	         }).fail(function(e){
	            alert("실패")
	            alert(e.responseText)
	         })
	      }
	      
	      //이미지 크키 조절
	      function resize1(img){
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
	      
	      //프로필 사진
	      function previewImage(f){
	    	let file = f.files;

	    	// 확장자 체크
	    	if(!/\.(gif|jpg|jpeg|png)$/i.test(file[0].name)){
	    		alert('gif, jpg, png 파일만 선택해 주세요.\n\n현재 파일 : ' + file[0].name);
	    		// 선택한 파일 초기화
	    		f.outerHTML = f.outerHTML;
	    		document.getElementById('preview').innerHTML = '';
	    	}
	    	else {
	    		// FileReader 객체 사용
	    		let reader = new FileReader();

	    		// 파일 읽기가 완료되었을때 실행
	    		reader.onload = function(rst){
	    		document.getElementById('preview').innerHTML = '<img onload="resize1(this)" src="' + rst.target.result + '">';
	    	}
	    	// 파일을 읽는다
	    	reader.readAsDataURL(file[0]);	    	
	    }	    
	}
	</script>
</body>

</html>
