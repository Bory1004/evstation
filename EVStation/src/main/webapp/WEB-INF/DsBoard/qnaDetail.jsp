<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="DsLayout/dsHeaderQnA.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
#center {
	width: 800px;
	margin-left: auto;
	margin-right: auto;
}
</style>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
</head>
<body>

	<!-- 	<div class="container">  -->



	<div id="center">
		<table class="table table-borderless border">
			<tr>
				<td><a href="/qnaList"><small style="color: green">자유 게시판 ></small></a></td>
			</tr>
			<tr>
				<td><h2>${detail.boardtitle}</h2></td>
			</tr>
			<!--  	<tr><td colspan="2"><img src="${board.member.memphoto}" width="45" height="30"><strong>${board.member.id}</strong></td></tr> 프로필사진 부분-->
			<tr>
				<td><fmt:formatDate value="${detail.boarddate}" pattern="YYYY.MM.dd. hh:mm" /> 조회 ${detail.boardsee}</td>
				<td align="right"><c:if test="${detail.boardwriter eq member.getId() or member.getId() == 'admin' }">
						<!--  같은 아이디만 수정 삭제 가능 -->
						<a href="/updateQnAform/${detail.boardnum}">수정</a>
						<a href="/deleteQnA/${detail.boardnum}">삭제</a>
					</c:if></td>
			</tr>
			<tr>
				<td colspan="2"><hr align="center"></td>
			</tr>
			<tr>
				<td colspan="2">${detail.boardcontent}</td>
			</tr>
		</table>
		<br>
		<div align="right">
			<c:if test="${member.getId() == 'admin'}">
				<!--  관리자 id : admin  .. 관리자만이 답변 달수 있도록 -->
				<button type="button" class="btn btn-primary" onclick="location.href='/qnaReplyForm/${detail.boardnum}/${detail.boardref}/${detail.boardrestep}/${detail.boardrelevel }';">답글달기</button>
			</c:if>
		</div>
		<img src="${review.member.memphoto}" width="45" height="30"> <a href="">${review.member.id}님의 게시글 더보기 ></a>


		<hr style="margin-botton: 10px;">
		<textarea style="width: 100%;" rows="3" cols="30" id="comment" placeholder="댓글을 입력하세요"></textarea>
		<div class="mb-2" style="text-align: right;">
			<button id="comment_button" class="btn btn-sm btn-success">등록</button>
		</div>
		<div id="commentlist">
		
				<h3>댓글 <span id="cCnt">${Cnt}</span></h3>
		</div>
		<!-- 	<div class="card">
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
		<!-- 					<div class="font-italic">작성자:I could not set reply &nbsp;</div>
						<button class="badge badge-dark">삭제</button>
					</div>
				</li>
			</ul>
		</div>
	</div> -->

		<%@ include file="DsLayout/dsFooter.jsp"%>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		/* $(document).on('click','#comment2',function(){
			alert("Test")
		}); */
		$(function() {
			$('#comment_button').click(function() { //댓글 생성 및 ajax
				let comcontent = $('#comment').val()   //id가 comment인 textarea 안에 있는 값을 정의
				//let comcontent2 = $('#comment').html()
				let boardnum = '${review.boardnum}'
				//alert(${review.boardnum});
				//alert(comcontent)
				//alert(boardnum)
				let commemnum = '${member.memnum}'
				let number = $('#cCnt').html();
				
				if (comcontent == "") {
					alert("댓글을 입력하세요!")
					return false;
				}
				;

				$.ajax({
					type : "get",
					url : "insertCommentReview",
					data : {
						"boardnum" : boardnum,
						"comcontent" : comcontent,
						"commemnum" : commemnum
					},
					dataType : "json"
				}).done(function(data) {
					//alert(data.comdate)
					$('#comment').val('');
					//$('#comment').empty(); -> textarea는 태그안이 아니라 value값에 저장되서 안지워지는거 같다.
					//alert($('#comment').val())
					let date = new Date(data.comdate);
					$("#commentlist").append(
						"<div id='"+data.comnum+"'><div class='mb-2'><strong><img src='"+data.member.memphoto+"' width='45' height='30'>"+data.member.name+"("+data.member.id+")</strong><span>"
							+" <a id='comment_reply"+data.comnum+"' href='#replyComment' onclick='replyCommentForm("+data.comnum+","+data.comgroupnum+")'>답글</a> "
							+"<a id='comment_update"+data.comnum+"' href='#updateCommentForm' onclick='updateCommentForm("+data.comnum+")'>수정</a> "
							+"<a id='comment_delete"+data.comnum+"' href='#delete' onclick='deleteComment("+data.comnum+","+data.comgroupnum+")'>삭제</a></span></div><span id='comcontent"+data.comnum+"'>"+data.comcontent+"</span><br>"+(date.getMonth()+1)+"."+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+"<hr></div>"
					);
					let cnt = parseInt(number)+1
					$('#cCnt').html(cnt);
				}).fail(function(e) {
					alert(e.responseText);
				})
			});
			</script>
</body>
</html>



