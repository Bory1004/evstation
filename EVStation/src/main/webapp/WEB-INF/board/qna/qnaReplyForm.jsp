<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
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
<head>
<title>QnA 답변</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
</style>
</head>
<body>
<%@ include file="/WEB-INF/layout/HeaderQnA.jsp"%>

<div id="center">
	<h4>QnA 게시판 답변달기</h4>
		<br>
	<form action="/qnaReply" method="post">
		<input type="hidden" name="boardref" value="${boardref }"> 
		<input type="hidden" name="boardrestep" value="${boardrestep }"> 
		<input type="hidden" name="boardrelevel" value="${boardrelevel }">
		<input type="hidden" name="boardmemnum" value="${boardmemnum}">
		
		<table class="table table-borderless border">
				<tr>
					<td><a href="/qnaList"><small style="color: green">QnA 게시판 ></small></a></td>
				</tr>
								<tr>
					<td><input class="form-control" id="boardtitle" name="boardtitle" placeholder="답변을 입력해 주세요." /></td>
				</tr>
				<tr>
					<td align="center"><textarea id="boardcontent" name="boardcontent"></textarea></td>
				</tr>
				<tr>
					<td align="center"><input class="btn btn-success" id="savebutton" type="submit" value="답글등록"></td>
				</tr>
			</table>
		</form>
</div>
<%@ include file="/WEB-INF/layout/Footer.jsp"%>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/naver-smarteditor2/demo/js/service/HuskyEZCreator.js" charset="utf-8"></script>
	<script type="text/javascript">
		$(function(){
			let oEditors = [];
	
			nhn.husky.EZCreator.createInIFrame({
    		oAppRef: oEditors,
    		elPlaceHolder: "boardcontent",  //textarea ID
      		sSkinURI: "<%=request.getContextPath()%>/resources/naver-smarteditor2/demo/SmartEditor2Skin.html",
  				//위에는 skin 경로
						fCreator : "createSEditor2",
						htParams : {
							// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
							bUseToolbar : true,
							// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
							bUseVerticalResizer : true,
							// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
							bUseModeChanger : true,
							fOnBeforeUnload : function() {
							}
						}
					});

			//전송버튼
			$("#savebutton").click(
					function() {
						if (!$("#boardtitle").val()) {
							alert("제목을 입력해주세요!");
							return false;
						}

						//id가 smarteditor인 textarea에 에디터에서 대입
						oEditors.getById["boardcontent"].exec(
								"UPDATE_CONTENTS_FIELD", []);
						let content = $("#boardcontent").val();

						if (content == "" || content == null
								|| content == '&nbsp;'
								|| content == '<p>&nbsp;</p>'
								|| content == "<p><br></p>") {
							alert("내용을 입력하세요.");
							oEditors.getById["boardcontent"].exec("FOCUS"); //포커싱
							return false;
						}
						//폼 submit
						//$("#frm").submit();
					})
		});
	</script>
</body>
</html>