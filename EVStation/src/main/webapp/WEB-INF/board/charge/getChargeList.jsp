<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>충전소목록</title>
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
										<li><a class="dropdown-item" href="/myBookmark">즐겨찾기</a></li>
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
         
      

<body>
	<div id="center">
	<h1>충전소 목록</h1>
	<div id="search_msg"><h4>${search_msg}</h4></div>
		
	<c:if test="${total == 0}">검색 결과가 없습니다.</c:if>	
	
	<c:if test="${total != 0}">	
	<table class="table table-bordered table-hover" style="width: 800px; margin-left:auto; margin-right:auto;" >
		<thead class="table-secondary text-center">
			<tr>
				<th>번호</th>
				<th>충전소이름</th>
				<th>주소</th>
				<th>휴무일</th>
			</tr>
		</thead>
		
		<tbody class="text-center">
			<c:forEach items="${blist}" var="charge">
				<tr>
					<td style="width: 8%">${charge.stnum}</td>
					<td style="width: 30%"><a href="/list/${charge.stnum}">${charge.stname}</a></td>
					<c:if test="${charge.staddress1!=null}"><td style="width: 50%">${charge.staddress1}</td></c:if>
					<c:if test="${charge.staddress1==null}"><td style="width: 50%">${charge.staddress2}</td></c:if>
					<td style="width: 12%">${charge.stclosedday}</td>
				</tr>	
			</c:forEach>
		</tbody>		
	</table>


	<div id="page">
				<c:if test="${search == null}">
					<c:if test="${begin > 2}">
						<a href="/getChargeList?p=${begin-1}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin}" end="${end}" var="i">
						<a href="/getChargeList?p=${i}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage}">
						<a href="/getChargeList?p=${end+1}">[다음]</a>
					</c:if>
				</c:if>
				<c:if test="${search != null}">
					<c:if test="${begin > 2}">
						<a href="/getChargeList?p=${begin-1}&search=${search}&searchn=${searchn}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin}" end="${end}" var="i">
						<a href="/getChargeList?p=${i}&search=${search}&searchn=${searchn}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage}">
						<a href="/getChargeList?p=${end+1}&search=${search}&searchn=${searchn}">[다음]</a>
					</c:if>
				</c:if>
			</div>
			</br>
		</c:if>

			
			<form name="search-form">
				<div style="width: 400px;  text-align:center;" class="input-group">
				<select style="width: 130px;" class="form-select" name="searchn">
					<option value="0">이름</option>
					<option value="1">주소</option>
				</select> 
					<input style="width: 200px;" type="text" class="form-control" name="search" size="15" maxlength="50" />
					<input style="width: 70px;" type="submit" class="btn-success" value="검색" />
				</div>
			</form>
	</div>
			
<!-- <div style="text-align:center" >
	<form name="search-form" autocomplete="off">
		<select name="type">
			<option selected value="">선택</option>
			<option value="title">제목</option>
			<option value="address">주소</option>
		</select>
		<input type="text" name="keyword" value=""></input>
		<input type="button" onclick="getSearchList()" class="btn btn-outline-primary mr-2" value="검색"></input>
	</form>
	</div> -->



<%@ include file="/WEB-INF/layout/Footer.jsp"%>

</body>
</html>