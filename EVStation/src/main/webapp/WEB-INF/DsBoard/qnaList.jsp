<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="DsLayout/dsHeaderQnA.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
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
					location.replace("qnaList") // qnaList 페이지로 새로고침

				}
			});
		}
	}
</script>
<style>
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
	<div id="center">
		<h4>QnA 게시판</h4>
		<a href="/qnaList"><small class="text-muted">QnA 게시판 전체 목록 ></small></a>


		<div id="search_msg">
			<h5>${search_msg}</h5>
		</div>
		<!-- 검색메세지 -->

		<c:if test="${total == 0}">검색 결과가 없습니다.</c:if>
		<c:if test="${ total != 0}">
			<table style="text-align: center" class="table table-hover caption-top">
				<thead class="table-light">
					<tr>
						<c:if test="${member.getId() == 'admin'}">
							<!-- 관리자만 보이게 -->
							<th><input type="checkbox" name="ChkBxAll" id="ChkBxAll;"></th>
						</c:if>
						<th scope="col"><b>No.</b></th>
						<th style="width: 300px;" scope="col"><b>제목</b></th>
						<th scope="col"><b>작성자</b></th>
						<th scope="col"><b>작성일</b></th>
						<th scope="col"><b>조회수</b></th>
						<th scope="col"><b>추천수</b></th>

						<c:if test="${member.getId() == 'admin'}">
							<!-- 관리자만 보이게 -->
							<th><b>답변여부</b></th>
						</c:if>
					</tr>
				</thead>


				<c:forEach items="${list}" var="list">
					<tr>

						<c:if test="${member.getId() == 'admin'}">
							<td><input type="checkbox" name="ChkBxRow" value="${list.boardnum}" alt="${list.boardref}"></td>
						</c:if>

						<td>${list.boardnum}</td>

						<td><a href="qnaDetail/${list.boardnum}">
						 <c:if test="${list.boardrelevel == 1 }">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ㄴRe:💌</c:if>
						  <c:if test="${list.boardrelevel > 1 }">&nbsp; Re:💌
						<c:forEach begin="2" end="${list.boardrelevel}">
							Re:💌
						</c:forEach>
								</c:if> ${list.boardtitle}
						</a></td>

						<td>${list.boardwriter}</td>
						<td><fmt:formatDate value="${list.boarddate}" pattern="MM.dd" /></td>
						<td>${list.boardsee}</td>
						<td>${list.boardrecom}</td>

						<c:if test="${member.getId() == 'admin'}">
							<!-- 관리자만 보이게 -->
							<td>${list.boardyn}</td>
						</c:if>

					</tr>
				</c:forEach>
				
			</table>
			<c:if test="${member.getId() == 'admin'}">
				<!-- 관리자만 보이게 -->
				<button type="button" class="btn btn-outline-secondary btn-sm" onclick="deleteValue();">선택삭제</button>
			</c:if>
			
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

			</div>
		</c:if>
		<div align="right">
			<a class="btn btn-outline-secondary btn-sm" href="insertQnA"> <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
  				<path
						d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z" />
				</svg>글쓰기
			</a>
		</div>
		<!--  </br> -->
		<form>
			<div style="width: 400px;" class="input-group">
				<select style="width: 130px" class="form-select" name="searchn">
					<option value="0">제목</option>
					<option value="1">내용</option>
					<option value="2">작성자</option>
				</select> <input style="width: 200px;" type="text" class="form-control" name="search" size="15" maxlength="50" /> <input style="width: 70px;" type="submit" class="btn-success" value="검색" />
			</div>
		</form>
	</div>
	<%@ include file="DsLayout/dsFooter.jsp"%>
</body>
</html>