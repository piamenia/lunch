<%@ page language="java" contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
		<!DOCTYPE html>
		<html>
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>글쓰기</title>
		</head>
		<body>
			<%@ include file="../include/header.jsp"%>
			<section class="center">
				<div class="box box-primary">
					<div class="box-header">
						<h3 class="box-title">게시물 수정</h3>
					</div>
					<form role="form" method="post" id="updateForm">
						<!-- 글번호를 넘겨주기 위해서 숨김 객체로 생성 -->
						<input type="hidden" name="bdcode" value="${board.bdcode}" />
						<div class="box-body">
							<div class="form-group">
								<label>제목</label> <input type="text" name="subject"
									class="form-control" value="${board.subject}" />
							</div>
							<div class="form-group">
								<label>내용</label>
								<textarea name="content" class="form-control"
									placeholder="내용 입력" rows="5">${board.content}</textarea>
							</div>
							<div class="form-group">
								<label>작성자</label> <input type="text" class="form-control"
									value="${board.nickname}" readonly="readonly" />
							</div>
						</div>
						<!-- 현재페이지번호와 페이지당출력개수 -->
						<input type="hidden" name="page" value="${criteria.page}" />
						<input type="hidden" name="perPage" value="${criteria.perPage}" />
					</form>
					<div class="box-footer">
						<button class="btn btn-success" id="updatebtn">수정완료</button>
						<button class="btn btn-warning" id="mainbtn">메인으로</button>
						<button class="btn btn-primary" id="listbtn">목록보기</button>
					</div>
				</div>
				<script>
					//메인 버튼을 눌렀을 때 처리
					document.getElementById("mainbtn").addEventListener("click",function() {
						location.href = "../";
					});
					//목록 버튼을 눌렀을 때 처리
					document.getElementById("listbtn").addEventListener("click",function() {
						location.href = "list";
					});
					//수정 완료 버튼을 눌렀을 때 처리
					document.getElementById("updatebtn").addEventListener("click",function() {
						document.getElementById("updateForm").submit();
					});
				</script>
			</section>
			<%@ include file="../include/footer.jsp"%>
		</body>
		</html>