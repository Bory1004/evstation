<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>회원탈퇴</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
#drawform {
	position : relative;
	width : 400px;
	
	top : 50px;
	left: 10px;
	text-align : center;
}
</style>
<body>
<div id="drawform">
<img src="/img/logo.png" width="140" height="100"><br><br>
<h2>회원 탈퇴</h2><br>
<span>탈퇴하면 회원님의 모든 정보가 삭제되고, 복구하실 수 없습니다. 정말 탈퇴하시겠습니까?</span><br><br>
<span><a class="btn btn-sm btn-outline-success" href="#" onclick="withdraw()" style="width:80px;">탈퇴</a></span> 
<span><button class="btn btn-sm btn-outline-success" onclick="window.close()" style="width:80px;">취소</button></span>
</div>
</body>
<script>
	function withdraw(){
		let memnum = '${member.memnum}'
		$.ajax({
			type : "get",
			url : "/withdraw/"+memnum,
			dataType : "text"
		}).done(function(data){
			window.location.href="http://localhost:8088/withdrawCom"
			window.opener.location.href="http://localhost:8088/logout";
		}).fail(function(e){
			alert("실패")
			alert(e.responseText);
		})
	}
</script>
</html>