<%@ page contentType="text/html; charset=UTF-8"%>
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
	<form action="/qnaReply" method="post">
		<input type="hidden" name="boardref" value="${boardref }"> 
		<input type="hidden" name="boardrestep" value="${boardrestep }"> 
		<input type="hidden" name="boardrelevel" value="${boardrelevel }">
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<div class="table table-responsive">
					<table class="table table-striped">
						<tr>
							<td class="orange">제목</td>
							<td><input class="form-control"  name="boardtitle" /></td>
						</tr>
						<tr>
							<td class="orange">이메일</td>
							<td><input  class="form-control"  name="boardemail" /></td>
						</tr>
						<tr>
							<td class="orange">작성자</td>
							<td>${member.id}</td>
						</tr>

						<tr>
							<td class="orange">내용</td>
							<td><textarea  class="form-control"  name="boardcontent" cols="40" rows="10"></textarea></td>
						</tr>
						<tr>
							<td colspan="2" align="center"><input type="submit"
								class="btn btn-primary" id="mail_ck" value="확인"></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</form>
<%@ include file="DsLayout/dsFooter.jsp"%>
</body>
</html>