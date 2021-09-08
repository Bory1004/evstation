<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>메인 페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function(){
		$.ajax({
			type : "post",
			url : "/updateComment",
			data : form1,
			dataType : "json"
		}).done(function() {
			
		}); //ajax
	});
</script>
</head>
<body>
<h2>메인 페이지</h2>
<%
Cookie[] cookies = request.getCookies();
if(cookies != null){
    for(Cookie tempCookie : cookies){
        if(tempCookie.getName().equals("id")){
            
            
        }
    }
}

%>
<div><a href="loginView">로그인</a> <a href="joinView">회원가입</a></div>

<div><a href="logout">로그아웃</a></div>
<br>
<p align="center"><a href="getBoardList">글 목록 바로가기</a></p>
</body>
<script>

</script>
</html>