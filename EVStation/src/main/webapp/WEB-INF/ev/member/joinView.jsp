<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<style>
	#error, #id_msg {color: red;}
	#input , #result{ display: none;}
</style>
<title>회원가입</title>
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
</head>
<body>
	<h2>회원가입</h2>
	<form:form id="member" modelAttribute="member" action="/join_check" method="post">
		<%-- <form:errors path="*" cssClass="error"/>--%>
		<table>
			<tbody>
				<tr>
					<th>아이디</th>
					<td><form:input path="id" id="id" size="20" maxlength="20" />
					<input type="button" id="id_check" value="중복확인">
					<div id="id_msg"><form:errors id="error" path="id" cssClass="error"/></div>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><form:password path="mempw" id="mempw" size="20" maxlength="20" />
						<span style="color: red" id="pw_msg"><form:errors id="error" path="mempw" cssClass="error" /></span></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" id="pw2" size="20" maxlength="20"></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><form:input path="name" id="name" size="20" maxlength="20" />
					<form:errors id="error" path="name" cssClass="error"/></td>						
				</tr>
				<tr>
					<th>이메일</th>
					<td><form:input path="mememail" id="mememail" size="20" maxlength="20" /> 
						 <input type="button" id="mail_ck" value="메일 인증">
						<form:errors id="error" path="mememail" cssClass="error" />
						<div id="emailresult"></div>
						<div id="input">
						<input id="ck_num"><input type="button" id="ck_b" value="인증 확인"></div>
						<div style="color: red" id="result"></div></td>
				</tr>
				<tr>
					<th>휴대폰</th>
					<td><form:input path="memphone" id="memphone" size="20" maxlength="20" /></td>
				</tr>
				
				<tr>
					<th>주소</th>
					<td><input id="memaddress" name="memaddress" readonly>
					<input type="button" value="주소 검색" onclick="sample4_execDaumPostcode()" /> 
					<div style="color: red" id="address_msg"><form:errors id="error" path="memaddress" cssClass="error" /></div></td>
				</tr>
				<tr>
					<th>상세주소</th>
					<td><form:input path="memaddressdetail" type="text" name="memaddressdetail" id="memaddressdetail" size="50"/>
					<div style="color: red" id="address_msg"></div></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><form:input path="membirth" id="membirth" size="20" maxlength="20" placeholder="ex) 20210101" />
						<form:errors id="error" path="membirth" cssClass="error"/></td>						
				</tr>		
				<tr>
					<th>차종/충전타입</th>
					<td><form:select path="memcar">
							<form:option value="없음" label="없음" />
							<form:option value="현대" label="현대" />
							<form:option value="기아" label="기아" />
							<form:option value="테슬라" label="테슬라" />
						</form:select>
						<form:select path="memcharge">
							<form:option value="AC단상" label="AC단상" />
							<form:option value="DC 콤보" label="DC 콤보" />
						</form:select>
					</td>
				</tr>
				<tr>
					<th>개인정보수집동의</th>
					<td><input type="checkbox" id="check" name="check">동의
					<span style="color: red" id="check_msg"></span></td></tr>
				<tr>
					<td colspan="2"><input type="submit" value="가입" /></td>
				</tr>
			</tbody>
		</table>
	</form:form>
	
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
			});
			
			$("#pw2").keyup(function() {
				if ($("#mempw").val() != $("#pw2").val()) {
					$("#pw_msg").text('');
					$("#pw_msg").html('비밀번호가 일치하지않습니다.');
				} else {
					$("#pw_msg").text('');
					$("#pw_msg").html('비밀번호가 일치합니다.');
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
						$("#input,#result").css("display", "block");
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
				/* if(!$("#id").val()){
					$("#id_msg").html("아이디를 입력해야 합니다.")
					return false;
				}
				if(!$("#password").val()){
					$("#pw_msg").html("비밀번호를 입력해야 합니다.")
					return false;
				}
				if(!$("#name").val()){
					$("#name_msg").html("이름를 입력해야 합니다.")
					return false;
				}
				if(!$("#email").val()){
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
				} */
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
