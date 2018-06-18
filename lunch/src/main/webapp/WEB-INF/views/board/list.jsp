<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<div class="box">
	<!-- 페이지당 출력개수 설정하는 select -->
	<div class="box-header with-border">
		<span>
			<select id="count" class="form-control" style="width:20%; display:inline-block">
				<option value="5" <c:out value="${map.pageMaker.criteria.perPage==5?'selected':''}"/>>
					5개씩 보기
				</option>
				<option value="10" <c:out value="${map.pageMaker.criteria.perPage==10?'selected':''}"/>>
					10개씩 보기
				</option>
				<option value="15" <c:out value="${map.pageMaker.criteria.perPage==15?'selected':''}"/>>
					15개씩 보기
				</option>
				<option value="20" <c:out value="${map.pageMaker.criteria.perPage==20?'selected':''}"/>>
					20개씩 보기
				</option>
			</select>
		</span>
		<span style="float:right; width:60%; text-align:right">
			<!-- 검색폼 -->
			<select name="searchType" id="searchType" class="form-control" style="display:inline; width:25%">
				<option value="n"
				 <c:out value="${map.pageMaker.criteria.searchType==null?'selected':'' }"/>
				>--</option>
				<option value="t"
				 <c:out value="${map.pageMaker.criteria.searchType==t?'selected':'' }"/>
				>제목</option>
				<option value="c"
				 <c:out value="${map.pageMaker.criteria.searchType==c?'selected':'' }"/>
				>내용</option>
				<option value="tc"
				 <c:out value="${map.pageMaker.criteria.searchType==tc?'selected':'' }"/>
				>제목+내용</option>
			</select>
			<input type="text" name="keyword" id="keyword" value="${map.pageMaker.criteria.keyword }" class="form-control" style="display:inline; width:30%"/>
			<input type="button" value="검색" id="searchbtn" class="btn btn-primary form-control" style="display:inline; width:auto">
		</span>
	</div>
	<div class="box-body" style="margin-top:10px">
		<table class="table table-bordered table-hover">
			<tr>
				<th width="7%">글번호</th>
				<th width="67%">제목</th>
				<th width="8%">작성자</th>
				<th width="10%">작성일</th>
				<th width="8%">조회수</th>
			</tr>
			<c:forEach var="board" items="${map.list }">
				<tr>
					<td align="center">${board.bdcode}</td>
					<td>
						<a href="detail?bdcode=${board.bdcode}&page=${map.pageMaker.criteria.page}&perPage=${map.pageMaker.criteria.perPage}&searchType=${map.pageMaker.criteria.searchType}&keyworkd=${map.pageMaker.criteria.keyword}"
						style="display:block"
						>${board.subject}
						<span class="badge bg-blue">[${board.rpcnt }]</span>
						<c:if test="${board.rpcnt >= 5 }">
							<img src="../resources/img/hot_icon.png" height="25px">
						</c:if>
						</a>
					</td>
					<td align="center">${board.nickname}</td>
					<td align="center">${board.dispdate}</td>
					<td align="right">${board.readcnt}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div class="box-footer">
		<div class="text-center">
			<button id='mainBtn' class="btn btn-primary">메인으로</button>
			<c:if test="${member!=null }">
				<button id='write' class="btn btn-success">글쓰기</button>							
			</c:if>
			<!-- 페이지 번호 출력영역 -->
			<div class="box-footer text-center">
				<ul class="pagination">
					<c:if test="${map.pageMaker.totalCount > 0 }">
						<!-- 이전링크 -->
						<c:if test="${map.pageMaker.prev }">
							<li></li>
						</c:if>
						<!-- 페이지번호 -->
						<c:forEach var="idx" begin="${map.pageMaker.startPage }" end="${map.pageMaker.endPage }">
							<li
							<c:out value="${map.pageMaker.criteria.page==idx?'class=active':'' }"/>
							><a href="list?page=${idx }&perPage=${map.pageMaker.criteria.perPage}&searchType=${map.pageMaker.criteria.searchType}&keyworkd=${map.pageMaker.criteria.keyword}">${idx }</a></li>
						</c:forEach>
						<!-- 다음 링크 -->
						<c:if test="${map.pageMaker.next }">
							<li><a href="list?page=${map.pageMaker.endPage+1}&perPage=${map.pageMaker.criteria.perPage}&searchType=${map.pageMaker.criteria.searchType}&keyworkd=${map.pageMaker.criteria.keyword}">다음</a></li>
						</c:if>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</div>
<script>
	$(function() {
		$('#mainBtn').on("click", function(event) {
			location.href = "../";
		});
		$("#write").on("click", function(){
			location.href = "write";
		});
	});
	// 출력개수 선택했을 때
	document.getElementById("count").addEventListener("change",function(){
		location.href = 'list?page=${map.pageMaker.criteria.page}&perPage=' + this.value + "&searchType=" + searchType + "&keyworkd=" + keyword;
	});
	// 검색버튼 눌렀을 때
	document.getElementById("searchbtn").addEventListener("click",function(){
		// select의 선택된 항목 찾아오기
		// 선택된 행번호
		x = document.getElementById("searchType").selectedIndex;
		// select의 모든 값을 배열로 가져오기
		y = document.getElementById("searchType").options;
		// keyword에 입력된 값
		keyword = document.getElementById("keyword").value;
		
		location.href = "list?page=1&perPageNum=${map.pageMaker.criteria.perPage}&searchType=" + y[x].value + "&keyword=" + keyword;
	});
</script>
<style>
.table th {
	text-align: center;
}
</style>

<!-- 메시지 대화상자 -->
<c:if test="${msg != null}">
<div id="dialog-message" title="" style="display:none">
	<p>
		<span class="ui-icon ui-icon-circle-check"
			style="float: left; margin: 0 7px 50px 0;"></span> ${msg}
	</p>
</div>
<script>
	$(function() {
		$("#dialog-message").dialog({
			modal : true,
			buttons : {
				Ok : function() {
					$(this).dialog("close");
				}
			}
		});
	});
</script>
</c:if>
<%@include file="../include/footer.jsp"%>