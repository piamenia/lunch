package kr.co.lunch;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import kr.co.lunch.domain.Restaurant;
import kr.co.lunch.service.MemberService;
import kr.co.lunch.service.RestaurantService;

@RestController
public class JSONController {
	@Autowired
	private MemberService memberService;
	
	
	
	// 이메일 중복체크 요청을 처리
	@RequestMapping(value="member/emailcheck", method=RequestMethod.GET)
	public Map<String, Object> emailChech(HttpServletRequest request, Model modell){
		String email = memberService.emailcheck(request);
		// 리턴할 Map 생성 
		Map<String, Object> map = new HashMap<String, Object>();
		// result라는 키에 email이 null 인지 저장
		// false 면 존재하는 email, true면 존재하지 않는 email
		map.put("result", email==null);
		return map;
	}
	
	@RequestMapping(value="location", method=RequestMethod.GET)
	public Map<String,Object> address(String loc){
		Map<String,Object> map = new HashMap<String, Object>();
		// Service의 주소 가져오는 메소드 호출
		String location = memberService.location(loc);
		map.put("location", location);
		return map;
	}
	
	@RequestMapping(value="member/pwcheck", method=RequestMethod.GET)
	public Map<String, Object> pwcheck(HttpServletRequest request, Model model){
		boolean result = memberService.pwcheck(request);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		return map;
	}
	
	@Autowired
	private RestaurantService restaurantServivce;
	
	@RequestMapping(value="lunch/list", method=RequestMethod.POST)
	public Map<String, Object> list(HttpServletRequest request, Model model){
		// System.out.println("JSONController");
		Map<String, Object> map = new HashMap<>();
		List<Restaurant> list = restaurantServivce.list(request);
		map.put("list", list);
		model.addAttribute("map", map);
		return map;
	}
	
	@RequestMapping(value="lunch/select", method=RequestMethod.POST)
	public Map<String, Object> select(HttpServletRequest request, Model model){
		Map<String, Object> map = new HashMap<>();
		List<Restaurant> list = restaurantServivce.select(request);
		map.put("list", list);
		model.addAttribute("map", map);
		return map;
	}
	
	@RequestMapping(value="lunch/codecheck", method=RequestMethod.POST)
	public Map<String, Object> codecheck(HttpServletRequest request) {
		// System.out.println("코드체크");
		boolean result = memberService.codecheck(request);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		return map;
	}
}
