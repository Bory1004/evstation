<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>리뷰 상세보기</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
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

a {
	text-decoration-line: none;
}

textarea {
	width:100%;
}

#alarmpage {
	position :absolute;
	border: solid black 1px;
	width : 210px;
	height : 300px;
	left : 1230px;
	overflow-y : auto;
}
</style>
</head>
<body>
${member}
	<div class="container">
		<header class="py-3">
			<div class="row justify-content-center">
				<div class="col-6 pt-2">
					<a href="/main" class="link-secondary"> 
					<img src="/img/logo.png" width="220" height="100"></a>
					<!--  <a class="link-secondary" href="#">Subscribe</a> -->
				</div>

				<div class="col-6 d-flex-column-reverse justify-content-end align-items-center">
					<!-- justify-content 자식요소 정렬  -->
					<div id="login" style="text-align:right;margin-bottom:10px;"><img style="cursor:pointer;"src="/img/alarm1.png"
						width="30" height="30" onclick="ring(${member.memnum})">
					</div>						
					<c:choose>
						<c:when test="${member.id eq null}">
							<div style="float:right;">
								<a class="btn btn-sm btn-outline-success" href="/loginView">로그인</a> 
								<a class="btn btn-sm btn-outline-success" href="/joinView">회원가입</a>
							</div>	
						</c:when>
						<c:otherwise>
							<div style="float:right;">${member.id}님 환영합니다!! <a class="btn btn-sm btn-outline-success" href="/logout">로그아웃</a></div>
						</c:otherwise>						
					</c:choose>
				</div>
			</div>

			<div class="menubar py-1 mb-2">
				<nav class="nav d-flex justify-content-center border-top border-bottom">
					<a class="p-2  link-success" href="#">페이지 소개</a> 
					<a class="p-2 link-success" href="/reviewList">충전소 현황</a> 
					<a class="p-2 link-success" href="#">기대효과</a> 
					<a class="p-2 link-success" href="/getBoardList">자유게시판</a> 
					<a class="p-2 link-success" href="#">공지사항</a> 
					<a class="p-2 link-success" href="#">Q&A</a>
				</nav>
			</div>
		</header>
	</div>


	<main>
		<div class="container input-group d-flex justify-content-center">


			<h1>${review.boardtitle }</h1>
			<div class="w-100 row">
				<div class="col-xs-12 col-md-12 mb-2" style="text-align: right;">추천수
					${review.boardrecom } 조회수 ${review.boardsee}</div>
				<div class="col-xs-12 col-md-12">
					<div class="table table-responsive">
						<table class="table" style="text-align: center">
							<tr>
								<th class="table-success">글번호</th>
								<td id="boardnum">${review.boardnum}</td>
								<th class="table-success">(프로필사진)작성자</th>
								<td>${review.member.name }</td>
							</tr>
							<tr>
								<th class="table-success">ID</th>
								<td>${review.member.id}</td>
								<th class="table-success">작성일</th>
								<td><fmt:formatDate value="${review.boarddate}"
										pattern="MM.dd HH:mm" /></td>
							</tr>
							<tr>
								<th class="table-success" colspan="1">내용</th>
								<td colspan="3"><!-- <textarea rows="10" style="border: none;"> --><%-- ${review.boardcontent} --%>
									<c:forEach items="${reviewFiles}" var="image"> 
									<p><img src="${image.filepath}"></p> <br>
										</c:forEach>${review.boardcontent}
									<!-- </textarea> --></td>
							</tr>
						</table>
					</div>

					(프로필사진) <a href="">${review.member.id}님의 게시글 더보기 ></a>
					<hr>
					<span><strong>Comments</strong></span><span id="cCnt">${cCnt}</span>
					<hr style="margin-botton: 10px;">
					<textarea style="width: 100%;" rows="3" cols="30" id="comment"
						placeholder="댓글을 입력하세요"></textarea>
					<div class="mb-2" style="text-align: right;">
						<button id="comment_button" class="btn btn-sm btn-success">등록</button>
					</div>
					<div id="commentlist">
						<hr>
						<c:forEach items="${comments}" var="comment">
						<div id="${comment.comnum}"><div class="mb-2"><strong><span>사진<%-- ${comment.member.memphoto} --%> ${comment.member.name}(${comment.member.id}) <fmt:formatDate
									value="${comment.comdate}" pattern="MM.dd HH:mm" /></span></strong> <span style="float:right;"><a id="comment_reply${comment.comnum}" href="#replyComment" onclick="replyCommentForm(${comment.comnum},${comment.comgroupnum})">답글</a>
												                        <c:if test="${comment.commemnum == member.memnum }"><a id="comment_update${comment.comnum}" href="#updateCommentForm" onClick="updateCommentForm(${comment.comnum},${comment.comgroupnum})">수정</a> 
																															<a id="comment_delete${comment.comnum}" href="#delete" onclick="deleteComment(${comment.comnum},${comment.comgroupnum})">삭제</a></c:if></span></div>
						<div id="comcontent${comment.comnum}" style="margin-bottom:5px;">${comment.comcontent}<br></div><hr>
							<!-- 대댓글부분 -->
							<c:forEach items="${replycomments}" var="replycomment">
							<c:if test="${replycomment.comgroupnum == comment.comgroupnum }">
							<div id="${replycomment.comnum}" class="my-3" style='position:relative;left:10px;'><p class='my-2'><strong><span>사진<%-- ${replycomment.member.memphoto} --%> ${replycomment.member.name}(${replycomment.member.id})</span> <fmt:formatDate
									value="${replycomment.comdate}" pattern="MM.dd HH:mm" /></strong><span style="float:right;"><a id="replycomment_reply${replycomment.comnum}" href="#replyComment" onclick="replyCommentForm(${replycomment.comnum},${replycomment.comgroupnum})">답글</a>
										  			       <c:if test="${replycomment.commemnum == member.memnum }"><a id="replycomment_update${replycomment.comnum}" href="#updateCommentForm" onClick="updateCommentForm(${replycomment.comnum})">수정</a> 
																													<a id="replycomment_delete${replycomment.comnum}" href="#delete" onclick="deleteComment(${replycomment.comnum},${replycomment.comgroupnum})">삭제</a></c:if>
																						</span></p>
							<div><span id="comcontent${replycomment.comnum}">${replycomment.comcontent}</span></div></div>
							</c:if>
							</c:forEach>
							<!-- 대댓글 끝  -->
							
						</div>
						</c:forEach>
					</div>

				</div>
				<div class="col-md-12 d-flex justify-content-end">
				<c:if test="${member.memnum== review.boardmemnum}">	<span><a class="btn btn-md btn-outline-success"
						href="/deleteReview/${review.boardnum}"
						style="margin: 5px">삭제</a></span></c:if>
					<span><a class="btn btn-md btn-outline-success"
						href="../../reviewList?p=${pNum}&search=${search}&searchn=${searchn}"
						style="margin: 5px">목록</a></span> 
					<span><a class="btn btn-md btn-outline-success" href="#" onClick="javascript:window.scrollTo(0,0)"
						style="margin: 5px">TOP</a></span>
				</div>
			</div>
		</div>
	</main>





	<footer
		class="container-fluid my-3 d-flex justify-content-center align-items-center border-top"
		style="height: 100px;">

		<div class="row">
			<div class="col-12 pt-3">
				<p>
					Project built for <a href="#">Portfolio</a> by <a href="#">Team
						2</a>.
				</p>
				<p>Copyright @ 2021 EvStation</p>
			</div>
		</div>
	</footer>
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