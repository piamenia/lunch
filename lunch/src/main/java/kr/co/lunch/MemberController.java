package kr.co.lunch;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.lunch.domain.Member;
import kr.co.lunch.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value="member/register", method=RequestMethod.GET)
	public String register(Model model) {
		return "member/register";
	}
	
	@RequestMapping(value="member/register", method=RequestMethod.POST)
	public String registerPost(HttpServletRequest request, RedirectAttributes attr) {
		memberService.register(request);
		attr.addFlashAttribute("msg","회원가입 되었습니다.");
		return "redirect:/";
	}
	
	@RequestMapping(value="member/login", method=RequestMethod.GET)
	public String login(Model model) {
		return "member/login";
	}
	
	@RequestMapping(value="member/login", method=RequestMethod.POST)
	public String loginPost(HttpServletRequest request, RedirectAttributes attr, HttpSession session) {
		Member member = memberService.login(request);
//		System.out.println("로그인");
		// 로그인 성공여부
		if(member==null) {
//			System.out.println("로그인 실패");
			// 실패하면 다시 로그인화면
			attr.addFlashAttribute("msg", "없는 이메일이거나 비밀번호가 틀렸습니다.");
			return "redirect:login";
		}else {
//			System.out.println("로그인 성공");
			// 성공하면 메인페이지로
			attr.addFlashAttribute("msg", "로그인 되었습니다.");
			session.setAttribute("member", member);
			// 이전요청이 있는지 확인해서 이동페이지를 결정
			Object command = session.getAttribute("command");
			if(command == null) {
				return "redirect:/";
			}else {
				session.removeAttribute("msg");
				return "redirect:/" + command.toString();
			}
			
		}
	}
	
	@RequestMapping(value="member/logout", method=RequestMethod.GET)
	public String logout(HttpServletRequest request, RedirectAttributes attr, HttpSession session) {
		session.invalidate();
		attr.addFlashAttribute("msg", "로그아웃 되었습니다.");
		return "redirect:/";
	}
	
	@RequestMapping(value="member/update", method=RequestMethod.GET)
	public String update(HttpServletRequest request) {
		return "member/update";
	}
	
	@RequestMapping(value="member/update", method=RequestMethod.POST)
	public String updatePost(HttpServletRequest request, RedirectAttributes attr) {
		memberService.update(request);
		request.getSession().invalidate();
		attr.addFlashAttribute("msg", "회원정보가 수정되었습니다.<br>다시 로그인해주세요.");
		return "redirect:login";
	}
	
	@RequestMapping(value="member/findpw", method=RequestMethod.GET)
	public String findpw(HttpServletRequest request, RedirectAttributes attr) {
		memberService.findpw(request);
		attr.addFlashAttribute("msg","임시비밀번호가 이메일로 전송되었습니다.");
		return "redirect:/";
	}
	
	@RequestMapping(value="member/code", method=RequestMethod.GET)
	public String code(HttpServletRequest request) {
		return "member/code";
	}
	
	@RequestMapping(value="member/chat", method=RequestMethod.GET)
	public String chat(HttpServletRequest request) {
		return "member/chat";
	}
	
}
