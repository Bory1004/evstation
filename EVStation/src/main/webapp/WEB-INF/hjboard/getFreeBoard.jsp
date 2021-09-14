<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>자유 게시판</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<style>
@media ( min-width : 768px) {
	.container {
		width: 750px
	}
}
@media ( min-width : 992px) {
	.container {
		width: 940px
	}
}
#center {
	width: 800px;
	margin-left: auto;
	margin-right: auto;
}
a {
	text-decoration-line: none;
}
#page {
	text-align: center;
}
</style>
</head>
<body>
	<div class="container">
		<header class="py-3">
			<div class="row justify-content-center">
				<div class="col-6 pt-2">
					<a href="/main" class="link-secondary"> 
					<img src="/img/logo.png" width="220" height="100"></a>
					<!--  <a class="link-secondary" href="#">Subscribe</a> -->
				</div>

				<div class="col-6 d-flex justify-content-end align-items-center">
					<!-- justify-content 자식요소 정렬  -->
													
					<c:choose>
						<c:when test="${member.id eq null}">
							<div>
								<a class="btn btn-sm btn-outline-success" href="/loginView">로그인</a> 
								<a class="btn btn-sm btn-outline-success" href="/joinView">회원가입</a>
							</div>	
						</c:when>
						<c:otherwise>
							${member.id}님 환영합니다!! <a class="btn btn-sm btn-outline-success" href="/logout">로그아웃</a>
						</c:otherwise>						
					</c:choose>
				</div>
			</div>

			<div class="menubar py-1 mb-2">
				<nav class="nav d-flex justify-content-center border-top border-bottom">
					<a class="p-2  link-success" href="#">페이지 소개</a> 
					<a class="p-2 link-success" href="/reviewList">충전소 현황</a> 
					<a class="p-2 link-success" href="#">기대효과</a> 
					<a class="p-2 bg-success text-white" href="/getFreeBoardList">자유게시판</a> 
					<a class="p-2 link-success" href="#">공지사항</a> 
					<a class="p-2 link-success" href="#">Q&A</a>
				</nav>
			</div>
		</header>
	</div>
	
	<main>
		<div id="center">
			<table class="table table-borderless border">
				<tr><td><a href="/getFreeBoardList"><small style="color: green">자유 게시판 ></small></a></td></tr>
				<tr><td><h2>${board.boardtitle}</h2></td></tr>
				<tr><td colspan="2"><img src="${board.member.memphoto}" width="45" height="30"><strong>${board.member.id}</strong></td></tr>
				<tr><td><fmt:formatDate value="${board.boarddate}" pattern="YYYY.MM.dd. hh:mm"/> 조회 ${board.boardsee}</td>
					<td align="right"><c:if test="${board.member.id eq member.id}">
							<a href="/updateFreeBoard/${board.boardnum}">수정</a>	
							<a href="/deleteFreeBoard/${board.boardnum}">삭제</a>
						</c:if>
					</td></tr>
				<tr><td colspan="2"><hr align="center"></td></tr>
				<tr><td colspan="2">${board.boardcontent}</td></tr>
			</table><br>

			<!-- 댓글 -->	
			<div id="comment_out">							
				<h3>댓글 ${total}</h3>				
					<c:forEach items="${clist}" var="comment">
						<img src="${comment.member.memphoto}" width="45" height="30"><strong><c:out value="${member.id}"/></strong>
						<span style="align-content: right">
							<c:if test="${comment.commennum eq member.memnum}">												
								<a href="" onclick="modify_comment('<c:out value="${comment.comnum}"/>'); return false;">수정</a>
								<a href="" onclick="delete_comment('<c:out value="${comment.comnum}"/>')">삭제</a>
							</c:if>
						</span>					
						<div id="reply<c:out value="${comment.comnum}"/>"><c:out value="${comment.comcontent}" /></div>						
						<small><fmt:formatDate value="${comment.comdate}" pattern="YY.MM.dd HH:mm" /></small>
						<div id="replyDiv<c:out value="${comment.comnum}"/>" style="display: none">
							<form id="form1"><!--  action="/updateComment" method="post"-->	
								<input type="hidden" name="comnum" value="<c:out value="${comment.comnum}"/>">
								<input type="hidden" name="commennum" value="<c:out value="${comment.commennum}"/>">
								<input type="hidden" name="boardnum" value="<c:out value="${comment.boardnum}"/>">
								<textarea name="comcontent" rows="3" cols="40" maxlength="500">${comment.comcontent}</textarea>
								<input id="update_comment" type="submit">
        					</form>
						</div>
						<hr width="800">
				</c:forEach>
						
			<div id="page">
				<c:if test="${begin > 2}">
					<a href="/content/${board.boardnum}?p=${begin-1}">[이전]</a>
				</c:if>
				<c:forEach begin="${begin}" end="${end}" var="i">
					<a href="/content/${board.boardnum}?p=${i}">[${i}]</a>
				</c:forEach>
				<c:if test="${end < totalPage}">
					<a href="/content/${board.boardnum}?p=${end+1}">[다음]</a>
				</c:if>
			</div>				
		</div>	
		<br>
		<textarea id="comment_in" name="comment_in" rows="3" cols="40" maxlength="500" placeholder="댓글을 달아주세요."></textarea> 
		<input type="button" id="bnt_c" value="등록">
		</div>
	</main>
