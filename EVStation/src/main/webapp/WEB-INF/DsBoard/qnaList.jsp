<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <style >
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
<div class="container">

  <table class="table table-hover table zebra-stripes" >
 <tr>
	<th><b>No.</b></th>	
	<th><b>제목</b></th>
	<th><b>작성자</b></th>
	<th><b>작성일</b></th>
	<th><b>답변여부</b></th>
</tr>

<c:forEach items="${list}" var="list">
<tr>
<td>${list.board_num}</td>
<td><a href="qnaDetail/${list.board_num}">${list.board_title}</a></td>
<td>${list.board_writer}</td>
<td><fmt:formatDate value="${list.board_date}" pattern="MM.dd" /></td>
<td>${list.board_yn}</td>
</tr>
</c:forEach>  
</table>
<button type="button" onclick="location.href='/insertQnA';" >글쓰기</button>
</div>			
</body>
</html>