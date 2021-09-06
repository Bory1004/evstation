<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="DsLayout/dsHeader.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table {
	border-collapse: collapse;
}
</style>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
</head>
<body>
	<div class="container">

		<button type="button"
			onclick="location.href='/updateQnAform/${detail.boardnum}';">수정</button>
		<button type="button"
			onclick="location.href='/deleteQnA/${detail.boardnum}';">삭제</button>
		<button type="button" onclick="location.href='/qnaList';">글목록</button>
		<table border="1">
			<tr>
				<td>제목</td>
				<td>${detail.boardtitle }</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>${detail.boardwriter }</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>${detail.boardcontent }</td>
			</tr>
			<tr>
				<td>등록일</td>
				<td><fmt:formatDate value="${detail.boarddate }"
						pattern="MM.dd" /></td>
			</tr>
		</table>
		<div class="card">
			<div class="card-body">
				<textarea id="reply-content" class="form-control" rows="1"></textarea>
			</div>
			<div class="card-footer">
				<button id="btn-reply-save" class="btn btn-primary">등록</button>
			</div>
		</div>
		<br />
		<div class="card">
			<div class="card-header">댓글리스트</div>
			<ul id="reply-box" class="list-group">
				<li id="reply--1" class="list-group-item d-flex justify-content-between">
				<div>댓글 내용입니다!!</div>
				<div class="d-flex"><!--  display 일자로 -->
				<div class="font-italic">작성자:I could not set reply &nbsp;</div>
				<button class="badge badge-dark">삭제</button>
				</div>
				</li>
			</ul>
		</div>
	</div>
	<button type="button" onclick="location.href='/qnaReplyForm/${detail.boardnum}/${detail.ref}/${detail.restep}';">답글달기</button>
	<%@ include file="DsLayout/dsFooter.jsp"%>
</body>
</html>



