package kr.co.lunch;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.lunch.service.MemberService;
import kr.co.lunch.service.RestaurantService;

@Controller
public class RestaurantController {
	@Autowired
	private RestaurantService restaurantService;

	@RequestMapping(value="lunch/select", method=RequestMethod.GET)
	public String select() {
		return "lunch/select";
	}
	
	@RequestMapping(value="lunch/register", method=RequestMethod.GET)
	public String register() {
		return "lunch/register";
	}
	
	@RequestMapping(value="lunch/register", method=RequestMethod.POST)
	public String registerPost(HttpServletRequest request) {
		restaurantService.register(request);
		return "redirect:register";
	}
	
	@RequestMapping(value="lunch/others", method=RequestMethod.GET)
	public String others() {
		return "lunch/others";
	}
	
}
