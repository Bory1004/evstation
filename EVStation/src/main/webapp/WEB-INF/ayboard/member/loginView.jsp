<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>회원 로그인</title>
</head>
<body>
<h1>로그인</h1>
<form action="login" method="post">
<table align="center" border="1" cellpadding="0" cellspacing="0">				
	<tr>
		<td bgcolor="orange" >아이디</td>
		<td><input name="id" type="text" size="10"></td>
	</tr>
	<tr>
		<td bgcolor="orange" >비밀번호</td>
		<td><input name="password" type="password" size="10"></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="로그인">
			<a href="/joinView">회원 가입</a>
		</td>  
	</tr>
</table>
</form>	

<script>

/* function init() {
	alert("id : " + sessionStorage.getItem('id'));
	alert("name : " + sessionStorage.getItem('name'));
} */
</script>

</body>
</html>