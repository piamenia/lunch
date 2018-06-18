<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<section class="content">
	<div class="box">
		<div class="box-body">
			<div class="form-group">
				<label>제목</label> <input type="text" name="subject"
					class="form-control" value="${board.subject}" readonly="readonly" />
			</div>
			<div class="form-group">
				<label>내용</label>
				<textarea name="content" rows="5" readonly="readonly"
					class="form-control">${board.content}</textarea>
			</div>
			<div class="form-group">
				<label>작성자</label> <input type="text" class="form-control"
					value="${board.nickname}" readonly="readonly" />
			</div>
		</div>
		<div id="replydisp"></div>
		<div class="box-footer">
			<button class="btn btn-success" id="mainbtn">메인</button>
			<c:if test="${member.email == board.email}">
				<button class="btn btn-warning" id="updatebtn">수정</button>
				<button class="btn btn-danger" id="deletebtn">삭제</button>
			</c:if>
			<button class="btn btn-info" id="writereply">댓글</button>
			<button class="btn btn-primary" id="listbtn">목록</button>
		</div>
	</div>
</section>
<script>
	//메인 버튼을 눌렀을 때 처리
	document.getElementById("mainbtn").addEventListener("click",function() {
				location.href = "../";
			});
	//목록 버튼을 눌렀을 때 처리
	document.getElementById("listbtn").addEventListener("click",function() {
				location.href = "list?page=${criteria.page}&perPage=${criteria.perPage}";
			});
	<c:if test = "${member.email == board.email}">
		//삭제 버튼을 눌렀을 때 처리
		document.getElementById("deletebtn").addEventListener("click",function() {
			$(function(){
				$("#dialog-confirm").dialog({
					resizable : false,
					height : "auto",
					width : 400,
					modal : true,
					buttons : {
						"삭제" : function() {
							$(this).dialog("close");
							location.href = "delete?bdcode=${board.bdcode}&page=${criteria.page}&perPage=${criteria.perPage}";
						},
						"취소" : function() {
							$(this).dialog("close");
						}
					}
				});
			});
		});
		//수정 버튼을 눌렀을 때 처리
		document.getElementById("updatebtn").addEventListener("click",function() {
					location.href = "update?bdcode=${board.bdcode}&page=${criteria.page}&perPage=${criteria.perPage}";
				});
	</c:if>
	// 댓글 버튼을 눌렀을 때 처리
	document.getElementById("writereply").addEventListener("click",function(){
		$("#replyform").dialog({
			resizable : false,
			height : "auto",
			width : 400,
			modal : true,
			open : function(){
				$("#rptext").focus();
			},
			buttons : {
				"저장" : function(){
					$(this).dialog("close");
					rptext = $("#rptext").val();
					$.ajax({
						url : "../reply/write",
						data : {
							"bdcode" : "${board.bdcode}",
							"email" : "${member.email}",
							"nickname" : "${member.nickname}",
							"rptext" : rptext
						},
						dataType : "json",
						success : function(data){
							getReply();
						}
					})
				},
				"취소" : function(){
					$(this).dialog("close");
					$("#rptext").val("");
				}
			}
		});
	});
	// 댓글이 있다면 댓글출력영역에 댓글출력
	email = "${member.email}";
	<c:if test="${board.rpcnt > 0}">
		$(function(){				
			// 댓글을 썼을 때 다시 호출해야하기 때문에 함수를 만들어서 호출
			getReply();
		});
	</c:if>
	// 댓글 관련 함수
	function getReply(){
		$.ajax({
			url:"../reply/rplist",
			data:{"bdcode" : "${board.bdcode}"},
			dataType:"json",
			success:function(data){
				// 출력하는 함수 호출
				// 하나의 영역에서 코드가 너무 길어지지 않도록 함수를 다시 호출
				display(data);
			}
		});
	};
	function display(data){
		disp = "";
		$(data).each(function(idx,item){
			disp += "<div style='height:46px; border-top:1px solid grey; padding: 5px 0;'>";
			disp += "<label style='height:36px; line-height:36px;'>";
			disp += item.nickname + " : " + item.rptext;
			disp += "</label>";
			if(email==item.email){
				// 삭제버튼 생성
				// 삭제버튼이 여러개 될 수 있기 때문에
				// 버튼의 id를 구분할 수 있는 값으로 만들면 나중에 id로 구분할 수 있음
				// 여기에서는 id를 del댓글번호 가 됨
				disp += "<button class='btn btn-danger' ";
				disp += "id='del"+item.rpcode+"'";
				disp += "style='float:right; margin-left:5px;' onclick='del(this)'>";
				disp += "댓글삭제"
				disp += "</button>";
				// 댓글수정 버튼
				disp += "<button class='btn btn-warning' ";
				disp += "id='mod"+item.rpcode+"'";
				disp += "style='float:right' onclick='mod(this)'>";
				disp += "댓글수정"
				disp += "</button>";
			}
			disp += "</div>";
		});
		// 출력영역에 출력
		document.getElementById("replydisp").innerHTML = disp;
	};
	// 댓글삭제 버튼 눌렀을 때 호출되는 함수
	function del(btn){
		// 댓글번호
		id = btn.id;
		rpcode = id.split("del")[1];
		$("#dialog-confirm").dialog({
			resizable : false,
			height : "auto",
			width : 400,
			modal : true,
			buttons : {
				"삭제" : function() {
					$(this).dialog("close");
					$.ajax({
						url:"../reply/delete",
						data:{"rpcode":rpcode},
						dataType:"json",
						success:function(){
							getReply();
						}
					});
				},
				"취소" : function() {
					$(this).dialog("close");
				}
			}
		});
	};
	// 댓글수정 버튼 눌렀을 때 호출되는 함수
	function mod(btn){
		// 댓글번호
		id = btn.id;
		rpcode = id.split("mod")[1];
		$("#replyform").dialog({
			resizable : false,
			height : "auto",
			width : 400,
			modal : true,
			open : function(){
				$("#rptext").focus();
			},
			buttons : {
				"수정" : function(){
					$(this).dialog("close");
					rptext = $("#rptext").val();
					$.ajax({
						url : "../reply/update",
						data : {
							"rpcode" : rpcode,
							"rptext" : rptext
						},
						dataType : "json",
						success : function(data){
							getReply();
							$("#rptext").val("");
						}
					});
				},
				"취소" : function(){
					$(this).dialog("close");
					$("#rptext").val("");
				}
			}
		});
	};
</script>

<!-- 삭제 대화상자 -->
<div id="dialog-confirm" title="삭제 확인" style="display:none;">
	<p>
		<span class="ui-icon ui-icon-alert" style="float: left; margin: 12px 12px 20px 0;"></span>
		한번 삭제한 자료는 복구할 수 없습니다. 정말 삭제하시겠습니까?
	</p>
</div>

<!-- 댓글쓰기 대화상자 -->
<div class="box-body" style="display:none;" id="replyform">
	<label for="nickname">작성자</label>
	<input class="form-control" type="text" id="nickname" value="${member.nickname }" readonly="readonly"/>
	<label for="rptext">댓글내용</label>
	<input class="form-control" type="text" id="rptext" placeholder="댓글 내용을 작성하세요."/>
</div>

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
<%@ include file="../include/footer.jsp"%>