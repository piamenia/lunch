package kr.co.lunch.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
public class AuthenticationInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 로그인 확인
		HttpSession session = request.getSession();
		// 로그인돼있지 않다면
		if(session.getAttribute("member") == null) {
			// 기존 요청 가져오기
			String requestURI = request.getRequestURI();
			String contextPath = request.getContextPath();
			// 기존 요청
			String command = requestURI.substring(contextPath.length()+1);
			// 파라미터
			String query = request.getQueryString();
			// 실제요청주소 만들기
			if(query == null || query.equals("null")) {
				query = "";
			}else {
				query = "?" + query;
			}
			// 세션에 주소 저장하기
			session.setAttribute("command", command + query);
			// 세션에 메시지 저장
			session.setAttribute("msg", "로그인해야 이용할 수 있는 서비스입니다.");
			
			// 로그인페이지로 redirect
			response.sendRedirect(contextPath+"/member/login");
			return false;
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub

	}

}