</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	
	$(function() {
		$("#bnt_c").click(function() {
			let content = $("#comment_in").val();
			if (!content) {
				alert('댓글을 입력하세요.')
				$("#comment_in").focus();
				return false;
			}
			$.ajax({
				url : "/insertComment/${board.boardnum}",
				data : "content=" + content,
				dataType : "text"
			}).done(function() {
				$("#comment_out").load(location.href + " #comment_out");
				$("#comment_in").val("");
			}); //ajax
		}); //bnt_c

		/* $("#bnt_comment_delete").click(function(cno) {
			if (confirm("댓글을 삭제하시겠습니까?") == false) {
				return false;
			} else{
			$.ajax({
				url : "/deleteComment",
				data : "cno="+cno,
				dataType : "json"
			}).done(function() {
				$("#comment_out").load(location.href + " #comment_out");
			}); //ajax
			}
		}); //bnt_comment_delete */

		$("#update_comment").click(function() {
			let form1 = $("#form1").serialize();
			$.ajax({
				type : "post",
				url : "/updateComment",
				data : form1,
				dataType : "json"
			}).done(function() {
				$("#comment_out").load(location.href + " #comment_out");
			}); //ajax
		}); //update_comment
	});

	function delete_comment(comnum) {
		if (!confirm("댓글을 삭제하시겠습니까?")) {
			return;
		}
		$.ajax({
			url : "/deleteComment",
			data : "comnum=" + comnum,
			dataType : "json"
		}).done(function() {
			$("#comment_out").load(location.href + " #comment_out");
		}); //ajax
	} //delete_comment

	function modify_comment(comnum) {
		let reply = document.getElementById("reply" + comnum);
		let replyDiv = document.getElementById("replyDiv" + comnum);
		replyDiv.style.display = "";
		reply.style.display = "none";
	} //modify_comment

	function fn_replyUpdateSave() {
		let replyDiv = document.getElementById("replyDiv" + comnum);
		let r = replyDiv.rememo.value;

		alert(r);
		let content = $("#rememo").val();
		/*  if (!content) {
		     alert("글 내용을 입력해주세요.");
		     $("#rememo").focus();
		     return false;
		 } */
		$.ajax({
			url : "/modifyComment",
			data : "content=" + content,
			dataType : "json"
		}).done(function() {
			alert("수정완료")
			$("#comment_out").load(location.href + " #comment_out");
		});
	}

	function fn_replyUpdateCancel() {
		let replyDiv = document.getElementById("replyDiv" + comnum);
		document.body.appendChild(replyDiv);
		replyDiv.style.display = "none";
	}
</script>
</html>