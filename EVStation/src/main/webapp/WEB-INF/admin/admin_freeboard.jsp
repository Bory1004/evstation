<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../DsBoard/DsLayout/dsHeaderNormal.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
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
		var url = "/admin_freeboard_delete";
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
					location.replace("/admin_freeboard") // 페이지로 새로고침

				}
			});
		}
	}
</script>
<style>
#page {
	text-align: center;

}

#jb-container {
	width: 940px;
	margin: 0px auto;
}

#jb-content {
	width: 700px;
	padding: 20px;
	margin-bottom: 20px;
	float: right;
	/* border: 1px solid #bcbcbc; */
}

#jb-sidebar {
	width: 200px;
	padding: 20px;
	margin-bottom: 20px;
	float: left;
}
</style>
</head>
<body>
<div id="jb-container">
	<div id="jb-content">
			<h4>자유게시판 관리</h4>
			<a href="/admin_freeboard"><small class="text-muted">자유 게시판 전체 목록 ></small></a>
			<table style="text-align: center" class="table table-hover caption-top">
			<thead class="table-light">
				<tr>
					<th><input type="checkbox" name="ChkBxAll" id="ChkBxAll;"></th>
					<th scope="col"><b>No.</b></th>  
					<th style="width: 150px;" scope="col"><b>제목</b></th>
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
					<td><a href="/content/1/${list.boardnum}">${list.boardtitle}</a></td>
					<td>${list.boardwriter}</td>
					<td><fmt:formatDate value="${list.boarddate}" pattern="MM.dd" /></td>
					<td>${list.boardsee}</td>
					<td>${list.boardrecom}</td>				
				</tr>					
			</c:forEach>
		</table>
			<button type="button" class="btn btn-outline-secondary btn-sm" onclick="deleteValue();">삭제하기</button>
					
			<div id="page">
				<c:if test="${search == null}">
					<c:if test="${begin > 2 }">
						<a href="/admin_freeboard?p=${begin-1}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin}" end="${end}" var="i">
						<a href="/admin_freeboard?p=${i}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage }">
						<a href="/admin_freeboard?p=${end+1}">[다음]</a>
					</c:if>
				</c:if>
				<c:if test="${search != null}">
					<c:if test="${begin > 2}">
						<a href="/admin_freeboard?p=${begin-1}&search=${search}&searchn=${searchn}">[이전]</a>
					</c:if>
					<c:forEach begin="${begin}" end="${end}" var="i">
						<a href="/admin_freeboard?p=${i}&search=${search}&searchn=${searchn}">[${i}]</a>
					</c:forEach>
					<c:if test="${end < totalPage}">
						<a href="/admin_freeboard?p=${end+1}&search=${search}&searchn=${searchn}">[다음]</a>
					</c:if>
				</c:if>
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
			
		<div id="jb-sidebar">
		<br><br>
			<div class="row g-3">				
				<div><a style="width: 180px;" class="btn btn-secondary" href="/adminQnAOnly">Q&A 문의</a></div>
				<div><a style="width: 180px;" class="btn btn-secondary" href="#">충전소 관리</a></div>
				<div><a style="width: 180px;" class="btn btn-secondary" href="/admin_member">사용자 관리</a></div>
				<div><a style="width: 180px;" class="btn btn-secondary" href="#">공지사항 관리</a></div>
				<div><a style="width: 180px;" class="btn btn-outline-secondary" href="/admin_freeboard">자유게시판 관리</a></div>	
				<div><a style="width: 180px;" class="btn btn-secondary" href="/adminReview">리뷰게시판 관리</a></div>
			</div>
		</div>
		
	</div>	
		<%@ include file="../DsBoard/DsLayout/dsFooter.jsp"%>
</body>
</html>