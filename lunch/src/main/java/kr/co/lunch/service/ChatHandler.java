package kr.co.lunch.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class ChatHandler extends TextWebSocketHandler {
	// 접속한 클라이언트의 세션을 저장할 Map
	// 1개만 만들어져야하기 떄문에 static
	private static List<WebSocketSession> list = new ArrayList<>();
	
	// 클라이언트가 접속했을 때 호출될 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println(session);
		list.add(session);
	}
	// 클라이언트가 메시지를 전송헀을 때 메소드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 전송된 메시지를 list의 모든 세션에게 전송
		String msg = message.getPayload();
		for(WebSocketSession temp : list) {
			temp.sendMessage(new TextMessage(msg));
		}
	}
	// 클라이언트가 접속을 해제했을 때 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		list.remove(session);
	}

}
