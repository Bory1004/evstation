<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>글 작성</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
		
	<!-- 	<tr>
			<td class="orange">내용</td>
			<td><textarea name="boardcontent" cols="40" rows="10"></textarea></td>
		</tr>
		 -->
		 	</table>
		<div class="input-group">
		<div class="col-4">
  			<span class="input-group-text">내용</span> <textarea class="form-control"  aria-label="With textarea"  name="boardcontent"  rows="5" ></textarea>
			</div>
		</div>
		
		
		
		
		
		
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="확인"> 
			</td>
		</tr>

</form>
</body>
</html>