<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-md-4"></div>
		<div class="col-md-4">
			<div class="login-box well">
				<form accept-charset="UTF-8" role="form" id="registerform" method="post" onsubmit="return check()">
					<legend>회원 정보 수정</legend>
					<div style='color: red'>${msg}</div>
					<div class="form-group">
						<label for="email">이메일</label>
						<input type="email" name="email" id="email" class="form-control"
						value="${member.email }" readonly="readonly"/>
					</div>
					<div class="form-group">
						<label for="pw">비밀번호</label>
						<span style="display:inline-block; float:right; text-align:center">
							<a id="pwshow" class="btn btn-success btn-xs" href="javascript:pwshow()">보이기</a>
						</span>
						<input type="password" name="pw" id="pw"
						class="form-control" placeholder="기존 비밀번호"/>
					</div>
					<div class="form-group">
						<input type="password" name="newpw" id="newpw"
						class="form-control" 
						placeholder="새 비밀번호"/>
						<input type="password" id="pwconfirm"
						class="form-control"  
						placeholder="비밀번호 확인"/>
						<div id="pwdiv"></div>
					</div>
					<div class="form-group">
						<label for="nickname">별명</label>
						<input type="text" name="nickname" id="nickname"
						class="form-control" value="${member.nickname }" />
						<div id="nicknamediv"></div>
					</div>
					<div class="form-group">
						<input type="submit" value="회원정보 수정" class="btn btn-warning btn-block m-t-md" />
						<input type="button" value="메인으로" class="btn btn-success btn-block m-t-md"
						onclick="javascript:window.location='../'">
					</div>
					<script>
						document.getElementById("pw").focus();
					</script>
				</form>
			</div>
		</div>
		<div class="col-md-4"></div>
	</div>
</div>
<script>
//비밀번호 보이기 버튼
var show = false;
function pwshow(){
	if(show == false){
		document.getElementById("pw").type="text";
		document.getElementById("newpw").type="text";
		document.getElementById("pwconfirm").type="text";
		document.getElementById("pwshow").classList.remove("btn-success");
		document.getElementById("pwshow").classList.add("btn-danger");
		document.getElementById("pwshow").innerText = "감추기";
		show = true;
	}else if (show == true){
		document.getElementById("pw").type="password";
		document.getElementById("newpw").type="password";
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
	// 기존비밀번호가 맞지 않으면 전송하지 않음
	pw = document.getElementById("pw").value;
	$.ajax({
		url:"pwcheck",
		data: {
			"pw" : pw,
			"email" : "${member.email}"
		},
		dataType : "json",
		success : function(data){
			if(data.result == false){
				document.getElementById("pw").value = "";
				pwdiv.style.color = 'red';
				pwdiv.innerHTML = "기존 비밀번호가 틀렸습니다!";
				document.getElementById("pw").focus();
				return false;
			}
		}
	});
	
	// 비밀번호에 입력한 값과 비밀번호 확인 란에 입력한 값이 일치하지 않으면 전송하지 않음
	newpw = document.getElementById("newpw").value;
	pwconfirm = document.getElementById("pwconfirm").value;
	pwdiv = document.getElementById("pwdiv");
	if(newpw != pwconfirm){
		document.getElementById("newpw").value = "";
		document.getElementById("pwconfirm").value = "";
		pwdiv.style.color = 'red';
		pwdiv.innerHTML = "비밀번호가 일치하지 않습니다!";
		document.getElementById("newpw").focus();
		return false;
	}
	// 비밀번호는 숫자, 영문자, 특수문자 1개이상으로 8자 이상
	// 정규식 이용
	p1 = /[0-9]/;
	p2 = /[a-zA-Z]/;
	p3 = /[~!@#$%^&*();:.]/;
	
	if(!p1.test(newpw) || !p2.test(newpw) || !p3.test(newpw) || newpw.length<8){
		document.getElementById("newpw").value = "";
		document.getElementById("pwconfirm").value = "";
		pwdiv.style.color = 'red';
		pwdiv.innerHTML = 
			"비밀번호는 8자 이상이어야 하고, 숫자, 영문자, 특수문자를 포함해야합니다."
			+"<br>사용 가능한 특수문자: ~!@#$%^&*();:.";
		document.getElementById("newpw").focus();
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