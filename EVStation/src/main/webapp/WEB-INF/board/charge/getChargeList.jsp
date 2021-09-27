<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>충전소목록</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
	<%@ include file="/WEB-INF/layout/HeaderCharge.jsp"%>

         

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