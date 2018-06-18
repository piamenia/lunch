package kr.co.lunch.domain;

public class Board {
	private String subject, content, ip, email, nickname;
	private int bdcode, readcnt;
	// 날짜는 문자열로 사용하는게 편함
	private String regdate;
	// 날짜 출력을 위한 변수
	private String dispdate;
	// 댓글 개수를 저장하는 변수
	private int rpcnt;
	
	@Override
	public String toString() {
		return "Board [subject=" + subject + ", content=" + content + ", ip=" + ip + ", email=" + email + ", nickname="
				+ nickname + ", bdcode=" + bdcode + ", readcnt=" + readcnt + ", regdate=" + regdate + ", dispdate="
				+ dispdate + ", rpcnt=" + rpcnt + "]";
	}
	public int getRpcnt() {
		return rpcnt;
	}
	public void setRpcnt(int rpcnt) {
		this.rpcnt = rpcnt;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getBdcode() {
		return bdcode;
	}
	public void setBdcode(int bdcode) {
		this.bdcode = bdcode;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getDispdate() {
		return dispdate;
	}
	public void setDispdate(String dispdate) {
		this.dispdate = dispdate;
	}}
