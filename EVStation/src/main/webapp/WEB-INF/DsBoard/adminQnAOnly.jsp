<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 <%@ include file="DsLayout/dsHeaderNormal.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA관리</title>
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
		var valueRestep = new Array(); // boardrestep
		var list = $("input[name='ChkBxRow']"); // 모든 체크박스 값을 list에 정의 
		var list2 = $("input[name='ChkBxRow2']");
		for (var i = 0; i < list.length; i++) {
			if (list[i].checked) { //해당값이 체크되어 있다면
				valueArr.push(list[i].value); //value값 리스트에
				valueRef.push(list[i].getAttribute("alt")) //alt값 리스트에
				if (list[i].checked) {
					valueRestep.push(list2[i].value);
				}
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
					"valueRef" : valueRef,
					"valueRestep" : valueRestep
				},
				success : function(adata) {
					alert("삭제성공");
					location.replace("/adminQnAOnly") // 삭제후 해당 페이지로 새로고침

				}
			});
		}
	}
</script>
<style>
#center {
	float:right;
	 width: 40%;
	margin-left: auto;
	margin-right: 25%;
}
.btn-group-vertical {
	margin-right: auto;
	margin-left: 23%;
	margin-top: 0%;
}
#page {
	text-align: center;
}
</style>
</head>
<body>
<div id="center">
<h4>QnA 게시판</h4>
		<a href="/adminQnAOnly"><small class="text-muted">QnA 게시판 전체 목록 ></small></a>
<c:if test="${total == 0}">검색 결과가 없습니다.</c:if>
<c:if test="${ total != 0}">
<table style="text-align: center" class="table table-hover caption-top">
			<thead class="table-light">
				<tr>
						<th><input type="checkbox" name="ChkBxAll" id="ChkBxAll;"></th>
					<th scope="col"><b>No.</b></th>  
					<th style="width: 250px;" scope="col">제목</th>
					<th scope="col"><b>작성자</b></th>
					<th scope="col"><b>작성일</b></th>
					<th scope="col"><b>조회수</b></th>
					<th scope="col"><b>추천수</b></th>
					<th scope="col"><b>답변여부</b></th>
				</tr>
			</thead>
			<c:forEach items="${list}" var="list">
			
						<tr>
							<td><input type="checkbox" name="ChkBxRow" value="${list.boardnum}" alt="${list.boardref}">
									<input type="hidden" name="ChkBxRow2" value="${list.boardrestep}"></td>
							<td>${list.boardnum}</td>

							<td><a href="qnaDetail/${list.boardnum}">
						<c:if test="${list.boardrelevel == 0 }">[질문]</c:if>
						 <c:if test="${list.boardrelevel >= 1 }">&nbsp; &nbsp; &nbsp; &nbsp;ㄴRE:</c:if>
						<%--   <c:if test="${list.boardrelevel > 1 }">
						<c:forEach begin="2" end="${list.boardrelevel}">
							Re:
						</c:forEach>
								</c:if> --%>  <!-- 답변의 답변의 경우부터 사용 -->
						 ${list.boardtitle}
						</a></td>
							
							<td>${list.boardwriter}</td>
							<td><fmt:formatDate value="${list.boarddate}" pattern="MM.dd" /></td>
							<td>${list.boardsee}</td>
							<td>${list.boardrecom}</td>
							<td>${list.boardyn}</td>
					 </tr>
							
				</c:forEach>
				
		</table>
		<button type="button" class="btn btn-outline-secondary btn-sm" onclick="deleteValue();">삭제하기</button>	
<div id="page">
				<c:if test="${search == null }">
					<c:if test="${begin > 2 }">
						<a href="/qnaList?p=${begin-1}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin }" end="${end}" var="i">
						<a href="/qnaList?p=${i}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage }">
						<a href="/qnaList?p=${end+1}">[다음]</a>
					</c:if>
				</c:if>
				<c:if test="${search != null }">
					<c:if test="${begin > 2 }">
						<a href="/qnaList?p=${begin-1}&search=${search}&searchn=${searchn}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin }" end="${end}" var="i">
						<a href="/qnaList?p=${i}&search=${search}&searchn=${searchn}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage }">
						<a href="/qnaList?p=${end+1}&search=${search}&searchn=${searchn}">[다음]</a>
					</c:if>
				</c:if>

			</div><!-- page -->
		</c:if>
			
			<form>
			<div style="width: 400px;" class="input-group">
				<select style="width: 130px" class="form-select" name="searchn">
					<option value="0">제목</option>
					<option value="1">내용</option>
					<option value="2">작성자</option>
				</select> <input style="width: 200px;" type="text" class="form-control" name="search" size="15" maxlength="50" /> <input style="width: 70px;" type="submit" class="btn-success" value="검색" />
			</div>
		</form>


</div><!--  center -->

			<div class="btn-group-vertical btn-group-md" role="group" aria-label="Basic example" style="width:150px;">
				<button type="button" class="btn btn-outline-secondary" onclick="location.href='/adminQnAOnly';">QnA문의</button>
				<br>
				<button type="button" class="btn btn-secondary">충전소 관리</button>
				<br>
				<button type="button" class="btn btn-secondary" onclick="location.href='/admin_member';">사용자 관리</button>
				<br>
				<button type="button" class="btn btn-secondary" onclick="location.href='/ay/admin';">공지사항 관리</button>
				<br>
				<button type="button" class="btn btn-secondary" onclick="location.href='/admin_freeboard';">자유게시판 관리</button>
				<br>
				<button type="button" class="btn btn-secondary" onclick="location.href='/adminReview';">리뷰게시판 관리</button>
				<br>
			</div>
<%@ include file="DsLayout/dsFooter.jsp"%>
</body>
</html>