<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html; charset=UTF-8"%>

	<c:if test="${list.size() == 0  }"> <!-- ${empty list}도 가능하다 --> 
		 알람이 없습니다.
	</c:if>
<c:forEach items="${list}" var="alarm">
		
		<c:if test="${alarm.alatype ==2 }"> <!-- 댓글관련 알람  -->
		<div id="${alarm.alanum}">
			<span style="float: left;"><a  href="#getProfile" onclick="getProfile(${alarm.alafromid})">아이디</a></span><br> <span
				style="float: left;">님이 <a href="content/${alarm.boardnum}">답글</a>을 달았습니다. <img style="cursor:pointer;"src="/img/xbutton.png"
				onclick="delAlarm(${alarm.alanum})" width="10" height="10"></span> <br>
		</div>
		</c:if>
		<c:if test="${alarm.alatype == 1}"> <!-- 메일관련 알람 -->
		<div id="${alarm.alanum}">
			<span style="float: left;">${id}</span><br> <span
				style="float: left;">님에게 메일이 도착했습니다.</span> <br>
		</div>
		</c:if>
</c:forEach>