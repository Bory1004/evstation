<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/DsBoard/DsLayout/dsHeaderNormal.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style>
#center {
	width: 800px;
	margin-left: auto;
	margin-right: auto;
}
a {
	text-decoration-line: none;
}
</style>
<meta charset="UTF-8">
<title>충전소 수정</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container" style="text-align: center;">
	
				
				
	 	<h1>${charge.stname }휴게소</h1>
	 			<form action="/updateChargeComplete" method="post" >
	 				<input type="hidden" name="stnum" value="${stnum}">
	 				<input type="hidden" name="stname" value="${stname}">
	 				
	 	
	 	<table class="table table-bordered border-secondary"  style="text-align: center;">
	<%-- <tr><td class="table-secondary text-center">충전소이름</td><td>${charge.st_name }</td></tr> --%>
	<tr><td class="table-secondary text-center">주소(도로명)</td><td><input class="form-control" name="staddress1" id="staddress1" value="${staddress1}" ></td></tr>
	<tr><td class="table-secondary text-center">주소(지번)</td><td><input class="form-control" name="staddress2" id="staddress2" value="${staddress2}" ></td></tr>
	<tr><td class="table-secondary text-center">휴무일</td><td><input class="form-control" name="stclosedday" id="stclosedday" value="${stclosedday}" ></td></tr>
	<tr><td class="table-secondary text-center">완속충전</td><td><input class="form-control" name="stslowcharge" id="stslowcharge" value="${stslowcharge}" ></td></tr>
	<tr><td class="table-secondary text-center">완속충전대수</td><td><input class="form-control" name="stslowcharge_num" id="stslowcharge_num" value="${stslowcharge_num}" ></td></tr>
	<tr><td class="table-secondary text-center">급속충전</td><td><input class="form-control" name="stfastcharge" id="stfastcharge" value="${stfastcharge}" ></td></tr>
	<tr><td class="table-secondary text-center">급속충전대수</td><td><input class="form-control" name="stfastcharge_num" id="stfastcharge_num" value="${stfastcharge_num}" ></td></tr>
	<tr><td class="table-secondary text-center">충전타입</td><td><input class="form-control" name="stfastcharge_type" id="stfastcharge_type" value="${stfastcharge_type}" ></td></tr>
	<tr><td class="table-secondary text-center">오픈</td><td><input class="form-control" name="sttime" id="sttime" value="${sttime}" ></td></tr>
	<tr><td class="table-secondary text-center">마감</td><td><input class="form-control" name="stclosetime" id="stclosetime" value="${stclosetime}" ></td></tr>
	<tr><td class="table-secondary text-center">주차료</td><td><input class="form-control" name="stpark" id="stpark" value="${stpark}" ></td></tr>
	<tr><td class="table-secondary text-center">재공기관</td><td><input class="form-control" name="stagency" id="stagency" value="${stagency}" ></td></tr>
</table>
<input class="btn btn-outline-secondary" type="submit" id="savebutton" value="수정">
	</form>
</div>
<%@ include file="/WEB-INF/DsBoard/DsLayout/dsFooter.jsp"%>
</body>
</html>