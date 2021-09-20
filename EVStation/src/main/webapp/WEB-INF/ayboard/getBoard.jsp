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
</style>
</head>
<body>
   <div class="container">
      <header class="py-3">
         <div class="row justify-content-center">

            <div class="col-6 pt-2">
               <a href="/" class="link-secondary"> <img src="/img/logo.png" width="200" height="100"></a>
               
            </div>

            <div class="col-6 d-flex justify-content-end align-items-center">
               <!-- justify-content 자식요소 정렬  -->
                                       
               <c:choose>
                  <c:when test="${member.id eq null}">
                     <div>
                        <a class="btn btn-sm btn-outline-success" href="../../loginView">로그인</a> 
                        <a class="btn btn-sm btn-outline-success" href="../../joinView">회원가입</a>
                     </div>   
                  </c:when>
                  <c:otherwise>
                     ${member.id}님 환영합니다!! <a class="btn btn-sm btn-outline-success" href="../../logout">로그아웃</a>
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

               <td align="right"><c:if test="${member.getId() == 'dkdus'}"><!-- !!!!!!!!!관리자 아이디 넣기!!!!!! -->
                     <a href="/ay/updateForm/${board.num}">수정</a>   
                     <a href="/ay/delete/${board.num}">삭제</a>
                  </c:if>
               </td></tr>
            <tr><td colspan="2"><hr align="center"></td></tr>
            <tr><td colspan="2">${board.content}</td></tr>
         </table><br>
      </div>
      </main>
      <%@ include file="../DsBoard/DsLayout/dsFooter.jsp"%>
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
      
      $(function() {
         $("#bnt_c").click(function() {
            let content = $("#comment_in").val();
            if (!content) {
               alert('댓글을 입력하세요.')
               $("#comment_in").focus();
               return false;
            }
            $.ajax({
               url : "/ay/insertComment/${board.num}",
               data : "content=" + content,
               dataType : "text"
            }).done(function() {
               $("#comment_out").load(location.href + " #comment_out");
               $("#comment_in").val("");
            }); //ajax
         }); //bnt_c

         $("#update_comment").click(function() {
            let form1 = $("#form1").serialize();
            $.ajax({
               type : "post",
               url : "/ay/updateComment",
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
            url : "/ay/deleteComment",
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
         
         $.ajax({
            url : "/ay/modifyComment",
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

</body>
</html>