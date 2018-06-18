<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-md-4"></div>
		<div class="col-md-4">
			<div class="login-box well">
				<form accept-charset="UTF-8" role="form" id="registerform" method="post" onsubmit="return check()">
					<legend>회원 가입</legend>
					<div style='color: red'>${msg}</div>
					<div class="form-group">
						<label for="email">이메일</label>
						<input type="email" name="email" id="email"
						onblur="confirmId()" class="form-control"
						placeholder="이메일"/>
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
						class="form-control" 
						placeholder="비밀번호"/>
						<input type="password" id="pwconfirm"
						class="form-control"  
						placeholder="비밀번호 확인"/>
						<div id="pwdiv"></div>
					</div>
					<div class="form-group">
						<label for="nickname">별명</label>
						<input type="text" name="nickname" id="nickname"
						class="form-control" placeholder="닉네임은 문자 2자 이상입니다." />
						<div id="nicknamediv"></div>
					</div>
					<div class="form-group" id="btns">
						<input type="submit" value="회원가입" class="btn btn-warning btn-block m-t-md" />
						<input type="button" value="메인으로" class="btn btn-success btn-block m-t-md"
						onclick="javascript:window.location='../'">
					</div>
				</form>
			</div>
		</div>
		<div class="col-md-4"></div>
	</div>
</div>
<style>
#btns > *{
	width: 49%;
	display: inline-block;
	margin-top:5px;
}
</style>
<script>
//이메일 중복검사 통과여부를 저장할 변수
//전송버튼을 눌렀을 때 이 값이 false 면 전송하지 않을것
var emailcheck = false;

//이메일 중복체크 함수
function confirmId(){
	email = document.getElementById("email").value;
	emaildiv = document.getElementById("emaildiv");
	if(email.trim() == ""){
		emaildiv.innerHTML = "이메일을 입력해주세요.";
		emaildiv.style.color = 'red';
		document.getElementById("email").focus();
		emailcheck = false;
	} else {
		$.ajax({
			url:'emailcheck',
			data:{'email':email},
			dataType:'json',
			success:function(data){
				//alert(data);
				if(data.result==true){
					// 이메일이 중복되지 않은 경우
					emailcheck = true;
					emaildiv.innerHTML = "사용 가능한 이메일입니다.";
					emaildiv.style.color = 'blue';
				}else{
					// 이메일이 중복된 경우
					emaildiv.innerHTML = "중복된 이메일입니다.";
					emaildiv.style.color = 'red';
					emailcheck = false;
				}
			}
		});
	}
}

//비밀번호 보이기 버튼
var show = false;
function pwshow(){
	if(show == false){
		document.getElementById("pw").type="text";
		document.getElementById("pwconfirm").type="text";
		document.getElementById("pwshow").classList.remove("btn-success");
		document.getElementById("pwshow").classList.add("btn-danger");
		document.getElementById("pwshow").innerText = "감추기";
		show = true;
	}else if (show == true){
		document.getElementById("pw").type="password";
		document.getElementById("pwconfirm").type="password";
		document.getElementById("pwshow").classList.remove("btn-danger");
		document.getElementById("pwshow").classList.add("btn-success");
		document.getElementById("pwshow").innerText = "보이기";
		show = false;
	}
}

//form에서 submit 했을 때 호출되는 함수
//false를 리턴하면 서버로 전송되지 않음
function check(){
	// emailcheck의 값이 false면 서버로 전송하지 않음
	if(emailcheck == false){
		document.getElementById("emaildiv").innerHTML = "이메일 중복검사를 통과하지 못했습니다.";
		document.getElementById("emaildiv").styel.color = "red";
		return false;
	}
	// 비밀번호에 입력한 값과 비밀번호 확인 란에 입력한 값이 일치하지 않으면 전송하지 않음
	pw = document.getElementById("pw").value;
	pwconfirm = document.getElementById("pwconfirm").value;
	pwdiv = document.getElementById("pwdiv");
	if(pw != pwconfirm){
		document.getElementById("pw").value = "";
		document.getElementById("pwconfirm").value = "";
		pwdiv.style.color = 'red';
		pwdiv.innerHTML = "비밀번호가 일치하지 않습니다!";
		document.getElementById("pw").focus();
		return false;
	}
	// 비밀번호는 숫자, 영문자, 특수문자 1개이상으로 8자 이상
	// 정규식 이용
	p1 = /[0-9]/;
	p2 = /[a-zA-Z]/;
	p3 = /[~!@#$%^&*();:.]/;
	
	if(!p1.test(pw) || !p2.test(pw) || !p3.test(pw) || pw.length<8){
		document.getElementById("pw").value = "";
		document.getElementById("pwconfirm").value = "";
		pwdiv.style.color = 'red';
		pwdiv.innerHTML = 
			"비밀번호는 8자 이상이어야 하고, 숫자, 영문자, 특수문자를 포함해야합니다."
			+"<br>사용 가능한 특수문자: ~!@#$%^&*();:.";
		document.getElementById("pw").focus();
		return false;
	}
	
	// 닉네임은 2자 이상 한글, 영문자, 숫자로 구성
	nickname = document.getElementById("nickname").value;
	nicknamediv = document.getElementById("nicknamediv"); 
	n = /[0-9a-zA-Z가-힣]/;
	if(!n.test(nickname) || nickname.length<2){
		document.getElementById("nickname").focus();
		nicknamediv.style.color="red";
		nicknamediv.innerHTML =
			"닉네임은 2자 이상이어야하고<br>한글, 영문자, 숫자만 사용할 수 있습니다.";
		return false;
	}
}
</script>
<%@ include file="../include/footer.jsp" %>