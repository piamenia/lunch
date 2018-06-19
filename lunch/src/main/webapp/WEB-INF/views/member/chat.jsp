<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<div class="row">
	<div class="col-md-offset-1 col-md-6">
		<label for="chatwindow">채팅 화면</label>
		<div><textarea class="form-control" id="chatwindow" rows="15" readonly style="resize:none; overflow:auto"></textarea></div>
		<div>
			<div class="input-group">
				<input type="text" class="form-control" id="msg" placeholder="내용을 입력하세요.">
				<span class="input-group-btn">
					<button class="btn btn-default" type="button" id="send">보내기</button>
				</span>
			</div>
		</div>
	</div>
	<div class="col-md-4">
		<label for="clients">접속자</label>
		<textarea class="form-control" id="clients" rows="16" readonly style="resize:none; overflow:auto"></textarea>
	</div>
</div>
<script>
// 알림 기능 허용여부 확인
if(window.Notification){
	Notification.requestPermission();
}
// 웹소켓에 연결하기
websocket = new WebSocket("ws://182.222.11.113:8080/lunch/chat-ws");
//websocket = new WebSocket("ws://localhost:8989/lunch/chat-ws");
//websocket = new WebSocket("ws://192.168.0.218:8989/lunch/chat-ws");
// 웹소켓에 이벤트가 발생했을 때 호출될 함수 등록
websocket.onopen = onOpen;
websocket.onmessage = onMessage;

nickname = '${member.nickname}';
msg = document.getElementById("msg");

// 보내기 버튼을 클릭하면 호출되는 함수
document.getElementById("send").addEventListener("click",function(){
	send();
})
// 엔터키를 눌러도 메시지 전송
msg.onkeydown = function(){
	if(event.keyCode==13){
		send();
	}
}
function send(){
	websocket.send(nickname+" : "+msg.value);
	msg.value = "";
	msg.focus;
}
function onOpen(){
	// 접속자 화면에 표시하기 위해 보내는 메시지
	// 다른 모든 메시지는 nickname으로 시작하기 때문에 nickname으로 하지 못하는 텍스트로 시작하는 메시지로 전송
	// nickname은 영문, 숫자, 한글만 사용
	websocket.send("!!"+nickname);
	// 접속했다고 알리는 메시지
	websocket.send(nickname+" 님이 입장하셨습니다.");
}
function onMessage(e){
	data = e.data;
	clients = document.getElementById("clients");
	chatwindow = document.getElementById("chatwindow");
	// 메시지 구분
	// 접속자 추가 메시지
	if(data.indexOf("!!") >= 0){
		//clients.value = "";
		data = data.split("!!")[1];
		//alert(data)
		if(clients.value.indexOf(data)<0){
			clients.value = clients.value + data + "\n";
		}
	}
	// 접속자 제거 메시지
	else if(data.indexOf("@@") >= 0){
		//console.log(data)
		data = data.split("@@")[1];
		//alert(data);
		clientslist = clients.value;
		//console.log(clientslist)
		ar = clientslist.split("\n");
		//console.log(ar)
		for(i=0;i<ar.length;i++){
			if(ar[i]==data){
				//console.log(data)
				//console.log(ar[i])
				ar.splice(i)
			}
		}
		//console.log(ar)
		clientslist = "";
		for(i=0;i<ar.length;i++){
			clientslist += ar[i] +'\n';
		}
		clients.value = clientslist;
	}
	// 채팅 메시지
	else{
		chatwindow.value = chatwindow.value + data + "\n";
		chatwindow.scrollTop = chatwindow.scrollHeight;
		if(document.hidden){
			notify();
		}
	}
}
// 메시지가 오면 알림 띄워주기
function notify(){
	if(Notification.permission != 'granted'){
		alert('알림이 꺼져있습니다.');
	}else{
		notification = new Notification('LUNCH! 채팅방', {
			icon: "http://chittagongit.com//images/notification-icon/notification-icon-21.jpg",
			body: "새로운 메시지가 있습니다."
		});
		
		// 알림을 클릭하면 알림이 뜬 페이지를 보여주고 알림 닫기
		notification.onclick = function(){
			$(window).focus();
			notification.close();
		};
		
		// 아무것도 하지 않으면 5초후에 알림 닫기
		setTimeout(function(){
			notification.close();
		},5000);
	}
}
// 페이지를 벗어나면 웹소켓에서 연결해제
$(window).on("beforeunload", function(){
	websocket.send(nickname+" 님이 퇴장하셨습니다.");
	websocket.close();
});
</script>
<%@ include file="../include/footer.jsp" %>