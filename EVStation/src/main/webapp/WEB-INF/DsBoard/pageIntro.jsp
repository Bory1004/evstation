<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="DsLayout/dsHeaderPage.jsp"%>
<!DOCTYPE HTML>

<html>
	<head>
	<style>
	#page{
	margin : auto;
	width : 70%;
    height: 60%;
		display:flex;
		background-color :  #e9e9e9;
	}
	.imgBox{
	width : 55%;
	background: center / cover no-repeat url("images/evst1.jpg");
	}
.content{
  position: relative;
}
#txt{
	padding-top : 10px;
}
#textBox{
	width : 45%;
	margin: 50px;
}
h2 { text-align: center; }


</style>
	</head>
	<body>

		<!-- One -->
								<h2 class="text-muted"><b>전기차충전소 소개</b></h2><br>
		
				<div id="page">
				<div id="textBox">
						<p>&nbsp;이 웹사이트는 전국에 설치한 전기차 충전기에 대하여 전기차 사용자에게 <br/>
							<span style="color: blue;"><b>충전기의 위치 및 상태</b></span>를 안내합니다.<br><br>
							&nbsp;전기차 사용자가 충전시에 겪는 어려움에 대하여</br>
							&nbsp;<span style="color: blue;"><b>전화,홈페이지,앱</b></span>을 통하여 안내합니다.<br><br>
							&nbsp;사용자의 의견을 수렴하고 적절히 반영하여 더 나은 전기차 사용환경을 만들기 위해 노력합니다.<br><br>
							&nbsp;충전기에 대하여 IoT통신으로 충전기 상태를 확인하고 충전기가 고장이 없도록 관리합니다.<br><br>
							&nbsp;전기차와 관련한 보급정책 등에 대한 정보를 제공합니다.<br><br>
						  </p>
				</div>
				<div class="imgBox"></div>
				</div>
			
<%@ include file="DsLayout/dsFooter.jsp"%>
	</body>
</html>