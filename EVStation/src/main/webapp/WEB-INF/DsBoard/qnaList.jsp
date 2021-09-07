<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="DsLayout/dsHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
table {
	width: 500px;
	border-collapse: collapse;
}

th {
	background-color: grey;
	width: 150px;
}
</style>
</head>

<body>
	<h2 align="center" style="color: green;">QnA게시판</h2>
	<br>
	<div class="container">
		<c:if test="${ total != 0}">
			<table class="table table-hover table zebra-stripes">
				<tr>
					<th><b>No.</b></th>
					<th><b>제목</b></th>
					<th><b>작성자</b></th>
					<th><b>작성일</b></th>
					<th><b>조회수</b></th>
					<th><b>답변여부</b></th>
				</tr>

				<c:forEach items="${list}" var="list">
					<tr>
						<td>${list.boardnum}</td>
						<td><a href="qnaDetail/${list.boardnum}">
						<c:if test="${list.relevel == 1 }" >[답변]</c:if>
						<c:if test="${list.relevel > 1 }">&nbsp; [답변]
						<c:forEach begin="2" end="${list.relevel}">
								Re:
						</c:forEach>
						</c:if>
						${list.boardtitle}
						</a></td>
						<td>${list.boardwriter}</td>
						<td><fmt:formatDate value="${list.boarddate}" pattern="MM.dd" /></td>
						<td>${list.boardsee}</td>
						<td>${list.boardyn}</td>
					</tr>
				</c:forEach>
			</table>

			<div id="page">
				<c:if test="${search == null }">
					<c:if test="${begin > 2 }">
						<a href="/qnaList?p=${begin-1}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin }" end="${end}" var="i">
						<a href="/qnaList?p=${i}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage }">
						<a href="/qnaList?p=${end+1}">[다음]</a>
					</c:if>
				</c:if>
				<c:if test="${search != null }">
					<c:if test="${begin > 2 }">
						<a href="/qnaList?p=${begin-1}&search=${search}&searchn=${searchn}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin }" end="${end}" var="i">
						<a href="/qnaList?p=${i}&search=${search}&searchn=${searchn}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage }">
						<a href="/qnaList?p=${end+1}&search=${search}&searchn=${searchn}">[다음]</a>
					</c:if>
				</c:if>

			</div>
		</c:if>
		<c:if test="${total == 0}">
			검색 결과가 없습니다.
		</c:if>
	<button type="button"  class="btn btn-outline-success"  onclick="location.href='/insertQnA';">글쓰기</button>
	<form>
		<select  class="selectpicker"   name="searchn">
			<option value="0">제목</option>
			<option value="1">내용</option>
			<option value="2">작성자</option>
		</select>
		<input class="form-control input-sm form-control-borderless"  name="search" type="search" placeholder="Search topics or keywords">
		<input class="btn btn-lg btn-success"  type="submit" value="검색" />
	</form>
	</div>
	<%@ include file="DsLayout/dsFooter.jsp"%>
</body>
</html>