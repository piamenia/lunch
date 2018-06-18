package kr.co.lunch;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.lunch.domain.Board;
import kr.co.lunch.domain.Criteria;
import kr.co.lunch.domain.SearchCriteria;
import kr.co.lunch.service.BoardService;

@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value="board/list", method=RequestMethod.GET)
	public String list(Model model, SearchCriteria criteria) {
		model.addAttribute("map", boardService.list(criteria));
		return "board/list";
	}
	
	@RequestMapping(value="board/write", method=RequestMethod.GET)
	public String write() {
		return "board/write";
	}
	
	@RequestMapping(value="board/write", method=RequestMethod.POST)
	public String writePost(HttpServletRequest request, RedirectAttributes attr, Model model) {
		boardService.write(request);
		attr.addFlashAttribute("msg", "게시글이 작성되었습니다.");
//		int bdcode = Integer.parseInt(request.getParameter("bdcode"));
		return "redirect:list";
//		return "redirect:detail?bdcode=" + bdcode;
	}
	
	@RequestMapping(value="board/detail", method=RequestMethod.GET)
	public String detail(HttpServletRequest request, Model model, SearchCriteria criteria) {
		Board board = boardService.detail(request);
		model.addAttribute("board", board);
		model.addAttribute("criteria", criteria);
		return "board/detail";
	}
	
	@RequestMapping(value="board/update", method=RequestMethod.GET)
	public String updateView(HttpServletRequest request, Model model) {
		Board board = boardService.updateView(request);
		model.addAttribute("board", board);
		return "board/update";
	}
	
	@RequestMapping(value="board/update", method=RequestMethod.POST)
	public String update(HttpServletRequest request, RedirectAttributes attr, SearchCriteria criteria) {
		boardService.update(request);
		attr.addFlashAttribute("msg", "게시글이 수정되었습니다.");
		int bdcode = Integer.parseInt(request.getParameter("bdcode"));
		return "redirect:detail?bdcode="+bdcode + "&page="+criteria.getPage() + "&perPageNum="+criteria.getPerPage();
	}
	
	@RequestMapping(value="board/delete", method=RequestMethod.GET)
	public String delete(HttpServletRequest request, RedirectAttributes attr, SearchCriteria criteria) {
		boardService.delete(request);
		attr.addFlashAttribute("msg", "게시글이 삭제되었습니다.");
		return "redirect:list?page="+criteria.getPage() + "&perPageNum="+criteria.getPerPage();
	}
}
