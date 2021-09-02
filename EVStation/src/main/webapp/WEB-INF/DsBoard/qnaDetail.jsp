<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	table{ border-collapse : collapse;}
</style>
</head>
<body>
<button type="button" onclick="location.href='/updateQnAform/${detail.boardnum}';">수정</button> <button type="button" onclick="location.href='/deleteQnA/${detail.boardnum}';">삭제</button>
<button type="button" onclick="location.href='/qnaList';">글목록</button>
<table border="1">
	<tr><td>제목</td><td>${detail.board_title }</td></tr>
	<tr><td>작성자</td><td>${detail.board_writer }</td></tr>
	<tr><td>내용</td><td>${detail.board_content }</td></tr>
	<tr><td>등록일</td><td><fmt:formatDate value="${detail.board_date }" pattern="MM.dd"/> </td></tr>
</table>
</body>
</html>  