<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/layout/HeaderNormal.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 글</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
		var url = "/deleteChk";
		var valueArr = new Array(); //boardnum 넣을 변수 
		var valueRef = new Array(); //boardref 넣을 변수 

		var list = $("input[name='ChkBxRow']"); // 모든 체크박스 값을 list에 정의 
		for (var i = 0; i < list.length; i++) {
			if (list[i].checked) { //해당값이 체크되어 있다면
				valueArr.push(list[i].value); //value값 리스트에
				valueRef.push(list[i].getAttribute("alt")) //alt값 리스트에
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
					"valueRef" : valueRef
				},
				success : function(adata) {
					alert("삭제성공");
					location.replace("/myAllBoardList/${member.memnum}") // qnaList 페이지로 새로고침

				}
			});
		}
	}
</script>
<style>
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
<div id="head">
	<div class="py-4 mb-4 ml-4" style="margin: 100 auto" align="center" >
		<div class="btn-group btn-group-justified btn-group-md" role="group" align="right" style="width: 40%;">
			<button type="button" class="btn btn-outline-secondary"  onclick="location.href='/myAllBoardList/${member.memnum}';">&nbsp;&nbsp;&nbsp;전체글&nbsp;&nbsp;&nbsp;</button>
			<button type="button" class="btn btn-secondary" onclick="location.href='/myReviewBoardList/${member.memnum}';">&nbsp;&nbsp;&nbsp;리뷰&nbsp;&nbsp;&nbsp;</button>
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

						<td><a href="/qnaDetail/${list.boardnum}"> 
						<c:if test="${list.boardrelevel >= 1 }">[답변완료]</c:if> 
						 ${list.boardtitle}
						</a></td>

						<td>${list.boardwriter}</td>
						<td><fmt:formatDate value="${list.boarddate}" pattern="MM.dd" /></td>
						<td>${list.boardsee}</td>
						<td>${list.boardrecom}</td>

					
					</tr>
				</c:forEach>
					<c:forEach items="${rlist}" var="rlist">
					<tr>
							<td><input type="checkbox" name="ChkBxRow" value="${rlist.boardnum}" ></td>

						<td>${rlist.boardnum}</td>

						<td><a href="/qnaDetail/${rlist.boardnum}">${rlist.boardtitle}</a></td>

						<td>${rlist.boardwriter}</td>
						<td><fmt:formatDate value="${rlist.boarddate}" pattern="MM.dd" /></td>
						<td>${rlist.boardsee}</td>
						<td>${rlist.boardrecom}</td>

					
					</tr>
				</c:forEach>
					<c:forEach items="${flist}" var="flist">
					<tr>
							<td><input type="checkbox" name="ChkBxRow" value="${flist.boardnum}"></td>

						<td>${flist.boardnum}</td>

						<td><a href="/qnaDetail/${flist.boardnum}"> 
						 ${flist.boardtitle}
						</a></td>

						<td>${flist.boardwriter}</td>
						<td><fmt:formatDate value="${flist.boarddate}" pattern="MM.dd" /></td>
						<td>${flist.boardsee}</td>
						<td>${flist.boardrecom}</td>

					
					</tr>
				</c:forEach>

		</table>
			<button type="button" class="btn btn-outline-secondary btn-sm" onclick="deleteValue();">삭제하기</button>
			
			
			<div id="page">
					<c:if test="${begin > 2 }">
						<a href="/myAllBoardList/${member.memnum}?p=${begin-1}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin }" end="${end}" var="i">
						<a href="/myAllBoardList/${member.memnum}?p=${i}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage }">
						<a href="/myAllBoardList/${member.memnum}?p=${end+1}">[다음]</a>
					</c:if>
			</div>
				
			

</div>

			<div class="btn-group-vertical btn-group-md" role="group" aria-label="Basic example" style="width: 8%;">
				<button type="button" class="btn btn-secondary">개인정보수정</button>
				<br>
				<button type="button" class="btn btn-outline-secondary">내가 쓴 글</button>
				<br>
				<button type="button" class="btn btn-secondary">즐겨찾기</button>
				<br>
				<button type="button" class="btn btn-secondary">회원탈퇴</button>
				<br>
			</div>
		



		<%@ include file="/WEB-INF/layout/Footer.jsp"%>
</body>
</html>