<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="/WEB-INF/DsBoard/DsLayout/dsHeaderNormal.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>충전소 추가</title>
<style>
	div.form-text {color: red;}
	#star {color: red;}
	a {text-decoration-line: none;}
</style>
</head>
<body>
<form id="charge"  action="/insertChargeComplete" method="post">
<div class="container d-flex justify-content-center align-items-center">		
		<div id="content">		
				<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
					<label for="stnum" class="col-form-label"><span id="star">*</span>충전소 번호</label>
					<input type="text" id="stnum" name="stnum" class="form-control" size="100"  aria-describedby="stnum_msg">
					<div id="stnum_msg" class="form-text"></div>
				</div>
			</div>
			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
					<label for="stname" class="col-form-label"><span id="star">*</span>충전소 이름</label>
					<input type="text" id="stname" name="stname" class="form-control" size="100"  aria-describedby="stname_msg">
					<div id="stname_msg" class="form-text"></div>
				</div>
			</div>
			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
					<label for="staddress1" class="col-form-label"><span id="star">*</span>주소(도로명)</label>
					<input type="text" id="staddress1" name="staddress1" class="form-control" size="100"  aria-describedby="staddress1_msg">
					<div id="staddress1_msg" class="form-text"></div>
				</div>
			</div>
			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
					<label for="st_address2	" class="col-form-label"><span id="star">*</span>주소(지번)</label>
					<input type="text" id="st_address2	" name="st_address2	" class="form-control" size="100"  aria-describedby="st_address2_msg">
					<div id="st_address2_msg" class="form-text"></div>
				</div>
			</div>
			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
					<label for="stclosedday" class="col-form-label"><span id="star">*</span>휴무일</label>
					<input type="text" id="stclosedday" name="stclosedday" class="form-control" size="100"  aria-describedby="stclosedday_msg">
					<div id="stclosedday_msg" class="form-text"></div>
				</div>
			</div>
			
		<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
					<label for="stfastchargetype" class="col-form-label"><span id="star">*</span>충전타입</label>
					<input type="text" id="stfastchargetype" name="stfastchargetype" class="form-control" size="100"  aria-describedby="stfastchargetype_msg">
					<div id="stfastchargetype_msg" class="form-text"></div>
				</div>
			</div>
			
			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
					<label for="sttime" class="col-form-label"><span id="star">*</span>오픈시간/마감시간</label>
						<div class="input-group">
					<input type="text" id="sttime" name="sttime" class="form-control" size="100"  aria-describedby="sttime_msg">
					<div id="sttime_msg" class="form-text"></div>
					<input type="text" id="stclosetime" name="stclosetime" class="form-control" size="100"  aria-describedby="stclosetime_msg">
					<div id="stclosetime_msg" class="form-text"></div>
				</div>
				</div>
			</div>
			
			
			<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
					<label for="stagency" class="col-form-label"><span id="star">*</span>제공기관</label>
					<input type="text" id="stagency" name="stagency" class="form-control" size="100"  aria-describedby="stagency_msg">
					<div id="stagency_msg" class="form-text"></div>
				</div>
			</div>
			
				<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
					<label for="stlatitude" class="col-form-label"><span id="star">*</span>위도/경도</label>
					<div class="input-group">
					<input type="text" id="stlatitude" name="stlatitude" class="form-control" size="100"  aria-describedby="stlatitude_msg">
					<div id="stlatitude_msg" class="form-text"></div>
					<input type="text" id="stlongitude" name="stlongitude" class="form-control" size="100"  aria-describedby="stlongitude_msg">
					<div id="stlongitude_msg" class="form-text"></div>
					</div>
				</div>
			</div>
			
				<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
				<label for="memcar" class="col-form-label"><span id="star">*</span>완속충전가능유무/완속충전대수</label>
				<div class="input-group">
					<select class="form-select" id="stslowcharge" name="stslowcharge">
						<option value="Y">Y</option>
						<option value="N">N</option>
					</select>
					<select class="form-select" id="stslowchargenum" name="stslowchargenum">
  						<option value="없음">없음</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
				</div>
				</div>
			</div>
			
				<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6">
				<label for="memcar" class="col-form-label"><span id="star">*</span>급속충전가능유무/급속충전대수</label>
				<div class="input-group">
					<select class="form-select" id="stfastcharge" name="stfastcharge">
						<option value="Y">Y</option>
						<option value="N">N</option>
					</select>
					<select class="form-select" id="stfastchargenum" name="stfastchargenum">
  						<option value="없음">없음</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
				</div>
				</div>
			</div>
			
			
	
	</div>
	</div>
	
	<div class="row mb-3 justify-content-center align-items-center">
				<div class="col-md-6" align="center">
  				<input class="btn btn-success"   type="submit" value="충전소 추가">
  				</div>
  	</div>		  
  
 </form>
 
 
  <%@ include file="/WEB-INF/DsBoard/DsLayout/dsFooter.jsp"%>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	$("#charge").submit(function(){
		if(!$("#stnum").val()){									
			$("#stnum_msg").text("충전소 번호를 입력해주세요.");
			$("#stnum").focus();
			return false;
		}else{
			$("#stnum_msg").text("");
			
		}
	
		if(!$("#stname").val()){									
			$("#stname_msg").text("충전소 이름을 입력해주세요.");
			$("#stname").focus();
			return false;
		}else{
			$("#stname_msg").text("");
			
		}
		if(!$("#stlatitude").val()){									
			$("#stlatitude_msg").text("위도를 입력해주세요.");
			$("#stlatitude").focus();
			return false;
		}else{
			$("#stlatitude_msg").text("");
		}
		if(!$("#stlongitude").val()){									
			$("#stlongitude_msg").text("경도를 입력해주세요.");
			$("#stlongitude").focus();
			return false;
		}else{
			$("#stlongitude_msg").text("");
			
		}
	});		
	
	
	</script>
  </body>
</html>