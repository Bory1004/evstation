<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>목록 보기</title>
<style>
	#center{width:700px; margin-left: auto; margin-right: auto;}
	table{width: 700px; border-collapse : collapse;}
	th{ background-color: orange; width: 150px;}
	a{margin: 10px auto;}
	#page{text-align: center;}
</style>
</head>
<body>
<div id="center">
<h1>게시글 목록</h1>
<!-- <a href="insertBoard">새글 등록</a> -->
<table border="1">
	<tr><th>번호</th><th>충전소이름</th><th>주소</th><th>휴무일</th></tr>
	<c:forEach items="${blist}" var="board">
		<tr><td>${board.st_num}</td>
			<td><a href="/content/${board.st_num}">${board.st_name}</a></td>
			<td>${board.st_address1}</td>
			<td>${board.st_closedday}</td>
		</tr>	
	</c:forEach>
</table>
<div id="page">
<c:if test="${begin > 2 }">
	<a href="/getBoardList?p=${begin-1}">[이전]</a>
</c:if>
	<c:forEach begin="${begin }" end="${end}" var ="i">
		<a href="/getBoardList?p=${i}">[${i}]</a>
	</c:forEach>
<c:if test="${end < totalPage }">
	<a href="/getBoardList?p=${end+1}">[다음]</a>
</c:if>
</div>	
</div>
</body>
</html>