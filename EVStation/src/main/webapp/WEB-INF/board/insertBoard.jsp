<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>글 작성</title>

</head>
<body>
<form method="post">
<pre>

제목  <input name="title"/>

작성자 <input name="writer"/>

내용<textarea name="content" cols="40" rows=10></textarea>

<input type="submit" value="등 록"/> 

<button type="button" onclick="location.href='getBoardList' ">목록으로</button>

</pre>

</form>
</body>
</html>