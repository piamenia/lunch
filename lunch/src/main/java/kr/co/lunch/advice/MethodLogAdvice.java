package kr.co.lunch.advice;

import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletContext;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class MethodLogAdvice {
//	public MethodLogAdvice() {
//		System.out.println("AOP");
//	}
	@Autowired
	private ServletContext servletContext;
	// public 으로 접근할 수 있는
	// * 모든 리턴타입의
	// kr.co.lunch..*Service. kr.co.lunch 패키지 안에 있는 모든 Service로 끝나는 클래스의
	// * 모든 메소드의
	// (..) 매개변수에 상관없이
	// 동작하는 adivce
	@Around("execution(public * kr.co.lunch..*Service.*(..))")
	public Object invoke(ProceedingJoinPoint joinPoint) throws Throwable {
//		System.out.println("AOP");
		// 현재 시간
		Calendar cal = Calendar.getInstance();
		Date date = new Date(cal.getTimeInMillis());
		// 메소드 이름
		String method = joinPoint.getSignature().toLongString();
		
		// 기록할 파일의 절대경로
		String filePath = servletContext.getRealPath("resources/method_log.txt");
		// 파일을 문자열에 기록하기 - 파일이 존재하면 이어쓰기
		FileOutputStream fos = new FileOutputStream(filePath, true);
		// 문자열을 기록할 수 있는 writer
		PrintWriter pw = new PrintWriter(fos);
		// 파일에 기록하기
		pw.println(method + " " + date.toString());
		pw.flush();
		pw.close();
		
		// pointcut
		Object obj = joinPoint.proceed();
		
		return obj;
	}
}
