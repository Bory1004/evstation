<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>회원 수정</title>
<style>
	#input , #result{ display: none;}
</style>
</head>
<body>
<h1>회원 수정</h1>
<form action="/getBoardList" method="post">
	<table>
		<tr><td>id</td><td><input name="id"></td></tr>
		<tr><td>password</td><td><input name="password"></td></tr>
		<tr><td>name</td><td><input name="name"></td></tr>
		<tr><td>email</td><td><input name="email">
		<input type="button" id="mail_ck" value="메일 인증">
		<div id="input"><input id="ck_num"> <input type="button" id="ck_b" value="인증 확인"></div>
		<div id="result"></div></td></tr>
		<tr><td colspan="2"><input type="submit" value="수정"></td></tr>
	</table>
	
</form>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	let num ="";
	$(function(){
		
		 $("#mail_ck").click(function(){
		 $.ajax({url:"/send",
				dataType:"json"}
			).done(function(data){
				if(eval(data[1])){
					num = data[0];
					alert("메일이 전송되었습니다. 인증번호를 입력하세요.")
					$("#input,#result").css("display","block");
				}
			}); 
		}) 
		$("#ck_b").click(function(){
			let ck_num = $("#ck_num").val();
			if(ck_num == num){
				$("#result").html("인증이 확인되었습니다.")
				$("#result").append("<input type='hidden' name='ck' value='1'>");
			}else{
				$("#result").html("인증 실패했습니다. 다시 확인하세요.");
			}
		})
		
	})

</script>
</body>
</html>