package kr.co.lunch.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.lunch.domain.Board;
import kr.co.lunch.domain.Criteria;
import kr.co.lunch.domain.SearchCriteria;

@Repository
public class BoardDao {
	@Autowired
	private SqlSession sqlSession;
	
	public List<Board> list(SearchCriteria criteria){
		return sqlSession.selectList("board.list", criteria);
	}
	
	public void write(Board board) {
		sqlSession.insert("board.write", board);
	}
	
	public void readcnt(int bdcode) {
		sqlSession.update("board.readcnt", bdcode);
	}
	
	public Board detail(int bdcode) {
		return sqlSession.selectOne("board.detail", bdcode);
	}
	
	public void update(Board board) {
		sqlSession.update("board.update", board);
	}
	
	public void delete(int bdcode) {
		sqlSession.delete("board.delete", bdcode);
	}
	
	public int totalCount(SearchCriteria criteria) {
		return sqlSession.selectOne("board.totalCount", criteria);
	}
	
	public int replyCount(int bdcode) {
		return sqlSession.selectOne("board.replyCount", bdcode);
	}
}
