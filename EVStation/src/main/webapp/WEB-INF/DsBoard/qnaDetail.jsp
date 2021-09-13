<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="DsLayout/dsHeader.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<c:if test="${detail.boardwriter == member.getId() or member.getId() == 'admin' }" > <!--  같은 아이디만 수정 삭제 가능 -->
		<button type="button" class="btn btn-success"
			onclick="location.href='/updateQnAform/${detail.boardnum}';">수정</button>
		<button type="button" class="btn btn-warning"
			onclick="location.href='/deleteQnA/${detail.boardnum}/${detail.boardref}';">삭제</button>
		</c:if>
		<button type="button" class="btn btn-secondary"
			onclick="location.href='/qnaList';">글목록</button>
		<c:if test="${member.getId() == 'admin'}"> <!--  관리자 id : admin  .. 관리자만이 답변 달수 있도록 --> 
		<button type="button" class="btn btn-primary"
			onclick="location.href='/qnaReplyForm/${detail.boardnum}/${detail.boardref}/${detail.boardrestep}/${detail.boardrelevel }';">답글달기</button>
		</c:if>
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<div class="table table-responsive">
					<table class="table table-striped" >
						<tr>
							<td>제목</td>
							<td>${detail.boardtitle}</td>
						</tr>
						<tr>
							<td>작성자</td>
							<td>${detail.boardwriter}</td>
						</tr>
						<tr>
							<td>내용</td>
							<td>${detail.boardcontent}</td>
						</tr>
						<tr>
							<td>등록일</td>
							<td><fmt:formatDate
									value="${detail.boarddate}" pattern="MM.dd" /></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
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
				<li id="reply--1"
					class="list-group-item d-flex justify-content-between">
					<div>댓글 내용입니다!!</div>
					<div class="d-flex">
						<!--  display 일자로 -->
						<div class="font-italic">작성자:I could not set reply &nbsp;</div>
						<button class="badge badge-dark">삭제</button>
					</div>
				</li>
			</ul>
		</div>
	</div>

	<%@ include file="DsLayout/dsFooter.jsp"%>
</body>
</html>



