<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
</head>
<body>
<h2>로그인</h2>
<form id="loginForm" action="login" method="post">
<table>			
	<tr>
		<td>아이디</td>
		<td><input id="id" name="id" type="text" size="10"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input id="mempw" name="mempw" type="password" size="10">
		<input id="login_chk" type="submit" value="로그인"></td> <!-- onclick="loginProcess();" -->
	</tr>
</table>
<input type="checkbox" id="check_cookie" value="check_cookie">로그인 상태 유지<br><br>
<div style="color: red" id="id_pw_msg">${msg}</div>
<br>
아이디찾기 / 비밀번호찾기 / <a href="/joinView">회원가입</a>
</form>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	/* function loginProcess(){
		let id = $("#id").val();
		let pw = $("#mempw").val();
		//let chk = $("#check_cookie").is(":checked");
		
		if(id == ""){
			$("#id_pw_msg").html("아이디를 입력해주세요.")
			$("#id").focus();
			return false;
		}
		if(pw == ""){
			$("#id_pw_msg").html("비밀번호를 입력해주세요.")
			$("#mempw").focus();
			return false;
		}else if($("#check_cookie").prop("checked")){
			setCookie("id", id, 7);
			setCookie("mempw", mempw, 7);
		}else if(!$("#check_cookie").prop("checked")) {
			deleteCookie("id");
			deleteCookie("mempw");
		}
		$("#loginForm").submit();
	}; */
	

	$(function() {
		$("#login_chk").click(function() {
			let id = $("#id").val();
			let pw = $("#mempw").val();

			if (id == "") {
				$("#id_pw_msg").html("아이디를 입력해주세요.")
				$("#id").focus();
				return false;
			}
			
			if (pw == "") {
				$("#id_pw_msg").html("비밀번호를 입력해주세요.")
				$("#mempw").focus();
				return false;
			}

			if ($("#check_cookie").prop("checked")) {
				setCookie("id", id, 7);
				setCookie("mempw", mempw, 7);
			} else {
				setCookie("id", id, -1);
				setCookie("mempw", mempw, -1);
			}
		});
	});
	
	/* $(function() {
		$("#login_chk").click(function() {
			let id = $("#id").val();
			let pw = $("#mempw").val();

			if (id == "") {
				$("#id_pw_msg").html("아이디를 입력해주세요.")
				$("#id").focus();
				return false;
			}
			
			if (pw == "") {
				$("#id_pw_msg").html("비밀번호를 입력해주세요.")
				$("#mempw").focus();
				return false;
			}

			if ($("#check_cookie").prop("checked")) {
				let cookie = "check";
			} else {
				let cookie = "not_check";
			}
			
			$.ajax({
				url : "/login",
				data : "cookie="+cookie,
				dataType : "json"
					
			}).done(function(data){
				if(data == "success"){
					setCookie("id", id, 7);
					setCookie("mempw", mempw, 7);
					location.href("/getBoardList");
				} else {
					location.href("/loginView");
				}
			});
		});
	}); */

	function setCookie(cName, cValue, cDay) {
		let expire = new Date();
		expire.setDate(expire.getDate() + cDay);
		cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
		if (typeof cDay != 'undefined')
			cookies += ';expires=' + expire.toGMTString() + ';';
		document.cookie = cookies;
	}
</script>
</html>