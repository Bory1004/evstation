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
#alarmpage {
   position :absolute;
   border: solid #BDBDBD 1px;
   border-radius: 20px;
   width : 230px;
   height : 300px;
   left : 1200px;
   padding : 10px;
   overflow-y : auto;
}
#alarmcount {
   position : relative;
   width : 30px;
   height : 20px;
   left : 380px;
   top : 10px;   
   border-radius: 10px;
   text-align : center;
   vertical-align : middle;
}
#alarmcount > span {
   position :relative;
   color : white;
   bottom : 3px;
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

            <div class="col-6 d-flex-column-reverse justify-content-end align-items-center">
               <!-- justify-content 자식요소 정렬  -->
                                       
               <c:choose>
                  <c:when test="${member.id eq null}">
                     <div style="float:right;">
                        <a class="btn btn-sm btn-outline-success" href="/loginView">로그인</a> 
                        <a class="btn btn-sm btn-outline-success" href="/joinView">회원가입</a>
                     </div>   
                  </c:when>
                  <c:otherwise>
                     <div id="login" style="text-align:right;margin-bottom:10px;"><div id="alarmcount"></div><img style="cursor:pointer;"src="/img/alarm1.png" width="30" height="30" onclick="ring(${member.memnum})">
                     </div>
						<div style="float: right;">						
							<img id="main_profile" style = "border-radius:70%;" src="${member.memphoto}" width="40px" height="auto">${member.name}(${member.id})님 환영합니다!!							
								<div class="dropdown">
									<a class="btn btn-sm btn-outline-success dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">마이페이지</a>
									<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
										<li><a class="dropdown-item" href="/check_mypage">개인정보 수정</a></li>
										<li><a class="dropdown-item" href="/AllBoardList/${member.memnum}">내가 쓴 글</a></li>
										<li><a class="dropdown-item" href="#">즐겨찾기</a></li>
									</ul>
									<a class="btn btn-sm btn-outline-success" href="/logout">로그아웃</a>
								</div>
							</div>
						</c:otherwise>                  
               </c:choose>
            </div>
         </div>

         <div class="menubar py-1 mb-2">
            <nav class="nav d-flex justify-content-center border-top border-bottom">
               <a class="p-2  link-success" href="/pageIntro">페이지 소개</a> 
               <a class="p-2 link-success" href="/getChargeList">충전소 현황</a> 
               <a class="p-2 link-success" href="/benefit">기대효과</a> 
               <a class="p-2 link-success" href="/getFreeBoardList">자유게시판</a> 
               <a class="p-2 link-success" href="/ay/getBoardList">공지사항</a> 
               <a class="p-2 link-success" href="/qnaList">Q&A</a>
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
				<tr><td><fmt:formatDate value="${board.boarddate}" pattern="YYYY.MM.dd. hh:mm"/> 조회 ${board.boardsee}
				<!-- 로그인 안된 상태 , 빈 하트 보이게--> <c:if test="${member.id == null}">
						<img id="h" src="/img/empty.png" width="20px" title="123">
					</c:if> 추천수 <span id="recom_free">${board.boardrecom}</span> <c:if test="${member.id != null}">
						<c:if test="${result == 0}">
							<img id="h" src="/img/empty.png" width="20px">
						</c:if>
						<c:if test="${result != 0}">
							<img id="h" src="/img/full.png" width="20px">
						</c:if>
					</c:if></td>
					<td align="right"><c:if test="${board.member.id eq member.id}">
							<a href="/updateFreeBoard/${board.boardnum}">수정</a>	
							<a id="delete_board" href="/deleteFreeBoard/${board.boardnum}" onclick='return confirm("정말 삭제하시겠습니까?");'>삭제</a>
						</c:if>
					</td></tr>
				<tr><td colspan="2"><hr align="center"></td></tr>
				<tr><td colspan="2">${board.boardcontent}</td></tr>
			</table><br>

			<!-- 댓글 -->	
			<div id="comment_out">							
				<h3>댓글 ${total}</h3>				
					<c:forEach items="${clist}" var="comment">
						<div id="comment${comment.comnum}">
							<img style = "border-radius:70%;" src="${comment.member.memphoto}" width="40px" height="auto"><strong>${member.id}</strong>
						
							<c:if test="${comment.commennum eq member.memnum}">												
								<a href="#modify_comment" onclick="modify_comment(${comment.comnum})">수정</a>								
								<a href="#delete_comment" onclick="delete_comment(${comment.comnum})">삭제</a>						
							</c:if>
						</div>
											
						<div id="reply${comment.comnum}">${comment.comcontent}</div>						
							<small><fmt:formatDate value="${comment.comdate}" pattern="YY.MM.dd HH:mm" /></small>
						
						<!-- 댓글 수정 -->
						<div id="replyDiv${comment.comnum}" style="display: none">
								<input type="hidden" id="boardnum${comment.boardnum}" name="boardnum" value="${comment.boardnum}">
								<textarea style="width: 100%;" id="comcontent${comment.comnum}" name="comcontent" rows="3" cols="30" maxlength="500">${comment.comcontent}</textarea>
								<button type="button" id="update_comment" onclick="update_comment(${comment.comnum})" class="btn btn-sm btn-success">저장</button>
								<button type="button" id="update_comment" onclick="cancle_comment(${comment.comnum})" class="btn btn-sm btn-success">취소</button>
						</div>
						<hr width="800">
					</c:forEach>
						
				<div id="page">
					<c:if test="${begin > 2}">
						<a href="/content/1/${board.boardnum}?p=${begin-1}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin}" end="${end}" var="i">
						<a href="/content/1/${board.boardnum}?p=${i}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage}">
						<a href="/content/1/${board.boardnum}?p=${end+1}">[다음]</a>
					</c:if>
				</div>				
			</div>	
		
			<br>
			<textarea style="width: 100%;" id="comment_in" name="comment_in" rows="3" cols="30" maxlength="500" placeholder="댓글을 달아주세요."></textarea> 
			<div class="mb-2" style="text-align: right;">
				<button id="bnt_c" class="btn btn-sm btn-success">등록</button>
			</div>
		</div>
	</main>
	
	<%@ include file="../DsBoard/DsLayout/dsFooter.jsp"%>
	
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
				success : function(data) {
					
				},
				error : function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	            }
				
				}).done(function() {
					$("#comment_in").val("");
					getList();
			}); //ajax
		}); //bnt_c
		
	    $.ajax({
	        type : "get",
	        url : "/countAlarm",
	        data : { "memnum" : '${member.memnum}'},
	        dataType : "text"
	     }).done(function(data){
	        //alert(data)
	        if(data != ""){
	           $('#alarmcount').css('background','#41FF3A')
	           $('#alarmcount').html('<span>'+data+'</span>');
	        }
	     }).fail(function(e){
	        alert("실패")
	        alert(e.responseText)            
	     })
	});

	function getList(){
		let formData = new FormData();
		$.ajax({
			type : "get",
			url : "/replyFreeComment/${board.boardnum}",
			dataType : "text",
			data : formData, 
			contentType: false, 
			processData: false, 
			cache : false,
			success : function(data) {
	           	// C에서 받아온 데이터로 새로 뿌려주기
				let html = jQuery('<div>').html(data);
				let contents = html.find("div#comment_out").html();
				$("#comment_out").html(contents);
			},
			error : function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        }
		});
	}
	
	function delete_comment(comnum) {
		if (!confirm("댓글을 삭제하시겠습니까?")) {
			return;
		}
		$.ajax({
			url : "/deleteFreeBoardComment",
			data : "comnum=" + comnum
		}).done(function() {
			//$("#comment_out").load(location.href + " #comment_out");
			getList();
		}); //ajax
	} //delete_comment

	function modify_comment(comnum) {
		let reply = document.getElementById("reply" + comnum);
		let replyDiv = document.getElementById("replyDiv" + comnum);
		replyDiv.style.display = "";
		reply.style.display = "none";
	} //modify_comment

	function update_comment(comnum) {
		let replyDiv = document.getElementById("replyDiv" + comnum);
		let content = $("#comcontent"+comnum).val();
		let param = {content:content, comnum:comnum};
		if (!content) {
		     alert("글 내용을 입력해주세요.");
		     $("#comcontent"+comnum).focus();
		     return false;
		}else{
			$.ajax({
				url : "/updateFreeBoardComment",
				data : param,				
				error : function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	            }
			}).done(function() {
				//$("#comment_out").load(location.href + " #comment_out");
				getList();
			});
		}
	}

	function cancle_comment(comnum) {
		let reply = document.getElementById("reply" + comnum);
		let replyDiv = document.getElementById("replyDiv" + comnum);
		//document.body.appendChild(replyDiv);
		reply.style.display = "";
		replyDiv.style.display = "none";
		return false;
	}
  
    function ring(x){ //알람 창 열고 데이터 가져오는 함수
        //alert(${memnum})
        $.ajax({
           type : "get",
           url : "/getAlarm",
           data : {"memnum" : '${member.memnum}'},
           dataType : "text"
        }).done(function(data){
           //alert("성공")
           if($('#alarmpage').html()){
              $('#alarmpage').remove();
           }else{
              $('#login').append("<div id='alarmpage'></div>"   );
              $('#alarmpage').html(data) //alarmpage에 따로만든 jsp파일넣기
           }
        }).fail(function(e){
           alert("실패")
           alert(e.responseText);
        })
     }
     function delAlarm(x){
        let alanum = x;
        let memnum = '${member.memnum}'
        $.ajax({
           type : "get",
           url : "/delAlarm",
           data : {"alanum" : alanum , "memnum" : memnum},
           dataType : "text"
        }).done(function(data){
           //alert(data)
           $('#'+alanum).remove();
           $('#alarmcount').html('<span>'+data+'</span>');
           
           if (data == "" ){
              $('#alarmcount').css('background','white')
           }
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

	//추천 부분	
	$(function() {
	$("#h").click(function() {
		let num = ${board.boardnum};
		let id = "${member.id}";
        console.log(id);
		let url = "/updateFreeRecom/" + num + "/" + id;
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
						$("#recom_free").html(data);//매개변수가 있으니까 변경된 값 가져옴
						}).fail(
							function(jqXHR, textStatus,errorThrown) {
							console.log("error");
					}); 
				
		})
	})
		
</script>
</html>