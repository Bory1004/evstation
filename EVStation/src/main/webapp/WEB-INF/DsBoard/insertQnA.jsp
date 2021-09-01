<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>글 작성</title>
<style>
	.orange{background-color: orange;}
	table{border-collapse : collapse;}
</style>
</head>
<body>
<form method="post">
	<table border="1">
		<tr>
			<td class="orange">제목</td>
			<td><input name="board_title"/></td>
			</tr>
			<tr>
			<td class="orange">이메일</td>
			<td><input name="board_email"/></td>
		</tr>
		<tr>
			<td class="orange">작성자</td>
			<td><input name="board_writer"/></td>
		</tr>
		
		<tr>
			<td class="orange">내용</td>
			<td><textarea name="board_content" cols="40" rows="10"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="확인"> 
			</td>
		</tr>
	</table>
</form>
</body>
</html>