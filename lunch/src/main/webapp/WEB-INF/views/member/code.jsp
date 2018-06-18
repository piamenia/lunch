<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script src="src/main/webapp/resources/clipboard.min.js"></script>
<div style="width:50%; margin:auto; text-align:center">
	<h3>${member.nickname }님의 코드는 <input onclick="javascript:copy()" type="button" id="code" class="btn btn-info btn-lg" value="${member.membercode }"> 입니다.<br><br>
	버튼을 클릭하면 복사할 수 있습니다.</h3>
</div>
<script>
function copy(){
	window.prompt("복사하려면 Ctrl+C, Enter 를 입력하세요.", '${member.membercode}');
}
</script>
<%@ include file="../include/footer.jsp" %>