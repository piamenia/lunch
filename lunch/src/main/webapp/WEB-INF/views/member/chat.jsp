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
websocket = new WebSocket("ws://182.222.11.113:8080/lunch/chat-ws");
//websocket = new WebSocket("ws://localhost:8989/lunch/chat-ws");
// 웹소켓에 이벤트가 발생헀을 때 호출될 함수 등록
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
	websocket.send(nickname+" 님이 입장하셨습니다.");
}
function onMessage(e){
	data = e.data;
	chatwindow = document.getElementById("chatwindow");
	chatwindow.value = chatwindow.value + data + "\n";
	chatwindow.scrollTop = chatwindow.scrollHeight;
}
// 페이지를 벗어나면 웹소켓에서 연결해제
$(window).on("beforeunload", function(){
	websocket.send(nickname+" 님이 퇴장하셨습니다.");
	websocket.close();
});
</script>
<%@ include file="../include/footer.jsp" %>