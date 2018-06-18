package kr.co.lunch.domain;


public class Member {
	private String email, pw, nickname, location, membercode;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getMembercode() {
		return membercode;
	}

	public void setMembercode(String membercode) {
		this.membercode = membercode;
	}

	@Override
	public String toString() {
		return "Member [email=" + email + ", pw=" + pw + ", nickname=" + nickname + ", location=" + location
				+ ", membercode=" + membercode + "]";
	}

}
