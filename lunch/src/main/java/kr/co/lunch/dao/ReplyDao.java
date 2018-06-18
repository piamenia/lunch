package kr.co.lunch.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.lunch.domain.Reply;

@Repository
public class ReplyDao {
	@Autowired
	private SqlSession sqlSession;
	
	public int write(Reply reply) {
		return sqlSession.insert("reply.write", reply);
	}
	
	public List<Reply> rplist(int bdcode) {
		return sqlSession.selectList("reply.rplist", bdcode);
	}
	
	public int delete(int rpcode) {
		return sqlSession.delete("reply.delete", rpcode);
	}
	
	public int update(Reply reply) {
		return sqlSession.update("reply.update", reply);
	}
}
