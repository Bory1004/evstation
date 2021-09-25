<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>관리자페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>


<script src= "http://code.jquery.com/jquery-1.6.4.min.js"></script>
	<script type="text/javascript">
		//체크박스 전체 선택 /해제 
	$(function(){
			 var chkObj = document.getElementsByName("ChkBxRow") //이름이 ChkBxRow인 모든 값을 chkObj에 정의
			 var rowCnt = chkObj.length;  // chkObj의 길이를  rowcnt에 정의
			 $("input[name='ChkBxAll']").click(function(){  //전체 체크박스 선택시
					var chk_listArr = $("input[name='ChkBxRow']"); // 이름이 ChkBxRow인 모든 체크박스를  chk_listArr에 값을 넣고
					for(var i = 0; i < chk_listArr.length; i++){   //for문으로 모든 체크박스를 하나씩 checked 상태로 만듬 -> 전체선택
						chk_listArr[i].checked = this.checked;
					}
			 });

			 $("input[name='ChkBxRow']").click(function(){ //각 체크박스가 선택되어지고 
		 			if($("input[name='ChkBxRow']:checked").length == rowCnt){ //선택되어진 각 체크박스의 길이가 == 모든 체크박스의 길이와 같다면
		 				$("input[name='ChkBxAll']")[0].checked = true; // 전체선택 true

		 			}else{
		 				$("input[name='ChkBxAll']")[0].checked = false; //아니면 false
		 			}
			 }); 
		});
		function deleteValue(){
				var url = "/ay/deleteChk";
				var valueArr = new Array(); //num 넣을 변수 
				
				var list = $("input[name='ChkBxRow']"); // 모든 체크박스 값을 list에 정의 
				for(var i = 0; i < list.length; i++){
					if(list[i].checked){  //해당값이 체크되어 있다면
						valueArr.push(list[i].value); //value값 리스트에
						
					}
				}
				/* console.log(valueArr)
				console.log(valueRef) */
		 	if (valueArr.length == 0){
					alert("선택된 글이 없습니다");
			}else{
					$.ajax({
						url : url,   //전송 URL
						type : 'POST',  //POST방식
 						traditional : true,
						data : {
							"valueArr" : valueArr
						},
						success: function(adata){
								alert("삭제성공");
								location.replace("getBoardList") // qnaList 페이지로 새로고침
							
						}
					});
				} 
		}	

		$(function(){
		    $('.alert').click(function(){
		    	if(${member.id  == null}){
		    		 alert("로그인 시 이용할 수 있는 서비스입니다.");
		    		 window.location.href = "http://localhost:8088/loginView";
		    	}else{
		    		let num = $(this).attr("id");
		    		window.location.href = "/ay/content/"+num;
		    	}
		       
		    });
		});
		
	</script>




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
	float:right;
	 width: 50%;
	margin-left: auto;
	margin-right: 20%;
}
.btn-group-vertical {
	margin-right: auto;
	margin-left: 15%;
	margin-top: 5%;
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
					<a href="/main" class="link-secondary"> 
					<img src="/img/logo.png" width="220" height="100"></a>
					<!--  <a class="link-secondary" href="#">Subscribe</a> -->
				</div>

				<div class="col-6 d-flex-column-reverse justify-content-end align-items-center">
					<!-- justify-content 자식요소 정렬  -->
					<%-- <div id="login" style="text-align:right;margin-bottom:10px;"><div id="alarmcount"></div><img style="cursor:pointer;"src="/img/alarm1.png"
						width="30" height="30" onclick="ring(${member.memnum})">
					</div>	 --%>					
					<c:choose>
						<c:when test="${member.id eq null}">

							<div style="float:right;">
								<a class="btn btn-sm btn-outline-success" href="../loginView">로그인</a> 
								<a class="btn btn-sm btn-outline-success" href="../joinView">회원가입</a>
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
									<a class="btn btn-sm btn-outline-success" href="../logout">로그아웃</a>
								</div>
							</div>
						</c:otherwise>						
					</c:choose>
				</div>
			</div>

			<div class="menubar py-1 mb-2">
				<nav class="nav d-flex justify-content-center border-top border-bottom">
					<a class="p-2  link-success" href="../pageIntro">페이지 소개</a> 
					<a class="p-2 link-success" href="#">충전소 현황</a> 
					<a class="p-2 link-success" href="../benefit">기대효과</a> 
					<a class="p-2 link-success" href="../getFreeBoardList">자유게시판</a> 
					<a class="p-2 bg-success text-white" href="/ay/getBoardList">공지사항</a> 
					<a class="p-2 link-success" href="../qnaList">Q&A</a>
				</nav>
			</div>
		</header>
	</div>
	
	
	<!-- <div id="group-area" class="">
		아이디
	</div> -->
	<div id="center">
		<h4>공지사항</h4>
		<a href="/ay/getBoardList"><small class="text-muted">공지사항 전체 목록 ></small></a>
		
		 <div id="search_msg"><h4>${search_msg}</h4></div>
		
		<c:if test="${total == 0}">검색 결과가 없습니다.</c:if>	

		<c:if test="${total != 0}">
			<table style="text-align: center" class="table table-hover caption-top">				
				<thead class="table-light">
					<tr>
					<c:if test="${member.getId() == 'admin'}">  <!-- 관리자만 보이게 -->
				    <th><input type="checkbox" name="ChkBxAll"  id="ChkBxAll;"></th>
					</c:if>	
					<th scope="col">No.</th>
					<th style="width: 300px;" scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">등록일</th>
					<th scope="col">추천수</th>
					<th scope="col">조회수</th>
				</tr>
				</thead>
				<c:forEach items="${bList}" var="board">
					<tr>
					<c:if test="${member.getId() == 'admin'}">
					    <td><input type="checkbox" name="ChkBxRow"  value="${board.num}"></td>
					    </c:if>
						<td>${board.num}</td>
						<td class="alert" id="${board.num}">${board.title}</td>
						<td>${member.id}</td>
						<td><fmt:formatDate value="${board.createDate}" pattern="MM.dd"/></td>
						<td>${board.recom}</td>
						<td>${board.cnt}</td>
					</tr>
				</c:forEach>
			</table>
			<c:if test="${member.getId() == 'admin'}">
			<button type="button"  class="btn btn-outline-secondary btn-sm"  onclick="deleteValue();" >선택삭제</button>
			</c:if>
			<div id="page">
				<c:if test="${search == null}">
					<c:if test="${begin > 2}">
						<a href="/ay/getBoardList?p=${begin-1}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin}" end="${end}" var="i">
						<a href="/ay/getBoardList?p=${i}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage}">
						<a href="/ay/getBoardList?p=${end+1}">[다음]</a>
					</c:if>
				</c:if>
				<c:if test="${search != null}">
					<c:if test="${begin > 2}">
						<a href="/ay/getBoardList?p=${begin-1}&search=${search}&searchn=${searchn}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin}" end="${end}" var="i">
						<a href="/ay/getBoardList?p=${i}&search=${search}&searchn=${searchn}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage}">
						<a href="/ay/getBoardList?p=${end+1}&search=${search}&searchn=${searchn}">[다음]</a>
					</c:if>
				</c:if>
			</div>
		</c:if>
		
	
		<div align="right">
			<c:if test="${member.getId() == 'admin'}">
			<a class="btn btn-outline-secondary btn-sm" href="/ay/insertBoard">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
  				<path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/>
				</svg>글쓰기</a> 
			</c:if>
		</div>
		
		<br>
		
		<form>
		<div style="width: 400px;" class="input-group">
			<select style="width: 130px;" class="form-select" name="searchn">
				<option value="0">제목</option>
				<option value="1">내용</option>
			</select> 
			<input style="width: 200px;" type="text" class="form-control" name="search" size="15" maxlength="50" />
			<input style="width: 70px;" type="submit" class="btn-success" value="검색" />
		</div>
		</form>
	</div><!-- center -->
	
	<div class="btn-group-vertical btn-group-md" role="group" aria-label="Basic example" style="width:11%;">
				<button type="button" class="btn btn-secondary">QnA문의</button>
				<br>
				<button type="button" class="btn btn-secondary">충전소 관리</button>
				<br>
				<button type="button" class="btn btn-secondary">사용자 관리</button>
				<br>
				<button type="button" class="btn btn-outline-secondary">공지사항 관리</button>
				<br>
				<button type="button" class="btn btn-secondary">자유게시판 관리</button>
				<br>
			</div>
	
<%@ include file="../DsBoard/DsLayout/dsFooter.jsp"%>
	
</body>
</html>