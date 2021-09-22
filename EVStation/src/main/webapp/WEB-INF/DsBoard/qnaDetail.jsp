<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="DsLayout/dsHeaderQnA.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 상세보기</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
#center {
	width: 800px;
	margin-left: auto;
	margin-right: auto;
}

#page {
	text-align: center;
}
</style>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
</head>
<body>

	<!-- 	<div class="container">  -->


	<div id="center">
		<table class="table table-borderless border">
			<tr>
				<td><a href="/qnaList"><small style="color: green">QnA게시판 ></small></a></td>
			</tr>
			<tr>
				<td><h2>${detail.boardtitle}</h2></td>
			</tr>
			<tr><td colspan="2"><img src="${detail.member.memphoto}" width="45" height="30"><strong>${detail.member.id}</strong></td></tr><!--  프로필사진 부분-->
			<tr>
				<td><fmt:formatDate value="${detail.boarddate}"
						pattern="YYYY.MM.dd. hh:mm" /> 조회 ${detail.boardsee}
						<!-- 로그인 안된 상태 , 빈 하트 보이게-->
					<c:if test= "${member.id == null}">
					<img id="h" src="/img/empty.png" width="20px" title="123">
					</c:if>
					
					추천수 <span id="recom_qna">${detail.boardrecom}</span>
					<c:if test= "${member.id != null}">
						<c:if test="${result == 0}">
							<img id="h" src="/img/empty.png" width="20px">
						</c:if>
						<c:if test="${result != 0}">
							<img id="h" src="/img/full.png" width="20px">
						</c:if>
					</c:if>	
						
						</td>
				<td align="right"><c:if
						test="${detail.boardwriter eq member.getId() or member.getId() == 'admin' }">
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
				<button type="button" class="btn btn-primary"
					onclick="location.href='/qnaReplyForm/${detail.boardnum}/${detail.boardref}/${detail.boardrestep}/${detail.boardrelevel }';">답글달기</button>
			</c:if>
		</div>
		<img src="${detail.member.memphoto}" width="45" height="30"> <a
			href="">${detail.member.id}님의 게시글 더보기 ></a>





		<!-- 댓글  -->
		<hr style="margin-botton: 10px;">
		<textarea style="width: 100%;" rows="3" cols="30" name="comment"
			id="comment" placeholder="댓글을 입력하세요"></textarea>
		<div class="mb-2" style="text-align: right;">
			<button id="comment_button" class="btn btn-sm btn-success">등록</button>
		</div>


		<div id="commentAll">
			<h3>
				댓글 <span id="Cnt">${total}</span>
			</h3>
			<div id="con">
				<c:forEach items="${coList}" var="coList">
					<div class="cocomen" style="margin-bottom: 5px;">${coList.comcontent}</div>
					<div id="${replycomment.comnum}" class="my-3"
						style='position: relative; left: 20px;'>
						<a id="commentUp${coList.comnum}" href="#commentUp"
							onclick="commentUp(${coList.comnum})">수정</a> <a
							id="commentDel(${coList.comnum})" href="#commentDel"
							onclick="commentUp(${coList.comnum})">삭제</a>
					</div>
					<hr>
				</c:forEach>
				</div>
			</div>
		<!-- commentAll -->
		<div id="page">
			<c:if test="${begin > 2}">
				<a href="/qnaDetail/${detail.boardnum}?p=${begin-1}">[이전]</a>
			</c:if>
			<c:forEach begin="${begin}" end="${end}" var="i">
				<a href="/qnaDetail/${detail.boardnum}?p=${i}">[${i}]</a>
			</c:forEach>
			<c:if test="${end < totalPage}">
				<a href="/qnaDetail/${detail.boardnum}?p=${end+1}">[다음]</a>
			</c:if>
		</div>
		<!-- id: page -->

	</div>
	<!-- id: center -->

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



