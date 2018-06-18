package kr.co.lunch.domain;

public class Criteria {
	private int page, perPage, pageStart;
	
	public Criteria() {
		this.page = 1;
		this.perPage = 5;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPage=" + perPage + ", pageStart=" + pageStart + "]";
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPerPage() {
		return perPage;
	}

	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}

	// 페이지번호를 가지고 해당페이지의 시작하는 글 번호를 계산
	public int getPageStart() {
		// 이전페이지까지 * 페이지당 게시물 개수 + 1
		pageStart = (page-1) * perPage + 1;
		return pageStart;
	}

	// 페이지 시작번호는 입력받지 않음
//	public void setPageStart(int pageStart) {
//		this.pageStart = pageStart;
//	}
}
