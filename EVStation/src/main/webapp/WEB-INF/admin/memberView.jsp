<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../DsBoard/DsLayout/dsHeaderNormal.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
#jb-container {
	width: 940px;
	margin: 0px auto;
}

#jb-content {
	width: 700px;
	padding: 10px;
	margin-bottom: 20px;
	float: right;
	/* border: 1px solid #bcbcbc; */
}

#jb-sidebar {
	width: 200px;
	padding: 10px;
	margin-bottom: 20px;
	float: left;
}
.box {
    width: 150px;
    height: 150px; 
    border-radius: 70%;
    overflow: hidden;
}
.profile {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
</style>
</head>
<body>
<div id="jb-container">
	<div id="jb-content">
		<h4>사용자 관리</h4>
		<a href="/admin_member"><small class="text-muted">사용자 관리 전체 목록 ></small></a>
		<div align="center">
			<div id="preview" class="box">								
				<img id="profile_image" class="profile" src="${list.memphoto}">																			
			</div>
		</div>
		<table style="text-align: center" class="table table-hover">
			<tr><td>아이디</td><td>${list.id}</td></tr>
			<tr><td>이름</td><td>${list.name}</td></tr>
			<tr><td>이메일</td><td>${list.mememail}</td></tr>
			<tr><td>휴대전화</td><td>${list.memphone}</td></tr>
			<tr><td>주소</td><td>${list.memaddress} ${list.memaddressdetail}</td></tr>
			<tr><td>생년월일</td><td>${list.membirth}</td></tr>
			<tr><td>차종</td><td>${list.memcar}</td></tr>
			<tr><td>충전타입</td><td>${list.memcharge}</td></tr>
			<tr><td>가입일</td><td><fmt:formatDate value="${list.memdate}" pattern="yyyy-MM-dd" /></td></tr>
		</table>
		<c:if test="${list.id != 'admin'}">
			<div align="right">
				<a class="btn btn-outline-secondary" href="/admin_member_deleteOne/${list.memnum}" onclick='return confirm("정말 탈퇴시키겠습니까?");'>탈퇴</a>
			</div>
		</c:if>
	</div>
			
		<div id="jb-sidebar">
		<br><br>
			<div class="row g-3">				
				<div><a style="width: 180px;" class="btn btn-secondary" href="/adminQnAOnly">Q&A 문의</a></div>
				<div><a style="width: 180px;" class="btn btn-secondary" href="#">충전소 관리</a></div>
				<div><a style="width: 180px;" class="btn btn-outline-secondary" href="/admin_member">사용자 관리</a></div>
				<div><a style="width: 180px;" class="btn btn-secondary" href="/ay/admin">공지사항 관리</a></div>
				<div><a style="width: 180px;" class="btn btn-secondary" href="/admin_freeboard">자유게시판 관리</a></div>	
				<div><a style="width: 180px;" class="btn btn-secondary" href="/adminReview">리뷰게시판 관리</a></div>
			</div>
		</div>
		
	</div>
		<%@ include file="WEB-INF/layout/Footer.jsp"%>
</body>
</html>