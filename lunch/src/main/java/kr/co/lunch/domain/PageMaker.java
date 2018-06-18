package kr.co.lunch.domain;

public class PageMaker {
	// 전체 데이터 개수, 시작페이지번호, 마지막페이지번호
	private int totalCount, startPage, endPage;
	// 이전과 다음 링크 여부
	private boolean prev, next;
	// 페이지번호 출력개수
	private int displayPageNum = 5;
	// 이전에 설정된 옵션 값을 저장하기 위한 변수
	private SearchCriteria criteria;
	
	@Override
	public String toString() {
		return "PageMaker [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage + ", prev="
				+ prev + ", next=" + next + ", displayPageNum=" + displayPageNum + ", criteria=" + criteria + "]";
	}
	public int getTotalCount() {
		return totalCount;
	}
	
	// 전체데이터 개수, 현제페이지번호, 출력할페이지개수를 알면 전부 계산 가능
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		// 마지막페이지번호
		endPage = (int)(Math.ceil(criteria.getPage()/(double)displayPageNum)) * displayPageNum;
		// 시작페이지번호
		startPage = endPage - displayPageNum + 1;
		
		// 이전 링크 출력여부
		prev = startPage==1 ? false : true;
		// 끝페이지번호는 전체데이터의 페이지개수보다 크면 전체데이터의 페이지개수로 설정
		int pagesu = (int)(Math.ceil(totalCount/(double)criteria.getPerPage()));
		if(endPage > pagesu) {
			endPage = pagesu;
		}
		// 다음 링크 출력여부
		next = endPage == pagesu ? false : true;
		
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}
	public SearchCriteria getCriteria() {
		return criteria;
	}
	public void setCriteria(SearchCriteria criteria) {
		this.criteria = criteria;
	}
}
