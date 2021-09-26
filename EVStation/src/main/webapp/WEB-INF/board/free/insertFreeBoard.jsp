<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>자유 게시판 작성</title>
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
	<%@ include file="/WEB-INF/layout/HeaderFree.jsp"%>
	
	<main>
		<div id="center">
			<h4>자유 게시판 글쓰기</h4><br>
			<form action="/insertFreeBoard" method="post">
				<table class="table table-borderless border">
					<tr><td><a href="/getFreeBoardList"><small style="color: green">자유 게시판 ></small></a></td></tr>				
					<tr><td><input class="form-control" id="boardtitle" name="boardtitle" placeholder="제목을 입력해 주세요."/></td></tr>
					<tr><td align="center"><textarea id="boardcontent" name="boardcontent"></textarea></td></tr>
					<tr><td align="center"><input class="btn btn-success" id="savebutton" type="submit" value="등록"> </td></tr>
				</table>
			</form>
		</div>
	</main>
	
	<%@ include file="/WEB-INF/layout/Footer.jsp"%>
		
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/naver-smarteditor2/demo/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	$(function(){
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
        	bUseModeChanger : true, 
        	fOnBeforeUnload : function(){
        		}
			}
		});
			
		//전송버튼
		$("#savebutton").click(function(){
			if(!$("#boardtitle").val()){
				alert("제목을 입력해주세요!");
				return false;
			}
			
			//id가 smarteditor인 textarea에 에디터에서 대입
			oEditors.getById["boardcontent"].exec("UPDATE_CONTENTS_FIELD", []);			
			let content = $("#boardcontent").val();
			
			if(content == ""  || content == null || content == '&nbsp;' || content == '<p>&nbsp;</p>' || content == "<p><br></p>")  {
				alert("내용을 입력하세요.");
				oEditors.getById["boardcontent"].exec("FOCUS"); //포커싱
				return false;
			}			
				//폼 submit
				//$("#frm").submit();
		});

	});
</script>
</body>
</html>