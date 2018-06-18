package kr.co.lunch.domain;

public class Reply {
	private int rpcode, bdcode;
	private String rptext, email, nickname, regdate;
	public int getRpcode() {
		return rpcode;
	}
	public void setRpcode(int rpcode) {
		this.rpcode = rpcode;
	}
	public int getBdcode() {
		return bdcode;
	}
	public void setBdcode(int bdcode) {
		this.bdcode = bdcode;
	}
	public String getRptext() {
		return rptext;
	}
	public void setRptext(String rptext) {
		this.rptext = rptext;
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
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "Reply [rpcode=" + rpcode + ", bdcode=" + bdcode + ", rptext=" + rptext + ", email=" + email
				+ ", nickname=" + nickname + ", regdate=" + regdate + "]";
	}
	
}
