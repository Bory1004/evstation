<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<table>
	<tr><td>번호</td><td>${board.st_num }</td></tr>
	<tr><td>충전소이름</td><td>${board.st_name }</td></tr>
	<tr><td>주소</td><td>${board.st_address1 }</td></tr>
	<tr><td>휴무일</td><td>${board.st_closedday }</td></tr>
	<tr><td colspan="2">
	<a href="/updateform/${board.num}">글 수정</a>	
	<a href="/delete/${board.num}">글 삭제</a>
	<a href="/getBoardList">글 목록</a>
	</td></tr>
</table>
</body>
</html>