<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-md-4"></div>
		<div class="col-md-4">
			<div class="login-box well">
				<form accept-charset="UTF-8" role="form" method="post" action="login">
					<legend>로그인</legend>
					<div style='color: red'>${msg}</div>
					<div class="form-group">
						<label for="email">이메일</label>
						<input type="email" name="email" id="email" required="required"
						placeholder="이메일을 입력하세요" class="form-control" />
						<div id="emaildiv"></div>
						<script>
							document.getElementById("email").focus();
						</script>
					</div>
					<div class="form-group">
						<label for="pw">비밀번호</label>
						<span style="display:inline-block; float:right; text-align:center">
							<a id="pwshow" class="btn btn-success btn-xs" href="javascript:pwshow()">보이기</a>
						</span>
						<input type="password" name="pw" id="pw"
						placeholder="비밀번호를 입력하세요" class="form-control""/>
					</div>
					<div class="form-group" id="btns">
						<input type="submit"
							class="btn btn-primary btn-login-submit btn-block m-t-md"
							value="로그인"/>
						<a href="register" class="btn btn-warning btn-block m-t-md">회원가입</a>
						<a href="javascript:findpw()" class="btn btn-danger btn-block m-t-md">비밀번호 찾기</a>
						<a href="../" class="btn btn-success btn-block m-t-md">메인으로</a>
					</div>
				</form>
			</div>
		</div>
		<div class="col-md-4"></div>
	</div>
</div>
<style>
#btns > * {
	width : 49%;
	display : inline-block;
	margin-top : 5px;
}
</style>
<script>
// 비밀번호 보이기 버튼
var show = false;
function pwshow(){
	if(show == false){
		document.getElementById("pw").type="text";
		document.getElementById("pwshow").classList.remove("btn-success");
		document.getElementById("pwshow").classList.add("btn-danger");
		document.getElementById("pwshow").innerText = "감추기";
		show = true;
	}else if (show == true){
		document.getElementById("pw").type="password";
		document.getElementById("pwshow").classList.remove("btn-danger");
		document.getElementById("pwshow").classList.add("btn-success");
		document.getElementById("pwshow").innerText = "보이기";
		show = false;
	}
}
// 비밀번호찾기를 누르면 호출되는 함수
function findpw(){
	email = document.getElementById("email").value;
	emaildiv = document.getElementById("emaildiv");
	if(email.trim() == ""){
		emaildiv.innerHTML = "이메일을 입력해주세요.";
		emaildiv.style.color = 'red';
		document.getElementById("email").focus();
	} else {
		$.ajax({
			url:'emailcheck',
			data:{'email':email},
			dataType:'json',
			success:function(data){
				//alert(data);
				if(data.result==true){
					// 이메일이 존재하지 않는 경우
					emaildiv.innerHTML = "존재하지 않는 이메일입니다.";
					emaildiv.style.color = 'red';
				}else{
					// 이메일이 존재하는 경우
					// 이메일 보내기는 시간이 오래걸리기 때문에 대화창 띄워주기
					$("#dialog-message").dialog({modal : true});
					$(location).attr("href","findpw?email="+email);
				}
			}
		});
	}
}
</script>
<div id="dialog-message" title="" style="display:none">
	<p>
		<span class="ui-icon ui-icon-circle-check"
			style="float: left; margin: 0 7px 50px 0;"></span> 잠시만 기다려주세요...
	</p>
</div>
<%@ include file="../include/footer.jsp" %>