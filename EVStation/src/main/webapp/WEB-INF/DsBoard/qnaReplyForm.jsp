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
<form action="/qnaReply"  method="post" >
	<input type="hidden" name ="ref" value="${ref }">
	<input type="hidden" name ="restep" value="${restep }">
	<input type="hidden" name ="relevel" value="${relevel }">

	<table border="1">
		<tr>
			<td class="orange">제목</td>
			<td><input name="boardtitle"/></td>
			</tr>
			<tr> 
			<td class="orange">이메일</td>
			<td><input name="boardemail"/></td>
		</tr>
		<tr>
			<td class="orange">작성자</td>
			<td><input name="boardwriter"/></td>
		</tr>
		
		<tr>
			<td class="orange">내용</td>
			<td><textarea name="boardcontent" cols="40" rows="10"></textarea></td>
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