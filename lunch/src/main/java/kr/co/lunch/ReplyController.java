package kr.co.lunch;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import kr.co.lunch.domain.Reply;
import kr.co.lunch.service.ReplyService;

@RestController
public class ReplyController {
	@Autowired
	private ReplyService replyService;
	
	@RequestMapping(value="reply/write", method=RequestMethod.GET)
	public Map<String, Object> write(HttpServletRequest request) {
//		System.out.println("컨트롤러");
		boolean result = replyService.write(request);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		return map;
	}
	
	@RequestMapping(value="reply/rplist", method=RequestMethod.GET)
	public List<Reply> rplist(HttpServletRequest request){
		return replyService.rplist(request);
	}
	
	@RequestMapping(value="reply/delete", method=RequestMethod.GET)
	public Map<String, Object> delete(HttpServletRequest request){
		boolean result = replyService.delete(request);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		return map;
	}
	
	@RequestMapping(value="reply/update", method=RequestMethod.GET)
	public Map<String, Object> update(HttpServletRequest request){
		boolean result = replyService.update(request);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		return map;
	}
}
