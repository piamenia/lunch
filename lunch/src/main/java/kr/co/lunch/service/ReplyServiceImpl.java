package kr.co.lunch.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.lunch.dao.ReplyDao;
import kr.co.lunch.domain.Reply;

@Service
public class ReplyServiceImpl implements ReplyService {
	@Autowired
	private ReplyDao replyDao;

	@Override
	public boolean write(HttpServletRequest request) {
//		System.out.println("서비스");
		boolean result = false;
		String rptext = request.getParameter("rptext");
		int bdcode = Integer.parseInt(request.getParameter("bdcode"));
		String email = request.getParameter("email");
		String nickname = request.getParameter("nickname");
		
		Reply reply = new Reply();
		reply.setRptext(rptext);
		reply.setBdcode(bdcode);
		reply.setEmail(email);
		reply.setNickname(nickname);
		System.out.println(reply);
		
		int r = replyDao.write(reply);
		if(r > 0) {
			result = true;
		}
		return result;
	}

	@Override
	public List<Reply> rplist(HttpServletRequest request) {
		int bdcode = Integer.parseInt(request.getParameter("bdcode"));
		return replyDao.rplist(bdcode);
	}

	@Override
	public boolean delete(HttpServletRequest request) {
		boolean result = false;
		int rpcode = Integer.parseInt(request.getParameter("rpcode"));
		int r = replyDao.delete(rpcode);
		if(r > 0) {
			result = true;
		}
		return result;
	}

	@Override
	public boolean update(HttpServletRequest request) {
		boolean result = false;
		int rpcode = Integer.parseInt(request.getParameter("rpcode"));
		String rptext = request.getParameter("rptext");
		Reply reply = new Reply();
		reply.setRpcode(rpcode);
		reply.setRptext(rptext);
		int r = replyDao.update(reply);
		if(r > 0) {
			result = true;
		}
		return result;
	}
}
