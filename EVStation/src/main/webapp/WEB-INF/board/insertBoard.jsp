<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>글 작성</title>
<!-- <style>
	.orange{background-color: orange;}
	table{border-collapse : collapse;}
</style> -->

<style type="text/css">
	table{ border-collapse : collapse;}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/naver-smarteditor2/demo/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
<%-- $(document).ready(function(){
	let oEditors = [];
	
	nhn.husky.EZCreator.createInIFrame({
    	oAppRef: oEditors,
    	elPlaceHolder: "boardcontent",  //textarea ID
    	sSkinURI: "<%= request.getContextPath() %>/resources/naver-smarteditor2/demo/SmartEditor2Skin.html",  //skin경로
    	fCreator: "createSEditor2",
    	htParams : {
       		// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
        	bUseToolbar : true,             
        	// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
        	bUseVerticalResizer : true,     
        	// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
        	bUseModeChanger : false, 
        	fOnBeforeUnload : function(){
        	}
		}
	});
}); --%>
</script>
</head>
<body>
<form method="post">
	<table border="1">
		<tr><td class="orange">제목</td><td><input name="boardtitle"/></td></tr>
		<tr><td class="orange">작성자</td><td>${member.id}</td></tr>
		<tr><td class="orange">내용</td><td><textarea id="boardcontent" name="boardcontent" cols="40" rows="10"></textarea></td></tr>
		<tr><td colspan="2" align="center"><input type="submit" value="새글 등록"> </td></tr>
	</table>
</form>
</body>
</html>