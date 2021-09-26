<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>글 상세보기</title>
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
	left : 1230px;
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
	left : 1700px;
	top : 200px;
	width : 300px;
	height : 400px;
}
</style>
</head>
<body>
   <div class="container">
      <header class="py-3">
         <div class="row justify-content-center">

            <div class="col-6 pt-2">
               <a href="/" class="link-secondary"> <img src="/img/logo.png" width="220" height="100"></a>
               
            </div>

           <div class="col-6 d-flex-column-reverse justify-content-end align-items-center">
					<!-- justify-content 자식요소 정렬  -->
					<%-- <div id="login" style="text-align:right;margin-bottom:10px;"><div id="alarmcount"></div><img style="cursor:pointer;"src="/img/alarm1.png"
						width="30" height="30" onclick="ring(${member.memnum})">
					</div>	 --%>					
					<c:choose>
						<c:when test="${member.id eq null}">

							<div style="float:right;">
								<a class="btn btn-sm btn-outline-success" href="../../loginView">로그인</a> 
								<a class="btn btn-sm btn-outline-success" href="../../joinView">회원가입</a>
							</div>	
						</c:when>
						<c:otherwise>
							<div id="login" style="text-align:right;margin-bottom:10px;"><div id="alarmcount"></div><img style="cursor:pointer;"src="/img/alarm1.png"
							width="30" height="30" onclick="ring(${member.memnum})">
							</div>
							<div style="float:right;"><img src="${member.memphoto}" width="45" height="30">${member.name}(${member.id})님 환영합니다!! </br>
							<div id="btns" style="float: right;">
										<button class="btn btn-sm btn-outline-success dropdown-toggle"
											type="button" id="dropdownMenuButton1"
											data-bs-toggle="dropdown" aria-expanded="false">
										 마이페이지</button>
										<ul class="dropdown-menu"
											aria-labelledby="dropdownMenuButton1">
											<li><a class="dropdown-item" href="/check_mypage">개인정보수정</a></li>
											<li><a class="dropdown-item" href="/AllBoardList/${member.memnum}">내가 쓴 글</a></li>
											<li><a class="dropdown-item" href="#">즐겨찾기</a></li>
											<c:if test="${member.getId() == 'admin'}"> <!-- 관리자 전용 페이지 -->
											<li><a class="dropdown-item" href="/ay/admin">관리자페이지</a></li>
											</c:if>
											
										</ul>
									<a class="btn btn-sm btn-outline-success" href="../../logout">로그아웃</a>
								</div>
							</div>
						</c:otherwise>						
					</c:choose>
				</div>
         </div>

         <div class="menubar py-1 mb-2">
            <nav class="nav d-flex justify-content-center border-top border-bottom">
               <a class="p-2  link-success" href="../../pageIntro">페이지 소개</a> 
               <a   class="p-2 link-success" href="#">충전소 현황</a> 
               <a   class="p-2 link-success" href="../../benefit">기대효과</a> 
               <a   class="p-2 link-success" href="../../getFreeBoardList">자유게시판</a> 
               <a   class="p-2 bg-success text-white" href="/ay/getBoardList">공지사항</a> 
               <a   class="p-2 link-success" href="../../qnaList">Q&A</a>
            </nav>
         </div>
      </header>
   </div>

   <main>
   <div id="center">
         <table class="table table-borderless border">
            <tr><td><a href="/ay/getBoardList"><small style="color: green">공지사항 ></small></a></td></tr>
            <tr><td><h2>${board.title}</h2></td></tr>
            <tr><td colspan="2"><img src="${member.memphoto}" width="45" height="30"><strong>${member.id}</strong></td></tr>
            <tr><td><fmt:formatDate value="${board.createDate}" pattern="YYYY.MM.dd. hh:mm"/> 조회 ${board.cnt}추천<span id="recom_div">${board.recom}
            </span><c:if test= "${member.id == null}"><img id="h" src="/img/empty.png" width="20px" title="123"></c:if>
         <!-- 로그인 안된 상태 , 빈 하트 보이게-->
               <c:if test= "${member.id != null}">
                  <c:if test="${result == 0}">
                     <img id="h" src="/img/empty.png" width="20px">
                  </c:if>
                  <c:if test="${result != 0}">
                     <img id="h" src="/img/full.png" width="20px">
                  </c:if>
               </c:if>   </td>

               <td align="right"><c:if test="${member.getId() == 'admin'}"><!-- !!!!!!!!!관리자 아이디 넣기!!!!!! -->
                     <a href="/ay/updateForm/${board.num}">수정</a>   
                     <a href="/ay/delete/${board.num}">삭제</a>
                  </c:if>
               </td></tr>
            <tr><td colspan="2"><hr align="center"></td></tr>
            <tr><td colspan="2">${board.content}</td></tr>
         </table><br>
      </div>
      </main>
      <%@ include file="/WEB-INF/layout/Footer.jsp"%>
      </body>
                     
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   <script>
      $(function() {
         $("#h").click(function() {
                     
                        let num = ${board.num};
                        let id = "${member.id}";
                           console.log(id);
                        let url = "/upRecom/" + num + "/" + id;
                        
                        $.ajax({
                                 url : url
                              })   
                              .done(
                                    function(data) {
                                       //history.go(0);
                                       //alert(data)
                                       if (document.getElementById("h").getAttribute('src') == '/img/empty.png') {
                                          document.getElementById("h").src = "/img/full.png";
                                       } else {
                                          document.getElementById("h").src = "/img/empty.png";//.src는 속성값 변경
                                       }
                                       $("#recom_div").text(data);//매개변수가 있으니까 변경된 값 가져옴
                                    }).fail(
                                    function(jqXHR, textStatus,errorThrown) {
                                       console.log("error");
                                    }); 
                     
                              })//2
      }); 
      
      
      
      
   </script>

</body>
</html>