<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<!-- <div id="group-area" class="">
		아이디
	</div> -->
	<div id="center">
		<h4>자유 게시판</h4>
		<a href="/getFreeBoardList"><small class="text-muted">자유 게시판 전체 목록 ></small></a>
		
		<div id="search_msg"><h4>${search_msg}</h4></div>
		
		<c:if test="${total == 0}">게시물이 없습니다.</c:if>	

		<c:if test="${total != 0}">
			<table style="text-align: center" class="table table-hover caption-top">				
				<thead class="table-light">
					<tr>
					<th scope="col">번호</th>
					<th style="width: 300px;" scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">등록일</th>
					<th scope="col">조회수</th>
				</tr>
				</thead>
				<c:forEach items="${blist}" var="board">
					<tr>
						<td>${board.boardnum}</td>
						<td><a href="/content/1/${board.boardnum}">${board.boardtitle}</a></td>
						<td>${board.member.id}</td>
						<td><fmt:formatDate value="${board.boarddate}" pattern="MM.dd"/></td>
						<td>${board.boardsee}</td>
					</tr>
				</c:forEach>
			</table>
			<div id="page">
				<c:if test="${search == null}">
					<c:if test="${begin > 2}">
						<a href="/getFreeBoardList?p=${begin-1}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin}" end="${end}" var="i">
						<a href="/getFreeBoardList?p=${i}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage}">
						<a href="/getFreeBoardList?p=${end+1}">[다음]</a>
					</c:if>
				</c:if>
				<c:if test="${search != null}">
					<c:if test="${begin > 2}">
						<a href="/getFreeBoardList?p=${begin-1}&search=${search}&searchn=${searchn}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin}" end="${end}" var="i">
						<a href="/getFreeBoardList?p=${i}&search=${search}&searchn=${searchn}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage}">
						<a href="/getFreeBoardList?p=${end+1}&search=${search}&searchn=${searchn}">[다음]</a>
					</c:if>
				</c:if>
			</div>
		</c:if>
		
		
		<div align="right">
			<a class="btn btn-outline-secondary btn-sm" href="/insertFreeBoard">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
  				<path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/>
				</svg>글쓰기</a> 
		</div>
		
		<br>
		
		<form>
		<div style="width: 400px;" class="input-group">
			<select style="width: 130px;" class="form-select" name="searchn">
				<option value="0">제목</option>
				<option value="1">내용</option>
				<option value="2">작성자</option>
			</select> 
			<input style="width: 200px;" type="text" class="form-control" name="search" size="15" maxlength="50" />
			<input style="width: 70px;" type="submit" class="btn-success" value="검색" />
		</div>
		</form>

	</div>
	</main>
	
	<%@ include file="../DsBoard/DsLayout/dsFooter.jsp"%>
	
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function(){
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
 
 })
 
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
</script>
</html>




