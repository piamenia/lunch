<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>
<div style="text-align:center">
	<img src="./resources/img/main_img.jpg" width="30%">
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
<%@ include file="include/footer.jsp" %>