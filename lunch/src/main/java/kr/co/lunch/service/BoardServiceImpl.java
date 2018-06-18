package kr.co.lunch.service;

import java.sql.Date;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.lunch.dao.BoardDao;
import kr.co.lunch.domain.Board;
import kr.co.lunch.domain.Criteria;
import kr.co.lunch.domain.Member;
import kr.co.lunch.domain.PageMaker;
import kr.co.lunch.domain.SearchCriteria;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDao boardDao;

	@Override
	public Map<String, Object> list(SearchCriteria criteria) {
//		System.out.println(criteria);
		Map<String, Object> map = new HashMap<>();
		// 오늘 작성된 글은 시간, 이전에 작성된 글은 날짜를 표시
		List<Board> list = boardDao.list(criteria);
		// 마지막 페이지에 있는 데이터가 1개밖에 없을 때 그 데이터를 삭제하면 그 페이지의 데이터가 없음
		if(list.size() == 0) {
			// 현재 페이지번호를 1 감소시켜서 데이터를 다시 가져와야함
			criteria.setPage(criteria.getPage()-1);
			list = boardDao.list(criteria);
		}
		
		// 오늘 날짜
		Calendar cal = Calendar.getInstance();
		Date today = new Date(cal.getTimeInMillis());
		
		// list의 데이터를 확인해서 날짜와 시간 저장
		for(Board board : list) {
			// 날짜
			String regdate = board.getRegdate().split(" ")[0];
			// 글쓴 날짜와 오늘 날짜가 같으면
			if(today.toString().equals(regdate)) {
				board.setDispdate(board.getRegdate().split(" ")[1].substring(0, 5));
			}else {
				board.setDispdate(regdate);
			}
			board.setRpcnt(boardDao.replyCount(board.getBdcode()));
		}
		map.put("list", list);
		
		// 페이지번호 목록
		PageMaker pageMaker = new PageMaker();
		// 현재페이지와 페이지당 목록개수 저장
		pageMaker.setCriteria(criteria);
		// 전체데이터개수 저장
		pageMaker.setTotalCount(boardDao.totalCount(criteria));
		// 맵에 저장
		map.put("pageMaker", pageMaker);
//		System.out.println(pageMaker);
		return map;
	}

	@Override
	public void write(HttpServletRequest request) {
		// 파라미터 읽기
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		// ip 가져오기
		String ip = request.getRemoteAddr();
		// 게시글을 쓰는(로그인 한) 사용자 정보
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute("member");
//		System.out.println(member);
		String email = member.getEmail();
		String nickname = member.getNickname();
		
		// Dao의 매개변수 만들기
		Board board = new Board();
		board.setSubject(subject);
		board.setContent(content);
		board.setIp(ip);
		board.setEmail(email);
		board.setNickname(nickname);
//		System.out.println(board);
		
		// Dao의 메소드 호출
		boardDao.write(board);
	}

	@Override
	public Board detail(HttpServletRequest request) {
		int bdcode = Integer.parseInt(request.getParameter("bdcode"));
		boardDao.readcnt(bdcode);
		Board board = boardDao.detail(bdcode);
		board.setRpcnt(boardDao.replyCount(bdcode));
		return board;
	}

	@Override
	public Board updateView(HttpServletRequest request) {
		int bdcode = Integer.parseInt(request.getParameter("bdcode"));
		return boardDao.detail(bdcode);
	}

	@Override
	public void update(HttpServletRequest request) {
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		String ip = request.getRemoteAddr();
		int bdcode = Integer.parseInt(request.getParameter("bdcode"));
		
		Board board = new Board();
		board.setSubject(subject);
		board.setContent(content);
		board.setIp(ip);
		board.setBdcode(bdcode);
		
		boardDao.update(board);
	}

	@Override
	public void delete(HttpServletRequest request) {
		int bdcode = Integer.parseInt(request.getParameter("bdcode"));
		boardDao.delete(bdcode);
	}
}
