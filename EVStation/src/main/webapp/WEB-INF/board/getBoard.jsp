<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>글 상세보기</title>
</head>
<body>

<pre>
<input type="button" id="recom" value="추 천">

제목 ${board.title }         

작성자 ${board.writer }

내용${board.content }

등록일<fmt:formatDate value="${board.createDate }" pattern="MM.dd"/>

조회수${board.cnt }

추천수<div id="recom_div">${board.recom }</div>

<a href="/updateForm/${board.num }">수 정</a>
<a href="/delete/${board.num }">삭 제</a>
<a href="/getBoardList">목록으로</a>
</pre>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function(){
	$("#recom").click(function(){
		let num = ${board.num}; 
		let url = "/upRecom/"+num
	
		$.ajax({
			url : url
		}).done(function(data){
		 	var recom_cnt = document.getElementById("recom_div").innerHTML;
			document.getElementById("recom_div").innerHTML = Number(recom_cnt) + 1;
		}).fail(function(jqXHR, textStatus, errorThrown){
			console.log("error");
		});
		
	})
});
</script>

</body>
</html>