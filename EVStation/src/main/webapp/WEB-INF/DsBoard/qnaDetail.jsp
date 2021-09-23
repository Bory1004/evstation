<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="DsLayout/dsHeaderQnA.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 상세보기</title>
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

<div class="container input-group d-flex justify-content-center">

	<div id="center">
		<table class="table table-borderless border">
			<tr>
				<td><a href="/qnaList"><small style="color: green">QnA게시판 ></small></a></td>
			</tr>
			<tr>
				<td><h2>${detail.boardtitle}</h2></td>
			</tr>
			<tr>
				<td colspan="2"><img src="${detail.member.memphoto}" width="45" height="30"><strong>${detail.member.id}</strong></td>
			</tr>
			<!--  프로필사진 부분-->
			<tr>
				<td><fmt:formatDate value="${detail.boarddate}" pattern="YYYY.MM.dd. hh:mm" /> 조회 ${detail.boardsee} <!-- 로그인 안된 상태 , 빈 하트 보이게--> <c:if test="${member.id == null}">
						<img id="h" src="/img/empty.png" width="20px" title="123">
					</c:if> 추천수 <span id="recom_qna">${detail.boardrecom}</span> <c:if test="${member.id != null}">
						<c:if test="${result == 0}">
							<img id="h" src="/img/empty.png" width="20px">
						</c:if>
						<c:if test="${result != 0}">
							<img id="h" src="/img/full.png" width="20px">
						</c:if>
					</c:if></td>
				<td align="right"><c:if test="${detail.boardwriter eq member.getId() or member.getId() == 'admin' }">
						<!--  같은 아이디만 수정 삭제 가능 -->
						<a href="/updateQnAform/${detail.boardnum}/${detail.boardmemnum}/${detail.boardrecom}/${detail.boardrelevel}/${detail.boardrestep}/${detail.boardref}">수정</a>
						<a href="/deleteQnA/${detail.boardnum}/${detail.boardref}">삭제</a>
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
		<img src="${detail.member.memphoto}" width="45" height="30"> <a href="">${detail.member.id}님의 게시글 더보기 ></a>





		<!-- 댓글  -->
		<hr style="margin-botton: 10px;">
		<textarea style="width: 100%;" rows="3" cols="30" name="comment" id="comment" placeholder="댓글을 입력하세요"></textarea>
		<div class="mb-2" style="text-align: right;">
			<button id="comment_button" class="btn btn-sm btn-success">등록</button>
		</div>

		<div id="commentlist">
			<h3>
				댓글 <span id="cCnt">${Cnt}</span>
			</h3>
			<hr>
				<c:forEach items="${comments}" var="comment">
					<div id="${comment.comnum}">
						<div class="my-2">
							<strong><span><img src="${comment.member.memphoto}" width="45" height="30"> ${comment.member.name}(${comment.member.id})</span></strong> 
							<span> 
							<a id="comment_reply${comment.comnum}" href="#replyComment" onclick="replyCommentForm(${comment.comnum},${comment.comgroupnum})">답글</a> 
							<c:if test="${comment.commemnum == member.memnum }">
									<a id="comment_update${comment.comnum}" href="#updateQnACommentForm" onClick="updateQnACommentForm(${comment.comnum},${comment.comgroupnum})">수정</a>
									<a id="comment_delete${comment.comnum}" href="#deleteQnAcomment" onclick="deleteQnAComment(${comment.comnum},${comment.comgroupnum})">삭제</a>
								</c:if>
							</span>
						</div>
							<div id="comcontent${comment.comnum}" style="margin-bottom: 5px;">${comment.comcontent}<br>
							<fmt:formatDate value="${comment.comdate}" pattern="yy.MM.dd HH:mm" />
							</div>
						<hr>
						<!-- 대댓글부분 -->
							<c:forEach items="${replycomments}" var="replycomment">
						<c:if test="${replycomment.comgroupnum == comment.comgroupnum }">
						<div id="${replycomment.comnum}" class="my-3"
									style='position: relative; left: 20px;'>
						<p class='my-2'>
						<strong><span><img src="${replycomment.member.memphoto}" width="45" height="30">
												${replycomment.member.name}(${replycomment.member.id})
										</span> </strong>
										<span><a
											id="replycomment_reply${replycomment.comnum}"
											href="#replyComment"
											onclick="replyCommentForm(${replycomment.comnum},${replycomment.comgroupnum})">답글</a>
											<c:if test="${replycomment.commemnum == member.memnum }">
												<a id="replycomment_update${replycomment.comnum}"
													href="#updateCommentForm"
													onClick="updateCommentForm(${replycomment.comnum})">수정</a>
												<a id="replycomment_delete${replycomment.comnum}"
													href="#delete"
													onclick="deleteComment(${replycomment.comnum},${replycomment.comgroupnum})">삭제</a>
											</c:if> </span>
						</p>
						<div>
								<span id="comcontent${replycomment.comnum}">${replycomment.comcontent}</span><br>
								<fmt:formatDate value="${comment.comdate}" pattern="yy.MM.dd HH:mm" />
								</div><hr>
						</div>
						</c:if>
					</c:forEach>
					<!-- 대댓글 끝 -->
					</div>
				</c:forEach>
		</div><!-- commentlist -->
			
			<div class="col-md-12 d-flex justify-content-end"> 
			<c:if test="${member.memnum== detail.boardmemnum}">
				<span><a class="btn btn-md btn-outline-success"
					href="/#/${detail.boardnum}" style="margin: 5px">삭제</a></span>
			</c:if>
			<span><a class="btn btn-md btn-outline-success"
				href="/qnaList"
				style="margin: 5px">목록</a></span> <span><a
				class="btn btn-md btn-outline-success" href="#"
				onClick="javascript:window.scrollTo(0,0)" style="margin: 5px">TOP</a></span>
			</div>
		

	</div>
	<!-- id: center -->
</div>
	<%@ include file="DsLayout/dsFooter.jsp"%>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
	$(function() {
		$('#comment_button').click(function() { //댓글 생성 및 ajax
			let comcontent = $('#comment').val(); //id가 comment인 textarea 안에 있는 값을 정의
			//let boardnum = '${detail.boardnum}' // 댓글을 작성한 글의 넘버(pk)

			if (!comcontent) {
				alert("댓글을 입력하세요!")
				$("#comment").focus();
				return false;
			}
			$.ajax({
				url : "/insertQnAComment/${detail.boardnum}",
				data : "comcontent=" + comcontent,
				dataType : "json",
			}).done(function(data) {
				console.log(data)
				alert(data)
				$('#con').prepend("<div class='cocomen' style='margin-bottom: 5px;''>"+ data.comcontent+"</div><hr>");
						
				  
				                                
				$('#comment').val('');
			}); //ajax
		}); //#comment_button
	
		/* $(function(){
			$("#commen_del").click(function(){
				
			}
		}) */
		
		
	});
		
	//추천 부분	
	$(function() {
	$("#h").click(function() {
		let num = ${detail.boardnum};
		let id = "${member.id}";
        console.log(id);
		let url = "/updateQnaRecom/" + num + "/" + id;
				$.ajax({
					url : url
				})	
				.done(
					function(data) {
					if (document.getElementById("h").getAttribute('src') == '/img/empty.png') {
						document.getElementById("h").src = "/img/full.png";
							} else {
							document.getElementById("h").src = "/img/empty.png";//.src는 속성값 변경
						}
						$("#recom_qna").html(data);//매개변수가 있으니까 변경된 값 가져옴
						}).fail(
							function(jqXHR, textStatus,errorThrown) {
							console.log("error");
					}); 
				
		})


})
</script>
</html>



