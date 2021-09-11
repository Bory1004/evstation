<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<form action="/update" method="post">
	<input type="hidden" name="boardnum" value="${board.boardnum}">
<table>
	<tr><td>제목</td><td><input name="boardtitle" id="boardtitle" value="${board.boardtitle}"></td></tr>
	<tr><td>작성자</td><td>${board.boardwriter}</td></tr>
	<tr><td>내용</td><td><textarea name="boardcontent" id="boardcontent">${board.boardcontent}</textarea></td></tr>
	<tr><td colspan="2">
	<input type="submit" id="bnt" value="글 수정">	
	<a href="/getBoardList">글 목록</a>
	</td></tr>
</table>
</form>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
/* $(function() {
	$("#bnt").click(function() {
		let title = $("#boardtitle").val();
		let content = $("#boardcontent").val();
		
		alert(title);
		$.ajax({
			url : "/update",
			data : {"content":content,"title":title},
			dataType : "json"
		}); //ajax
	}); //bnt
}); */
</script>

</body>
</html>