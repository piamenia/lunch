package kr.co.lunch.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.lunch.domain.Restaurant;

@Repository
public class RestaurantDao {
	@Autowired
	private SqlSession sqlSession;
	
	public List<Restaurant> list(String membercode){
		return sqlSession.selectList("restaurant.list", membercode);
	}
	
	public List<Restaurant> select(Restaurant restaurant){
		return sqlSession.selectList("restaurant.select", restaurant);
	}
	
	public void register(Restaurant restaurant) {
		System.out.println(restaurant);
		sqlSession.insert("restaurant.register", restaurant);
	}
}
