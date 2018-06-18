<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<div class="row">
	<div class="form-group container col-sm-offset-2 col-sm-8 well">
		<form class="form-horizontal col-sm-12" id="registerform" method="post" onsubmit="return check()">
			<legend><h3 align="center">LUNCH! <small>식당 등록하기</small></h3></legend>
			<div class="form-group" style="text-align:center">
				※ 거리, 맛, 가격대를 기준으로 총점이 매겨지고, 총점에 따라 뽑힐 확률이 조정됩니다! 
			</div>
			<div class="form-group">
				<label for="rstname" class="col-sm-2 control-label">식당 이름</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="rstname" name="rstname" placeholder="이름">
					<div id="namediv"></div>
				</div>
			</div>
			<div class="form-group">
				<label for="foodstyle" class="col-sm-2 control-label">음식 종류</label>
				<div class="col-sm-10">
					<select class="form-control" id="foodstyle" name="foodstyle">
						<option value="한식">한식</option>
						<option value="양식">양식</option>
						<option value="일식">일식</option>
						<option value="중식">중식</option>
						<option value="분식">분식</option>
						<option value="기타">기타</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="distance" class="col-sm-2 control-label">거리</label>
				<div class="col-sm-10">
					<select class="form-control" id="distance" name="distance">
						<option value="5">가까움</option>
						<option value="4">가까운 편</option>
						<option value="3" selected="selected">적당함</option>
						<option value="2">멀지는 않음</option>
						<option value="1">멂</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="tasty" class="col-sm-2 control-label">맛</label>
				<div class="col-sm-10">
					<select class="form-control" id="tasty" name="tasty">
						<option value="5">헐 대박 존맛탱</option>
						<option value="4">오 나쁘지 않은데?</option>
						<option value="3" selected="selected">흠 그냥 그렇네</option>
						<option value="2">음? 이건 무슨맛..?</option>
						<option value="1">으.. 노맛</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="price" class="col-sm-2 control-label">가격대</label>
				<div class="col-sm-10">
					<select class="form-control" id="price" name="price">
						<option value="5">오 싸다!</option>
						<option value="4">싼편</option>
						<option value="3" selected="selected">적당적당</option>
						<option value="2">비싸긴 하네</option>
						<option value="1">헐 넘 비쌈</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="description" class="col-sm-2 control-label">설명</label>
				<div class="col-sm-10">
					<textarea name="description" class="form-control" rows="3" placeholder="식당의 설명을 적어주세요."></textarea>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-12" style="text-align:center; margin-top:10px;">
					<input type="button" onclick="check()" class="btn btn-success" value="식당 등록하기"/>
					<input type="reset" class="btn btn-warning" value="비우기"/>
				</div>
			</div>
			<input type="hidden" name="membercode" value="${member.membercode }"/>
		</form>
	</div>
</div>
<!-- 메시지 대화상자 -->
<div id="dialog-message" title="" style="display:none">
	<p>
		<span class="ui-icon ui-icon-circle-check"
			style="float: left; margin: 0 7px 50px 0;"></span>
		<span id="msg">등록되었습니다.</span>
	</p>
</div>
<script>
document.getElementById("rstname").focus();
function check(){
rstname = document.getElementById("rstname").value.trim();
	// console.log(rstname)
	if(rstname.length == 0){
		document.getElementById("namediv").innerHTML = "식당 이름을 입력하세요.";
		document.getElementById("namediv").style = "color:red"
		document.getElementById("rstname").value = "";
		document.getElementById("rstname").focus();
		return false;
	}else{
		document.getElementById("namediv").innerHTML = "";
		$("#dialog-message").dialog({
			modal : true,
			buttons : {
				"확인" : function() {
					$(this).dialog("close");
					document.getElementById("registerform").submit();
				}
			}
		});
	}
}
</script>
<%@ include file="../include/footer.jsp" %>