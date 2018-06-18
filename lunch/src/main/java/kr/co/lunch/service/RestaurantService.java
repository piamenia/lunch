package kr.co.lunch.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.co.lunch.domain.Restaurant;

public interface RestaurantService {
	public List<Restaurant> list(HttpServletRequest request);
	public List<Restaurant> select(HttpServletRequest request);
	public void register(HttpServletRequest request);
}
