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
					<a class="p-2 bg-success text-white" href="/reviewList">충전소 현황</a> 
					<a class="p-2 link-success" href="#">기대효과</a> 
					<a class="p-2 link-success" href="/getFreeBoardList">자유게시판</a> 
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
				<tr><td><h2>${review.boardtitle}</h2></td></tr>
				<tr><td colspan="2"><img src="${review.member.memphoto}" width="45" height="30"><strong>${review.member.id}</strong></td></tr>
				<tr><td><fmt:formatDate value="${review.boarddate}" pattern="YYYY.MM.dd. hh:mm"/> 조회 ${review.boardsee}</td>
					<td align="right"><c:if test="${review.member.id eq member.id}">
							<a href="/updateFreeBoard/${review.boardnum}">수정</a>	
							<a href="/deleteFreeBoard/${review.boardnum}">삭제</a>
						</c:if>
					</td></tr>
				<tr><td colspan="2"><hr align="center"></td></tr>
				<tr><td colspan="2">${review.boardcontent}</td></tr>
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
		/* $(document).on('click','#comment2',function(){
			alert("Test")
		}); */
		$(function() {
			$('#comment_button').click(function() { //댓글 생성 및 ajax
				let comcontent = $('#comment').val()
				//let comcontent2 = $('#comment').html()
				let boardnum = $('#boardnum').html()
				//alert(${review.boardnum});
				//alert(comcontent)
				//alert(boardnum)
				let commemnum = '${member.memnum}'
				
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
						"<div id='"+data.comnum+"'><div class='mb-2'><strong> 사진 "+data.member.name+"("+data.member.id+")"+" "+(date.getMonth()+1)+"."+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+"</strong><span style='float:right;'>"
							+"<a id='comment_reply"+data.comnum+"' href='#replyComment' onclick='replyCommentForm("+data.comnum+","+data.comgroupnum+")'>답글</a> "
							+"<a id='comment_update"+data.comnum+"' href='#updateCommentForm' onclick='updateCommentForm("+data.comnum+")'>수정</a> "
							+"<a id='comment_delete"+data.comnum+"' href='#delete' onclick='deleteComment("+data.comnum+","+data.comgroupnum+")'>삭제</a></span></div><span id='comcontent"+data.comnum+"'>"+data.comcontent+"</span><hr></div>"
					);
					
				}).fail(function(e) {
					alert(e.responseText);
				})
			});
		//----------------------------------------------
			$.ajax({
			type : "get",
			url : "/countAlarm",
			data : { "memnum" : ${member.memnum}},
			dataType : "text"
		}).done(function(data){
			//alert(data)
			//$('#'+알람카운트부분).css("",data);
		}).fail(function(e){
			alert("실패")
			alert(e.responseText)				
		})
			
		
		})
		
	//---------------	왜 여기는 안들어가지??
		function deleteComment(x,y){ // 화면에서 댓글삭제 및 DB삭제
				let comnum = x;
				let comgroupnum = y;
				//alert(comnum);
				//$('#'+comnum).remove();
				if(confirm("댓글을 삭제하시겠습니까?")){
					$.ajax({
						type : "get",
						url :  "deleteComment" ,
						data : {"comnum" : comnum ,"comgroupnum" : comgroupnum},
						dataType : "text"
					}).done(function(data){
						//alert(data)
						alert("삭제되었습니다.")
						$('#'+comnum).remove();
					}).fail(function(e){
						alert("삭제중에 오류가 발생했습니다.")
						alert(e.responseText);
					})
				}else{
					return false;
				}
			}
	//----------------------------	
		function updateCommentForm(x){ // 댓글 수정창 생성
			let comnum = x;
			$('#updateComment'+comnum).remove(); //중복생성 방지
			$('#replyComment'+comnum).remove();
			$('#'+comnum).append(
					"<div id='updateComment"+comnum+"' class='mb-5' style='position:relative;left:10px;'>"
					+"<p class='mb-1'><span>프로필사진 "+'${member.name}(${member.id})'+"</span></p>"
					+"<textarea id='newComment"+comnum+"' class='my-3' rows='3' cols='30' placeholder='수정할 내용을 입력하세요'></textarea>"
					+"<div style='text-align:right;'><span><a href='#updateComment' onclick='updateComment("+comnum+")'>완료</a>"
					+" <a href='#cancelUpdate' onclick='updateCommentFormCancel("+comnum+")'>취소</a></span></div></div>"
			);
		}
	//---------------------------------	
		function updateCommentFormCancel(x){ //댓글 수정창에서 취소버튼 클릭시 수정창을 삭제하는 함수
			let comnum = x;
			$('#updateComment'+comnum).remove();
		}
		function replyCommentFormCancel(x){ //댓글 답글창에서 취소버튼 클릭시 답글창을 삭제하는 함수
			let comnum = x;
			$('#replyComment'+comnum).remove();
		}
	//---------------------------------
		function updateComment(x,y){ // 댓글 수정 DB ajax
			let comnum = x;
			let comcontent = $('#newComment'+comnum).val();
			//alert(comnum);
			//alert(comcontent);
			//$('#'+comnum).remove();
			if(comcontent == ""){
				alert("댓글을 입력하세요!!")
				return false;
			}
			
			if(confirm("댓글을 수정하시겠습니까?")){
				$.ajax({
					type : "get",
					url :  "/updateComment" ,
					data : {"comnum" : comnum, "comcontent" : comcontent},
					dataType : "text"
				}).done(function(data){
					//alert(data)
					alert("수정되었습니다.")
					$('#updateComment'+comnum).remove(); //수정창 제거
					$('#comcontent'+comnum).html(comcontent+" (수정됨)")
				}).fail(function(e){
					alert("수정중에 오류가 발생했습니다.")
					alert(e.responseText);
				})
			}else{
				return false;
			}
		}
	//------------------------------------------
		function replyCommentForm(x,y){ // 댓글답장하는 답글창 생성
			let comnum = x;
			let comgroupnum = y;
			//alert(comnum)
			//alert(comgroupnum)
			$('#replyComment'+comnum).remove(); //중복생성 방지 일반댓글의 답장창을 삭제하기 위해 일반댓글의 comnum을 가져옴
			$('#updateComment'+comnum).remove();
			$('#'+comnum).append(
					"<div id='replyComment"+comnum+"' class='mb-5' style='position:relative;left:10px;'>"
					+"<p class='mb-1'><span>프로필사진 "+'${member.name}(${member.id})'+"</span></p>" //
					+"<textarea id='newreplyComment"+comnum+"' class='my-3' rows='3' cols='30' placeholder='답글을 입력하세요'></textarea>"
					+"<div style='text-align:right;'><span><a href='#replyComment' onclick='replyComment("+comnum+","+comgroupnum+")'>완료</a>"
					+" <a href='#cancelUpdate' onclick='replyCommentFormCancel("+comnum+")'>취소</a></span></div></div>"
			);
		}
	//-----------------------------------
		function replyComment(x,y){ //대댓글 DB에 등록하고 프론트에서 추가하는 ajax
			let comnum = x;
			let comgroupnum = y;
			let comcontent = $('#newreplyComment'+comnum).val();
			let boardnum = $('#boardnum').html();
			let commemnum = '${member.memnum}';
			let frommemnum = '${member.memnum}';
			//alert(boardnum)
			//alert(comnum)
			//alert(comgroupnum)
			//alert(comcontent)
			if(comcontent == ""){
				alert("답글을 입력하세요!!")
				return false;
			}
			$.ajax({
				type : "get",
				url : "/replyComment",
				data : {"comgroupnum" : comgroupnum,"comcontent" : comcontent, "boardnum" : boardnum, "commemnum" : commemnum, "frommemnum" : frommemnum},
				dataType : "json"
			}).done(function(data){
				//alert(data)
				let date = new Date(data.comdate);
				$('#replyComment'+comnum).remove();
				$('#'+data.comgroupnum).append( //새로 작성한 답글의 객체를 받아온다.
						"<div id='"+data.comnum+"' class='my-3' style='position:relative;left:10px;'><p class='my-2'><strong><span>사진 ${member.name}(${member.id})"+" "+(date.getMonth()+1)+"."+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+"</span></strong><span style='float:right;'><a id='replycomment_reply"+data.comnum+"' href='#replyComment' onclick='replyCommentForm("+data.comnum+","+data.comgroupnum+")'>답글</a>"
					   +" <a id='replycomment_update"+data.comnum+"' href='#updateCommentForm' onClick='updateCommentForm("+data.comnum+")'>수정</a>"
					   +" <a id='replycomment_delete"+data.comnum+"' href='#delete' onclick='deleteComment("+data.comnum+","+data.comgroupnum+")'>삭제</a>"
					   +"</span></p>"
					   +"<div><span id='comcontent"+data.comnum+"'>"+data.comcontent+"</span></div></div>"
				);
			}).fail(function(e){
				alert("답글 작성중에 오류가 발생했습니다.")
				alert(e.responseText);
			})
		}
	//--------------------------------------------------- 알람부분
		function ring(x){ //알람 창 열고 데이터 가져오는 함수
		//alert(${memnum})
		$.ajax({
			type : "get",
			url : "/getAlarm",
			data : {"memnum" : ${member.memnum}},
			dataType : "text"
		}).done(function(data){
			//alert("성공")
			if($('#alarmpage').html()){
				$('#alarmpage').remove();
			}else{
				$('#login').append("<div id='alarmpage'></div>"	);
				$('#alarmpage').html(data) //alarmpage에 따로만든 jsp파일넣기
			}
		}).fail(function(e){
			alert("실패")
			alert(e.responseText);
		})
	}
	function delAlarm(x){
		let alanum = x;
		$.ajax({
			type : "get",
			url : "/delAlarm",
			data : {"alanum" : alanum},
			dataType : "text"
		}).done(function(data){
			//alert(data)
			$('#'+alanum).remove();
		}).fail(function(e){
			alert("실패")
			alert(e.responseText);
		})
	}
	function checkAlarm(x){
		let alanum = x;
		$.ajax({
			type : "get",
			url : "/checkAlarm",
			data : {"alanum" : alanum},
			dataType : "text"
		}).done(function(data){
			alert(data)
			//$('#'+alanum).children().eq(1).children().eq(0).css("color","red");
		}).fail(function(e){
			alert("실패")
			alert(e.responseText)
		})
	}
	</script>
</body>
</html>