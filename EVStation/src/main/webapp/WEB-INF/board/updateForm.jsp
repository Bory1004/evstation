<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>글 수정</title>
</head>
<body>
<form action="/update" method="post">
	<input type="hidden" name="num" value="${board.num}"><!--???  -->
<table>
	<tr><td>제목</td><td><input name="title" value="${board.title }"></td></tr>
	<tr><td>내용</td><td><textarea name="content">${board.content}</textarea></td></tr>
	<tr><td colspan="2"><input type="submit" value="수정">
	<a href="/getBoardList">목록으로</a></td></tr>
</table>
</form>
</body>
</html>