package kr.co.lunch.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.co.lunch.domain.Reply;

public interface ReplyService {
	public boolean write(HttpServletRequest request);
	public List<Reply> rplist(HttpServletRequest request);
	public boolean delete(HttpServletRequest request);
	public boolean update(HttpServletRequest request);
}
