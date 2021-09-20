<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>회원탈퇴</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<style>
button {
border-radius: 50%;
}
</style>
<body>
${member }
<span> 회원 탈퇴를 하시겠습니까?</span>

<span><a class="btn btn-sm btn-outline-success" href="/withdraw/${member.memnum}">확인</a></span> 
<span><button class="btn btn-sm btn-outline-success" onclick="window.close()">취소</button></span>
</body>
</html>