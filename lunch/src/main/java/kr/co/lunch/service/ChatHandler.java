package kr.co.lunch.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class ChatHandler extends TextWebSocketHandler {
	// 접속한 클라이언트의 세션을 저장할 List
	// 1개만 만들어져야하기 때문에 static
//	private static List<WebSocketSession> list = new ArrayList<>();
	// 닉네임과 세션을 모두 저장할 수 있게 Map의 List로 변경
	private static List<Map<String,Object>> list = new ArrayList<>();
	
	// 클라이언트가 접속했을 때 호출될 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//System.out.println(session);
		// 접속했을 때 리스트를 저장하지 않고 구분메시지를 받아서 저장
//		list.add(session);
	}
	
	// 클라이언트가 메시지를 전송했을 때 메소드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String msg = message.getPayload();
		// 받은 메시지가 접속자화면에 표시하기 위한 메시지인지 채팅메시지인지 구분
		int a = msg.indexOf("!!");
		// 접속자화면에 표시하기위한 메시지라면
		if(a >= 0) {
			// map 에 닉네임과 세션을 저장하고 list에 저장
			String nickname = msg.split("!!")[1];
			Map<String, Object> map = new HashMap<>();
			map.put("session", session);
			map.put("nickname", nickname);
			list.add(map);
//			System.out.println(list);
			// 저장했으면 리스트에 저장된 닉네임에 구분할 수 있는 기호를 붙여서 모든 세션에게 전송
			// 모든 리스트를 순회하면서
			for(int i=0; i<list.size(); i++) {
				// 해당하는 맵의 세션
				Map<String, Object> tempmap1 = list.get(i);
				WebSocketSession wss = (WebSocketSession)tempmap1.get("session");
				// 모든 리스트를 순회하면서
				for(int j=0;j<list.size(); j++) {
					// 해당하는 맵의 닉네임
					Map<String, Object> tempmap2 = list.get(j);
					String client = (String)tempmap2.get("nickname");
					// 을 각 세션에게 전송
					wss.sendMessage(new TextMessage("!!"+client));
				}
			}
		}
		// 채팅메시지라면
		else {
			// 전송된 메시지를 list의 모든 세션에게 전송
			for(int i=0; i<list.size(); i++) {
				Map<String, Object> temp = list.get(i);
				WebSocketSession wss = (WebSocketSession)temp.get("session");
				wss.sendMessage(new TextMessage(msg));
			}
		}
	}
	
	// 클라이언트가 접속을 해제했을 때 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// System.out.println(list);
		// 접속 종료한 세션의 닉네임을 저장할 변수
		String nickname = "";
		// 리스트에서 세션을 제거
		for(int i=0; i<list.size(); i++) {
			Map <String, Object> map = list.get(i);
			WebSocketSession wss = (WebSocketSession)map.get("session");
			// 접속종료한 세션의 닉네임 저장
			nickname = (String)map.get("nickname");
			if(wss.getId() == session.getId()) {
				list.remove(map);
			}
		}
		// System.out.println("삭제후 "+ list);
		// 나머지 세션에게 삭제된 세션의 닉네임을 구분기호와 함께 전송
		for(int i=0; i<list.size(); i++) {
			Map <String, Object> map = list.get(i);
			WebSocketSession wss = (WebSocketSession)map.get("session");
			String msg = "@@" + nickname;
			wss.sendMessage(new TextMessage(msg));
		}
//		list.remove(session);
	}

}
