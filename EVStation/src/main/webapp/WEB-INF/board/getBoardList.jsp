<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>목록보기</title>

<style>

table {width: 700px;border-collapse: collapse;}
#page{text-align: center;}	

</style>
</head>
<body>
	<h1>게시글 목록</h1>
	<!--<a href="insertBoard">새글 등록</a>  -->
	<table border="1">
	<tr><th>No.</th><th>제목</th><th>작성자</th><th>작성일</th><th>조회수</th><th>추천수</th></tr>
	<c:forEach items="${blist}" var="board">
		<tr><td>${board.num}</td>
			<td><a href="/content/${board.num}">${board.title}</a></td>
			<td>${board.writer}</td>
			<td><fmt:formatDate value="${board.createDate}" pattern="MM.dd"/> </td>
			<td>${board.cnt}</td>
			<td>${board.recom}</td>
		</tr>	
	</c:forEach>
</table>

<div id="page">
	<c:if test="${search == null }">
		<c:if test="${begin > 2 }">
			<a href="/getBoardList?p=${begin-1}">[이전]</a>
		</c:if>
		<c:forEach begin="${begin }" end="${end}" var="i">
			<a href="/getBoardList?p=${i}">[${i}]</a>
		</c:forEach>
		<c:if test="${end < totalPage }">
			<a href="/getBoardList?p=${end+1}">[다음]</a>
		</c:if>
	</c:if>
	<c:if test="${search != null}">
		<c:if test="${begin > 2}">
			<a
				href="/getBoardList?p=${begin-1}&search=${search}&searchn=${searchn}">[이전]</a>
		</c:if>
		<c:forEach begin="${being}" end="${end }" var="i">
			<a href="/getBoardList?p=${i}&search=${search}&searchn=${searchn}">[${i}]</a>
		</c:forEach>
		<c:if test="${end < totalPage }">
			<a
				href="/getBoardList?p=${end+1}&search=${search}&searchn=${searchn}">[다음]</a>
		</c:if>
	</c:if>

	<c:if test="${total == 0}">
	검색 결과가 없습니다.
</c:if>
	<form>
		<select name="searchn">
			<option value="0">제목</option>
			<option value="1">내용</option>
		</select> <input type="text" name="search" size="15" maxlength="50" /> <input
			type="submit" value="검색" />
	</form>
</div>	
</body>
</html>