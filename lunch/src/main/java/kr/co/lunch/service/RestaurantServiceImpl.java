package kr.co.lunch.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.lunch.dao.RestaurantDao;
import kr.co.lunch.domain.Restaurant;

@Service
public class RestaurantServiceImpl implements RestaurantService {
	@Autowired
	private RestaurantDao restaurantDao;

	@Override
	public List<Restaurant> list(HttpServletRequest request) {
		String membercode = request.getParameter("membercode");
//		System.out.println(membercode);
		return restaurantDao.list(membercode);
	}
	
	@Override
	public List<Restaurant> select(HttpServletRequest request) {
		Restaurant restaurant = new Restaurant();
		
		String membercode = request.getParameter("membercode");
		String foodstyle = request.getParameter("foodstyle");
		int distance = Integer.parseInt(request.getParameter("distance"));
		int tasty = Integer.parseInt(request.getParameter("tasty"));
		int price = Integer.parseInt(request.getParameter("price"));
		
		restaurant.setMembercode(membercode);
		restaurant.setFoodstyle(foodstyle);
		restaurant.setDistance(distance);
		restaurant.setTasty(tasty);
		restaurant.setPrice(price);
		
		return restaurantDao.select(restaurant);
	}

	@Override
	public void register(HttpServletRequest request) {
		String rstname = request.getParameter("rstname");
		String foodstyle = request.getParameter("foodstyle");
		int distance = Integer.parseInt(request.getParameter("distance"));
		int tasty = Integer.parseInt(request.getParameter("tasty"));
		int price = Integer.parseInt(request.getParameter("price"));
		String description = request.getParameter("description");
		String membercode = request.getParameter("membercode");
		
		// totalscore 구하기
		// 거리, 맛, 가격대를 각 5점만점으로 받기 때문에 3가지 점수의 평균으로
		double totalscore = (distance + tasty + price) / 3.0;
		
		Restaurant restaurant = new Restaurant();
		restaurant.setRstname(rstname);
		restaurant.setFoodstyle(foodstyle);
		restaurant.setDistance(distance);
		restaurant.setTasty(tasty);
		restaurant.setPrice(price);
		restaurant.setDescription(description);
		restaurant.setMembercode(membercode);
		restaurant.setTotalscore(totalscore);
		
		restaurantDao.register(restaurant);
	}
}
