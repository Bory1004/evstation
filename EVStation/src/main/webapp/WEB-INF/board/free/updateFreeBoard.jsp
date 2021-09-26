<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>자유 게시판 수정</title>
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
			<h4>자유 게시판 수정하기</h4><br>
			<form id="update_form" action="/updateFreeBoard" method="post">
				<input type="hidden" name="boardnum" value="${board.boardnum}">
				<table class="table table-borderless border">
					<tr><td><a href="/getFreeBoardList"><small style="color: green">자유 게시판 ></small></a></td></tr>	
					<tr><td><input class="form-control" name="boardtitle" id="boardtitle" value="${board.boardtitle}" placeholder="제목을 입력해 주세요."></td></tr>
					<tr><td><textarea name="boardcontent" id="boardcontent">${board.boardcontent}</textarea></td></tr>
					<tr><td colspan="2" align="center">
					<input class="btn btn-success" type="submit" id="savebutton" value="수정">
					</td></tr>
				</table>
			</form>
		</div>
	</main>

	<%@ include file="/WEB-INF/layout/Footer.jsp"%>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/resources/naver-smarteditor2/demo/js/service/HuskyEZCreator.js" charset="utf-8"></script>
	<script type="text/javascript">
		$(function(){
			let oEditors = [];
	
			nhn.husky.EZCreator.createInIFrame({
    		oAppRef: oEditors,
    		elPlaceHolder: "boardcontent",  //textarea ID
    		sSkinURI: "<%= request.getContextPath() %>/resources/naver-smarteditor2/demo/SmartEditor2Skin.html",  //skin경로
    		fCreator: "createSEditor2",
    		htParams : {
       			// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
        		bUseToolbar : true,             
        		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
        		bUseVerticalResizer : true,     
        		// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
        		bUseModeChanger : true, 
        		fOnBeforeUnload : function(){
        		}
			}
		});
			
		//전송버튼
		$("#savebutton").click(function(){
			if(!$("#boardtitle").val()){
				alert("제목을 입력해주세요!");
				return false;
			}
			if(!$("#boardcontent").val()){
				alert("내용을 입력해주세요!");
				return false;
			}
			
			//id가 smarteditor인 textarea에 에디터에서 대입
			oEditors.getById["boardcontent"].exec("UPDATE_CONTENTS_FIELD", []);			
			let content = $("#boardcontent").val();
			
			if(content == ""  || content == null || content == '&nbsp;' || content == '<p>&nbsp;</p>' || content == "<p><br></p>")  {
	             alert("내용을 입력하세요.");
	             oEditors.getById["boardcontent"].exec("FOCUS"); //포커싱
	             return false;
	        }
			//폼 submit
			
			})
			
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
</body>
</html>