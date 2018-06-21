package kr.co.lunch.service;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import kr.co.lunch.dao.MemberDao;
import kr.co.lunch.domain.Member;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDao memberDao;
	
	@Override
	public String emailcheck(HttpServletRequest request) {
		// 파라미터
		String email = request.getParameter("email");
		return memberDao.emailcheck(email);
	}
	
	
	@Override
	public void register(HttpServletRequest request) {
		// 파라미터 읽기
		String email = request.getParameter("email");
		String pw = request.getParameter("pw");
		String nickname = request.getParameter("nickname");
		
		// Dao의 파라미터 만들기
		Member member = new Member();
		try {
			member.setEmail(email);
			// 패스워드는 암호화해서 저장
			member.setPw(BCrypt.hashpw(pw, BCrypt.gensalt(10)));
			member.setNickname(nickname);
			// 사용자코드 만들기
			StringBuilder temp = new StringBuilder();
			String membercode = "";
			Random rnd = new Random();
			while(true) {
				for (int i = 0; i < 6; i = i + 1) {
					int lowUpper = rnd.nextInt(2);
					switch (lowUpper) {
					case 0:
						// 소문자
						temp.append((char) ((int) (rnd.nextInt(26)) + 97));
						break;
					case 1:
						// 대문자
						temp.append((char) ((int) (rnd.nextInt(26)) + 65));
						break;
					}
				}
				membercode = temp.toString(); 
				// 사용자코드 중복검사
				if(memberDao.membercodecheck(membercode)==null) {
					break;
				} else {
					temp = new StringBuilder();
				}
			}
			member.setMembercode(membercode);

			//Dao의 메소드 호출
			memberDao.register(member);
		} catch (Exception e) {
			System.out.println("회원가입 실패"+e.getMessage());
			e.printStackTrace();
		}
	}

	@Override
	public Member login(HttpServletRequest request) {
		// 파라미터 읽기
		String email = request.getParameter("email");
		String pw = request.getParameter("pw");
		
		// Dao의 메소드 호출
		Member member = memberDao.getMember(email);
		if(member != null) {
			// 비밀번호 비교
			if(BCrypt.checkpw(pw, member.getPw())){
				// 로그인정보에서 비밀번호는 제거
				member.setPw("");
			}else {
				// 비밀번호가 다르면 모두 초기화
				member = null;
			}
		}
		return member;
	}

	@Override
	public String location(String loc) {
		String[] ar = loc.split("-");
		String lat = ar[0];
		String lng = ar[1];
		String addr =
			"https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?"
			+ "x=" + lng + "&y=" + lat;
//		System.out.println(addr);
		try {
			// 위의 주소를 가지고 URL객체 생성
			URL url = new URL(addr);
			// URL 객체를 가지고 HttpConnection 객체 생성
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			// 인증받기
			// 카카오 좌표 -> 주소 변환에서 키 가져와서 등록
			con.setRequestProperty("Authorization", "KakaoAK 94a7a9300a2a7035a3de0d40bcb493ec");
			// 옵션 설정
			con.setConnectTimeout(10000);
			con.setUseCaches(false);
			// 데이터를 줄단위로 읽기
			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			StringBuilder sb = new StringBuilder();
			while(true) {
				String line = br.readLine();
				if(line==null) {
					break;
				}
				sb.append(line);
			}
			br.close();
			con.disconnect();
//			System.out.println(sb);
			
			// JSONObject 생성
			JSONObject obj = new JSONObject(sb.toString());
//			System.out.println(obj);
			JSONArray array = obj.getJSONArray("documents");
//			System.out.println(array);
			JSONObject obj0 = array.getJSONObject(0);
			String location = obj0.getString("address_name");
//			System.out.println(address);
			return location;
			
		}catch(Exception e) {
			System.out.println("주소 가져오기 실패: "+e.getMessage());
			e.printStackTrace();
		}
		return null;
	}	
	
	@Override
	public boolean pwcheck(HttpServletRequest request) {
		boolean result = false;
		
		String email = request.getParameter("email");
		String pw = request.getParameter("pw");
		
		Member member = memberDao.getMember(email);
		if(member != null) {
			// 비밀번호 비교
			if(BCrypt.checkpw(pw, member.getPw())){
				// 비밀번호가 맞다면 true를 리턴
				result = true;
			}else {
				// 비밀번호가 틀렸다면 false를 리턴
			}
		}
		return result;
	}

	@Override
	public boolean update(HttpServletRequest request) {
		boolean result = false;
		
		// 파라미터 읽기
		String email = request.getParameter("email");
		String nickname = request.getParameter("nickname");
		String newpw = request.getParameter("newpw");
		
		// Dao의 파라미터 만들기
		Member member = new Member();
		// 패스워드는 암호화해서 저장
		member.setEmail(email);
		member.setNickname(nickname);
		member.setPw(BCrypt.hashpw(newpw, BCrypt.gensalt(10)));
	
		//Dao의 메소드 호출
		int r = memberDao.update(member);
		if(r>0) result = true;
		
		return result;
	}

	@Autowired
	private JavaMailSender mailSender;

	@Override
	public boolean findpw(HttpServletRequest request) {
		boolean result = false;
		String email = request.getParameter("email");
		String newpw = "";
		try {
			// 임시 비밀번호 만들기 - 8자리 소대문자,숫자
			StringBuilder temp = new StringBuilder();
			Random rnd = new Random();
			for (int i = 0; i < 8; i = i + 1) {
				int cases = rnd.nextInt(3);
				switch (cases) {
				case 0:
					// 소문자
					temp.append((char) ((int) (rnd.nextInt(26)) + 97));
					break;
				case 1:
					// 대문자
					temp.append((char) ((int) (rnd.nextInt(26)) + 65));
					break;
				case 2:
					// 숫자
					temp.append((char) ((int) (rnd.nextInt(10)) + 48));
					break;
				}
				System.out.println(temp);
			}
			newpw = temp.toString();
		}catch(Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		Member member = memberDao.getMember(email);
		member.setPw(BCrypt.hashpw(newpw, BCrypt.gensalt(10)));
		int r = memberDao.update(member);
		if(r>0) result = true;
		
		String title = "임시비밀번호를 발급했습니다. 비밀번호를 변경해서 사용하세요.";
		String contents = "임시비밀번호는 "+ newpw +" 입니다."
				+ "<br>"
				+ "반드시 비밀번호를 다시 변경해서 사용하세요."
				+ "<br>"
//				+ "<a href=\"http://127.0.0.1:8989/lunch/member/update\">비밀번호 변경하러 가기</a>";
				+ "<a href=\"http://182.222.11.113:8080/lunch/member/update\">비밀번호 변경하러 가기</a>";
		
		try {
			// 매일보내기 객체
			MimeMessage message = mailSender.createMimeMessage();
			message.setFrom(new InternetAddress("lunch00lunch@gmail.com"));
			// 받는사람
			message.setRecipient(RecipientType.TO, new InternetAddress(email));
			// 제목
			message.setSubject(title);
			// 내용
			message.setContent(contents, "text/html; charset=UTF-8");
			// 메일 보내기
			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		
		return result;
	}


	@Override
	public boolean codecheck(HttpServletRequest request) {
		boolean result = false;
		String membercode = request.getParameter("membercode");
		if(memberDao.membercodecheck(membercode)==null) {
			result = false;
		}else{
			result = true;
		};
		return result;
	}

	@Autowired
	private ServletContext servletContext;
	
	@Override
	public Map<String, Object> loginlog() {
		Map<String, Object> map = new HashMap<>();
		try {
			// 로그파일 읽기
			BufferedReader br = new BufferedReader(new FileReader(servletContext.getRealPath("/resources/login_log.txt")));
			while(true) {
				String line = br.readLine();
				if(line == null) {
					break;
				}
				String[] ar = line.split(" ");
				String nickname = ar[0];
				if(map.get(nickname)==null) {
					map.put(nickname, 1);
				}else {
					map.put(nickname, (int)map.get(nickname)+1);
				}
			}
		} catch(Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return map;
	}
}
