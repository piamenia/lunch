package kr.co.lunch.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.lunch.domain.Member;

@Repository
public class MemberDao {
	@Autowired
	private SqlSession sqlSession;
	
	// 이메일중복검사
	public String emailcheck(String email) {
		return sqlSession.selectOne("member.emailcheck", email);
	}
	// 회원가입
	public void register(Member member) {
		sqlSession.insert("member.insert", member);
	}
	// 멤버코드 중복검사
	public String membercodecheck(String membercode) {
		return sqlSession.selectOne("member.membercodecheck",membercode);
	}
	// 데이터 하나 찾아오는 메소드
	public Member getMember(String email) {
		return sqlSession.selectOne("member.getMember", email);
	}
	// 회원정보 수정
	public int update(Member member) {
		return sqlSession.update("member.update", member);
	}
}
