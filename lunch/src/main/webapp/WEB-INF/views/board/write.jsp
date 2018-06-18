<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<section class="content">
	<div class="box-header">
		<h3 class="box-title">게시판 글쓰기</h3>
	</div>
	<form role="form" method="post">
		<div class="box-body">
			<div class="form-group">
				<label>제목</label> <input type="text" name='subject'
					class="form-control" placeholder="제목을 입력하세요">
			</div>
			<div class="form-group">
				<label>내용</label>
				<textarea class="form-control" name="content" rows="5"
					placeholder="내용을 입력하세요"></textarea>
			</div>
			<div class="form-group">
				<label>작성자</label> <input type="text" name="nickname"
					value="${member.nickname}" class="form-control" readonly="readonly">
			</div>
		</div>
		<div class="box-footer" style="text-align:center;">
			<button type="submit" class="btn btn-success">작성완료</button>
			<a href="../" class="btn btn-primary">메인으로</a>
			<a href="list" class="btn btn-primary">목록으로</a>
		</div>
	</form>
</section>
<%@include file="../include/footer.jsp"%>