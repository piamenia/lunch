package kr.co.lunch.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.co.lunch.domain.Board;
import kr.co.lunch.domain.Criteria;
import kr.co.lunch.domain.SearchCriteria;

public interface BoardService {
	public Map<String, Object> list(SearchCriteria criteria);
	public void write(HttpServletRequest request);
	public Board detail(HttpServletRequest request);
	public Board updateView(HttpServletRequest request);
	public void update(HttpServletRequest request);
	public void delete(HttpServletRequest request);
}
