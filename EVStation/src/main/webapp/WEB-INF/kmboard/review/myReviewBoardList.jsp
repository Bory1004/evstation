<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
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

#alarmpage {
	position: absolute;
	border: solid #BDBDBD 1px;
	border-radius: 20px;
	width: 230px;
	height: 300px;
	left: 1230px;
	padding: 10px;
	overflow-y: auto;
}

#alarmcount {
	position: absolute;
	width: 30px;
	height: 20px;
	left: 1200px;
	top: 45px;
	border-radius: 10px;
	text-align: center;
	vertical-align: middle;
}

#alarmcount>span {
	position: relative;
	color: white;
	bottom: 3px;
}
#head{
		margin-left: 6%;
	
}
#center {
	float:right;
	 width: 40%;
	margin-left: auto;
	margin-right: 27%;
}
#page {
	text-align: center;

}
.btn-group-vertical {
	margin-right: auto;
	margin-left: 23%;
	margin-top: auto;
	
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/DsBoard/DsLayout/dsHeaderNormal.jsp"%>

<div id="head">
	<div class="py-4 mb-4 ml-4" style="margin: 100 auto" align="center" >
		<div class="btn-group btn-group-justified btn-group-md" role="group" align="right" style="width: 40%;">
			<button type="button" class="btn btn-secondary"  onclick="location.href='/AllBoardList/${member.memnum}';">&nbsp;&nbsp;&nbsp;전체글&nbsp;&nbsp;&nbsp;</button>
			<button type="button" class="btn btn-outline-secondary" onclick="location.href='/myReviewBoardList/${member.memnum}';">&nbsp;&nbsp;&nbsp;리뷰&nbsp;&nbsp;&nbsp;</button>
			<button type="button" class="btn btn-secondary" onclick="location.href='/myQnABoardList/${member.memnum}';">&nbsp;&nbsp;&nbsp;Q&A&nbsp;&nbsp;&nbsp;</button>
			<button type="button" class="btn btn-secondary " onclick="location.href='/myFreeBoardList/${member.memnum}';">자유게시판</button>
		</div>
	</div>
</div>
	<div id="center">

		<table style="text-align: center" class="table table-hover caption-top">
			<thead class="table-light">
				<tr>
						<th><input type="checkbox" name="ChkBxAll" id="ChkBxAll;"></th>
					<th scope="col"><b>No.</b></th>  
					<th scope="col"><b>제목</b></th>
					<th scope="col"><b>작성자</b></th>
					<th scope="col"><b>작성일</b></th>
					<th scope="col"><b>조회수</b></th>
					<th scope="col"><b>추천수</b></th>

				</tr>
			</thead>
			
			<c:forEach items="${list}" var="list">
					<tr>
							<td><input type="checkbox" name="ChkBxRow" value="${list.boardnum}" ></td>

						<td>${list.boardnum}</td>

						<td><a href="/content/${list.boardtype}/${list.boardnum}">${list.boardtitle}</a></td>

						<td>${list.boardwriter}</td>
						<td><fmt:formatDate value="${list.boarddate}" pattern="MM.dd" /></td>
						<td>${list.boardsee}</td>
						<td>${list.boardrecom}</td>

					</tr>
				</c:forEach>

		</table>
			<button type="button" class="btn btn-outline-secondary btn-sm" onclick="deleteValue();">삭제하기</button>
			<div id="page">
					<c:if test="${begin > 2 }">
						<a href="/myReviewBoardList/${member.memnum}?p=${begin-1}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin }" end="${end}" var="i">
						<a href="/myReviewBoardList/${member.memnum}?p=${i}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage }">
						<a href="/myReviewBoardList/${member.memnum}?p=${end+1}">[다음]</a>
					</c:if>
			</div>
				
			

</div>

			<div class="btn-group-vertical btn-group-md" role="group" aria-label="Basic example" style="width: 8%;">
				<button type="button" class="btn btn-secondary" onclick="location.href='/check_mypage'">개인정보수정</button>
				<br>
				<button type="button" class="btn btn-outline-secondary" onclick="location.href='/AllBoardList/${member.memnum}'">내가 쓴 글</button>
				<br>
				<button type="button" class="btn btn-secondary">즐겨찾기</button>
				<br>
				<button type="button" class="btn btn-secondary" onclick="window.open('http://localhost:8088/withdrawForm','new','scrollbars=no,width=430,height=400,top=100,left=100')">회원탈퇴</button>
				<br>
			</div>
		
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	//체크박스 전체 선택 /해제 
	$(function() {
		var chkObj = document.getElementsByName("ChkBxRow") //이름이 ChkBxRow인 모든 값을 chkObj에 정의
		var rowCnt = chkObj.length; // chkObj의 길이를  rowcnt에 정의
		$("input[name='ChkBxAll']").click(function() { //전체 체크박스 선택시
			var chk_listArr = $("input[name='ChkBxRow']"); // 이름이 ChkBxRow인 모든 체크박스를  chk_listArr에 값을 넣고
			for (var i = 0; i < chk_listArr.length; i++) { //for문으로 모든 체크박스를 하나씩 checked 상태로 만듬 -> 전체선택
				chk_listArr[i].checked = this.checked;
			}
		});

		$("input[name='ChkBxRow']").click(function() { //각 체크박스가 선택되어지고 
			if ($("input[name='ChkBxRow']:checked").length == rowCnt) { //선택되어진 각 체크박스의 길이가 == 모든 체크박스의 길이와 같다면
				$("input[name='ChkBxAll']")[0].checked = true; // 전체선택 true

			} else {
				$("input[name='ChkBxAll']")[0].checked = false; //아니면 false
			}
		});
	});
	function deleteValue() {
		var url = "/deleteReviewChk";
		var valueArr = new Array(); //boardnum 넣을 변수 
		var valueRef = new Array(); //boardref 넣을 변수 

		var list = $("input[name='ChkBxRow']"); // 모든 체크박스 값을 list에 정의 
		for (var i = 0; i < list.length; i++) {
			if (list[i].checked) { //해당값이 체크되어 있다면
				valueArr.push(list[i].value); //value값 리스트에
			}
		}
		/* console.log(valueArr)
		console.log(valueRef) */
		if (valueArr.length == 0) {
			alert("선택된 글이 없습니다");
		} else {
			$.ajax({
				url : url, //전송 URL
				type : 'POST', //POST방식
				traditional : true,
				data : {
					"valueArr" : valueArr,
				},
				success : function(adata) {
					alert("삭제성공");
					location.replace("/myReviewBoardList/${member.memnum}") 

				}
			});
		}
	}
</script>
</body>
</html>