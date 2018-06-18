package kr.co.lunch.service;

import javax.servlet.http.HttpServletRequest;

import kr.co.lunch.domain.Member;

public interface MemberService {
	public String emailcheck(HttpServletRequest request);
	public void register(HttpServletRequest request);
	public Member login(HttpServletRequest request);
	public String location(String loc);
	public boolean pwcheck(HttpServletRequest request);
	public boolean update(HttpServletRequest request);
	public boolean findpw(HttpServletRequest request);
	public boolean codecheck(HttpServletRequest request);
}
