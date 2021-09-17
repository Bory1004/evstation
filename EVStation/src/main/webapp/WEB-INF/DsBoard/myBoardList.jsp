<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="DsLayout/dsHeaderBenefit.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 글</title>
<style>
#center {
	width: 600px;
	margin-left: auto;
	margin-right: auto;
}
#page {
	text-align: center;
}
</style>
</head>
<body>
	<div class="py-4 mb-4 ml-4" style="margin: 100 auto" align="center">
		<div class="btn-group btn-group-justified btn-group-lg" role="group" align="right">
			<button type="button" class="btn btn-secondary">&nbsp;&nbsp;&nbsp;전체글&nbsp;&nbsp;&nbsp;</button>
			<button type="button" class="btn btn-secondary">&nbsp;&nbsp;&nbsp;리뷰&nbsp;&nbsp;&nbsp;</button>
			<button type="button" class="btn btn-outline-secondary">&nbsp;&nbsp;&nbsp;Q&A&nbsp;&nbsp;&nbsp;</button>
			<button type="button" class="btn btn-secondary ">&nbsp;&nbsp;&nbsp;자유게시판&nbsp;&nbsp;&nbsp;</button>
		</div>
	</div>
	<div id="center">

		<table style="text-align: center" class="table table-hover caption-top">
			<thead class="table-light">
				<tr>
					<c:if test="${member.getId() == 'admin'}">
						<!-- 관리자만 보이게 -->
						<th><input type="checkbox" name="ChkBxAll" id="ChkBxAll;"></th>
					</c:if>
					<th scope="col"><b>No.</b></th>
					<th scope="col"><b>제목</b></th>
					<th scope="col"><b>작성자</b></th>
					<th scope="col"><b>작성일</b></th>
					<th scope="col"><b>조회수</b></th>
					<th scope="col"><b>추천수</b></th>

					<c:if test="${member.getId() == 'admin'}">
						<!-- 관리자만 보이게 -->
						<th><b>답변여부</b></th>
					</c:if>
				</tr>
			</thead>
			
			<c:forEach items="${list}" var="list">
					<tr>
	<!--<c:if test="${member.getId() == list.boardwriter}"> <!--  내가 쓴 글만 보여주도록 if문 --> 
						<c:if test="${member.getId() == 'admin'}">
							<td><input type="checkbox" name="ChkBxRow" value="${list.boardnum}" alt="${list.boardref}"></td>
						</c:if>

						<td>${list.boardnum}</td>

						<td><a href="qnaDetail/${list.boardnum}"> <c:if test="${list.boardrelevel == 1 }">[답변]</c:if> <c:if test="${list.boardrelevel > 1 }">&nbsp; [답변]
						<c:forEach begin="2" end="${list.boardrelevel}">
								Re:
						</c:forEach>
								</c:if> ${list.boardtitle}
						</a></td>

						<td>${list.boardwriter}</td>
						<td><fmt:formatDate value="${list.boarddate}" pattern="MM.dd" /></td>
						<td>${list.boardsee}</td>
						<td>${list.boardrecom}</td>

						<c:if test="${member.getId() == 'admin'}">
							<!-- 관리자만 보이게 -->
							<td>${list.boardyn}</td>
						</c:if>
<!-- </c:if> 내가 쓴 글 if문 끝 -->
					</tr>
				</c:forEach>

		</table>
			<div id="page">
					<c:if test="${begin > 2 }">
						<a href="/myBoardList?p=${begin-1}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin }" end="${end}" var="i">
						<a href="/myBoardList?p=${i}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage }">
						<a href="/myBoardList?p=${end+1}">[다음]</a>
					</c:if>
			</div>
				
			

</div>

		<div class="container body">
			<div class="btn-group-vertical btn-group-lg" role="group" aria-label="Basic example" style="width: 17%;">
				<button type="button" class="btn btn-secondary">개인정보수정</button>
				<br>
				<button type="button" class="btn btn-secondary">내가 쓴 글</button>
				<br>
				<button type="button" class="btn btn-secondary">즐겨찾기</button>
				<br>
				<button type="button" class="btn btn-secondary">회원탈퇴</button>
				<br>
			</div>
		</div>
		



		<%@ include file="DsLayout/dsFooter.jsp"%>
</body>
</html>