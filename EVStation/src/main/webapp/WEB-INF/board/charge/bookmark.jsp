<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
 <%@ include file="/WEB-INF/layout/HeaderNormal.jsp"%>
<!DOCTYPE html>
<html>
<head>

<title> 즐겨찾기</title>
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
		var url = "/deleteBookmarkChk";
		var arrStnum = new Array();
		var list = $("input[name='ChkBxRow']"); // 모든 체크박스 값을 list에 정의 
		for (var i = 0; i < list.length; i++) {
			if (list[i].checked) { //해당값이 체크되어 있다면
				arrStnum.push(list[i].value); //value값 리스트에
				}
			}
		if (arrStnum.length == 0) {
			alert("선택 항목이 없습니다");
		} else {
			$.ajax({
				url : url, //전송 URL
				type : 'POST', //POST방식
				traditional : true,
				data : {
					"arrStnum" : arrStnum,
				},
				success : function(adata) {
					alert("삭제성공");
					location.replace("/bookmark") //지정 페이지로 새로고침

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
	margin-right: 28%;
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
	<table style="text-align: center" class="table table-hover caption-top">
			<thead class="table-light">
			<tr>
				<th><input type="checkbox" name="ChkBxAll" id="ChkBxAll;"></th>
				<th>No.</th>
				<th>충전소이름</th>
				<th>주소</th>
				<th>휴무일</th>
			</tr>
		</thead>
		
		<tbody class="text-center">
			
			<c:forEach items="${blist}" var="charge">
				<tr>
					<td><input type="checkbox" name="ChkBxRow" value="${charge.stnum}">
					<td style="width: 8%">${charge.stnum}</td>
					<td style="width: 30%"><a href="/list/${charge.stnum}">${charge.stname}</a></td>
					<c:if test="${charge.staddress1!=null}"><td style="width: 50%">${charge.staddress1}</td></c:if>
					<c:if test="${charge.staddress1==null}"><td style="width: 50%">${charge.staddress2}</td></c:if>
					<td style="width: 12%">${charge.stclosedday}</td>
				</tr>	
			</c:forEach>
		</tbody>	
	</table>
		<button type="button" class="btn btn-outline-secondary btn-sm" onclick="deleteValue();">삭제</button>
		<div id="page">
						<c:if test="${begin > 2}">
							<a href="/bookmark?p=${begin-1}">[이전]</a>
						</c:if>
						<c:forEach begin="${begin}" end="${end}" var="i">
							<a href="/bookmark?p=${i}">[${i}]</a>
						</c:forEach>
						<c:if test="${end < totalPage}">               
							<a href="/bookmark?p=${end+1}">[다음]</a>
						</c:if>
		</div>
</div>		
		
			<div class="btn-group-vertical btn-group-md" role="group" aria-label="Basic example" style="width: 8%;">
				<button type="button" class="btn btn-secondary">개인정보수정</button>
				<br>
				<button type="button" class="btn btn-secondary">내가 쓴 글</button>
				<br>
				<button type="button" class="btn btn-outline-secondary">즐겨찾기</button>
				<br>
				<button type="button" class="btn btn-secondary" onclick="window.open('http://localhost:8088/withdrawForm','new','scrollbars=no,width=430,height=400,top=100,left=100')">회원탈퇴</button>
				<br>
			</div>
		
		
	
	
	
<%@ include file="/WEB-INF/layout/Footer.jsp"%>
	
	
</body>
</html>