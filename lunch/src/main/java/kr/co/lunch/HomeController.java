package kr.co.lunch;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
//		System.out.println(sqlSession);
		return "home";
	}
	
}
