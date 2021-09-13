<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="DsLayout/dsHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>글 작성</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
</style>
</head>
<body>
	<form action="/updateQnA" method="post">
		<input type="hidden" name="boardnum" value="${boardnum}">
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<div class="table table-responsive">
					<table class="table table-striped">
						<tr>
							<td>제목</td>
							<td><input class="form-control" name="boardtitle" /></td>
						</tr>
						<tr>
							<td>이메일</td>
							<td>${member.mememail}</td>
						</tr>
						<tr>
							<td>작성자</td>
							<td>${member.id}</td>
						</tr>

						<tr>
							<td>내용</td>
							<td><textarea class="form-control" name="boardcontent"
									cols="40" rows="10"></textarea></td>
						</tr>
						<tr>
							<td colspan="2" align="center"><input
								class="btn btn-primary" type="submit" value="수정하기"></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</form>
	
<%@ include file="DsLayout/dsFooter.jsp"%>
</body>
</html>