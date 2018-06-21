package kr.co.lunch.interceptor;

import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import kr.co.lunch.domain.Member;

@Component
public class LoginInterceptor implements HandlerInterceptor {
	@Autowired
	private ServletContext servletContext;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		String method = request.getMethod();
		if(method.equals("POST")) {
			//System.out.println("인터셉터");
			// 로그인 됐는지 확인
			HttpSession session = request.getSession();
			Member member = (Member)session.getAttribute("member");
			if(member != null) {
				//System.out.println("로그인됨");
				// 로그인한 사람 닉네임
				String nickname = member.getNickname();
				// 현재시간
				Calendar cal = Calendar.getInstance();
				Date date = new Date(cal.getTimeInMillis());
				// 접속한 ip
				String ip = request.getRemoteAddr();
				
				// 기록할 파일의 절대경로
				String filePath = servletContext.getRealPath("resources/login_log.txt");
//				System.out.println(filePath);
				// 파일을 문자열에 기록하기 - 파일이 존재하면 이어쓰기
				FileOutputStream fos = new FileOutputStream(filePath, true);
				// 문자열을 기록할 수 있는 writer
				PrintWriter pw = new PrintWriter(fos);
//				System.out.println(pw);
				// 파일에 기록하기
				pw.println(nickname + " " + date.toString() + " " + ip);
				pw.flush();
				pw.close();
			}
		}
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub

	}

}
